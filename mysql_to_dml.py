# -*- coding: utf-8 -*-
# 将/mysql/src 文件夹中*.sql文件中的select数据转化为insert数据，并输出到/mysql/target 文件夹中
# 用法：python mysql_to_dml.py
# 作者：swan-geese
# 日期：2023-09-28
# 版本：1.0

import mysql.connector
import re
import os
import yaml
import glob
import json

def read_sql_from_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def extract_database_table(sql):
    # 使用正则表达式提取数据库和表名，假设格式为`database`.`table`
    match = re.search(r'`(.+?)`\.`(.+?)`', sql)
    if match:
        return match.group(1), match.group(2)
    else:
        return None, None

def is_json(value):
    try:
        json.loads(value)
        return True
    except (json.JSONDecodeError, TypeError):
        return False

def try_json_loads(value):
    try:
        return json.dumps(json.loads(value), ensure_ascii=False)
    except (json.JSONDecodeError, TypeError):
        return value

def generate_insert_statement(data, database, table_name):
    columns = ", ".join(data.keys())
    values = []

    for key, value in data.items():
        if isinstance(value, (bytes, bytearray)):
            # Convert byte array to a string
            value_str = value.decode('utf-8') if isinstance(value, bytes) else value.decode('utf-8')
            values.append(f"'{try_json_loads(value_str)}'")
        elif isinstance(value, str):
            # 转义字符串中的特殊字符
            value_str = value.replace("\\", "\\\\").replace('"', '\\"').replace('\'', '\\\'')
            # For strings, check if it's JSON and handle accordingly
            values.append(f"'{try_json_loads(value_str)}'")
        elif value is None:
            values.append('NULL')
        else:
            values.append(f"'{value}'")

    values_str = ", ".join(values)
    return f"INSERT INTO `{database}`.`{table_name}` ({columns}) VALUES ({values_str});"



def process_sql(sql, cursor, target_folder, database_configs):
    cursor.execute(sql)
    rows = cursor.fetchall()

    database, table = extract_database_table(sql)
    if not database or not table:
        print(f"Failed to extract database and table from: {sql}")
        return

    target_file_path = os.path.join(target_folder, f"{database}.sql")

    with open(target_file_path, 'a', encoding='utf-8') as target_file:
        for row in rows:
            data = dict(zip(cursor.column_names, row))
            insert_statement = generate_insert_statement(data, database, table)
            target_file.write(insert_statement + '\n')

def main(path):
    # 读取MySQL连接配置
    with open(path + 'src/host.yaml', 'r') as host_file:
        host_config = yaml.safe_load(host_file)['mysql']

    # 查找目标目录下的所有.sql文件
    sql_files = glob.glob(os.path.join(path + '/src', '*.sql'))

    # 遍历每个.sql文件
    for sql_file_path in sql_files:
        # 读取SQL语句列表
        sql_list = read_sql_from_file(sql_file_path).split(';')

        database_table = extract_database_table(sql_list[0])

        # 创建MySQL连接
        connection = mysql.connector.connect(
            # 动态读取数据库名、用户名、密码
            host = host_config.get(database_table[0])['host'],
            port = host_config.get(database_table[0])['port'],
            user = host_config.get(database_table[0])['user'],
            password = host_config.get(database_table[0])['password'],
            database = database_table[0]
        )
        cursor = connection.cursor()


        # 输出目标文件夹
        target_folder = path + 'target'
        os.makedirs(target_folder, exist_ok=True)

        # 处理每个SQL语句并生成插入语句
        for sql in sql_list:
            if sql.strip():
                process_sql(sql, cursor, target_folder, host_config)

        # 关闭连接
        cursor.close()
        connection.close()

if __name__ == "__main__":
    path = './resources/mysql/'
    main(path)
