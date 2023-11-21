# 实现功能：遍历数据库中的表和列注释，找到未添加注释的表和列，利用翻译功能实现英文翻译为中文，再生成ALTER TABLE语句，并输出到csv文件中
# 用法：python translator_to_alter_column.py
# 作者：swan-geese
# 日期：2023-11-09
# 版本：1.0

import mysql.connector
import random
import hashlib
import re
import csv
import requests
import pandas as pd
import openpyxl

# 设置数据库连接参数
db_config = {
    "host": "192.168.2.83",
    "user": "esc",
    "password": "T1v0li123!",
}

#采用正则表达式来实现数据正则匹配并输出为理想字符串，例如：输入：app_id，返回：app id，输入：appId，返回：app id， 输入：APP_ID，返回：app id，输入：APP，返回：app
def format_string(input_string):
    # 定义正则表达式匹配规则
    pattern = r'[A-Z]+[a-z]*|[a-z]+'
    # 使用正则表达式进行匹配
    matches = re.findall(pattern, input_string)
    # 将匹配结果拼接为理想字符串
    formatted_string = ' '.join(matches).lower()
    return formatted_string

# 定义翻译函数
def translate_to_chinese(q):
    if q.strip() == '':
        return ''
    trans_result = format_string(q)
    appid = '20231108001874033'  # 填写你的appid
    secretKey = 'lF9UdhGkqwTsO_flbMgL'  # 填写你的密钥
    myurl = 'https://api.fanyi.baidu.com/api/trans/vip/translate'  # 通用翻译API HTTP地址
    fromLang = 'en'  # 原文语种
    toLang = 'zh'  # 译文语种
    salt = random.randint(32768, 65536)
    sign = appid + trans_result + str(salt) + secretKey
    sign = hashlib.md5(sign.encode()).hexdigest()

    params = {
        'q': trans_result,
        'from': fromLang,
        'to': toLang,
        'appid': appid,
        'salt': str(salt),
        'sign': sign
    }

    try:
        response = requests.get(myurl, params=params)
        result = response.json()
        trans_result = result['trans_result'][0]['dst']
    except Exception as e:
        print(e)
    finally:
        print(f"原文: {q}")
        print(f"待翻译原文: {result['trans_result'][0]['src']}")
        print(f"翻译结果: {trans_result}")
    return trans_result


def getTable(path):
    f = open(path + 'src/column580.csv', 'r')
    lines = f.readlines()
    f.close()
    replaceLines = []
    for line in lines:
        replaceLines.append(line.replace('\n', ''))
    return replaceLines


def main(path):
    # 连接到MySQL数据库
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    alter_data = []  # 存储ALTER TABLE语句数据

    # 获取所有schema
    cursor.execute("SHOW DATABASES")
    schemas = cursor.fetchall()

    translation_cache = {}  # 存储已经翻译过的文本

    # 遍历每个schema
    for schema in schemas:
        schema_name = schema[0]

        # if schema_name not in ['admin', 'config', 'idm', 'msg', 'portal', 'strategy']:
        #     continue
        if schema_name not in ['escdb-580']:
            continue

        # 使用schema
        cursor.execute(f"USE `{schema_name}`")

        # 待处理的表
        tablePending = getTable(path)

        # 获取所有表名
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()

        newTables = []
        for table in tables:
            newTables.append(table[0])


        for pending in tablePending:
            table_name, column_name = pending.split(',')

            if table_name not in newTables:
                continue

            # 获取表的列名和注释
            cursor.execute(f"SHOW FULL COLUMNS FROM {table_name}")
            columns = cursor.fetchall()

            # 遍历每个列
            for column in columns:
                if column[0] != column_name:
                    continue

                column_comment = column[8]

                # 如果列注释为空，生成ALTER TABLE语句设置列注释
                if not column_comment:
                    # 尝试从缓存中获取翻译结果
                    if column_name in translation_cache:
                        translated_comment = translation_cache[column_name]
                    else:
                        # 根据名称翻译注释
                        translated_comment = translate_to_chinese(column_name)
                        translation_cache[column_name] = translated_comment

                    alter_statement = f"ALTER TABLE {table_name} MODIFY COLUMN {column_name} {column[1]} COMMENT '{translated_comment}';"
                    alter_data.append((schema_name, table_name, column_name, 'ALTER COLUMN', alter_statement))

            # 获取表的注释
            # cursor.execute(f"SHOW TABLE STATUS LIKE '{table_name}'")
            # table_status = cursor.fetchone()
            # table_comment = table_status[17]
            #
            # # 如果表没有注释，生成ALTER TABLE语句设置表注释
            # if not table_comment:
            #     # 尝试从缓存中获取翻译结果
            #     if table_name in translation_cache:
            #         translated_comment = translation_cache[table_name]
            #     else:
            #         # 根据名称翻译注释
            #         translated_comment = translate_to_chinese(table_name)
            #         translation_cache[table_name] = translated_comment
            #
            #     alter_statement = f"ALTER TABLE {table_name} COMMENT '{translated_comment}';"
            #     alter_data.append((schema_name, table_name, '', 'ALTER TABLE', alter_statement))

    # 关闭数据库连接
    cursor.close()
    conn.close()

    # 将ALTER TABLE语句数据保存到CSV文件
    csv_file = path +'target/alter_statements-column-580.csv'
    with open(csv_file, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(['Schema', 'Table', 'Column', 'Action', 'SQL Statement'])
        csv_writer.writerows(alter_data)

    print(f'ALTER TABLE statements saved to {csv_file}')


    # 将ALTER TABLE语句数据保存到 EXCEL 文件
    excel_file = path + 'target/alter_statements-column-580.xlsx'
    # 创建DataFrame
    df = pd.DataFrame(alter_data, columns=['Schema', 'Table', 'Column', 'Action', 'SQL Statement'])

    # 将所有数据导出到Excel文件
    df.to_excel(excel_file, index=False, engine='openpyxl')


    print(f'ALTER TABLE statements saved to {excel_file}')



if __name__ == "__main__":
    # translate_to_chinese('createTime')
    path = './resources/translator/'
    main(path)

