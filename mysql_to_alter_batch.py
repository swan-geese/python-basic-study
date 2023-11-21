# 实现功能：遍历数据库中的表和列注释，找到未添加注释的表和列，利用翻译功能实现英文翻译为中文（批量整理待翻译的英文，一次整体翻译为中文），再生成ALTER TABLE语句，并输出到csv文件中，数据量太大时容易出现异常
# 用法：python mysql_to_alter_batch.py
# 作者：swan-geese
# 日期：2023-11-09
# 版本：1.0

import mysql.connector
import random
import hashlib
import re
import csv
import requests

# 设置数据库连接参数
db_config = {
    "host": "10.10.2.210",
    "user": "root",
    "password": "Parav1ew!",
}

# 定义驼峰转单词函数，例如：createTime -> create time
def camel_to_words(camel_case_string):
    # 使用正则表达式将驼峰字符串拆分为单词
    words = re.findall(r'[A-Z][a-z]*|[a-z,]+', camel_case_string)
    # 转换单词为小写并使用空格将它们连接起来
    return ' '.join(word.lower() for word in words)

# 定义翻译函数
def translate_to_chinese(q):
    if q.strip() == '':
        return ''
    trans_result = camel_to_words(q).replace('_', ' ')
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
        print(f"翻译结果: {trans_result}")
    return trans_result

def main(path):
    # 连接到MySQL数据库
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    alter_data = []  # 存储ALTER TABLE语句数据

    source_data = []  # 存储源数据

    # 获取所有schema
    cursor.execute("SHOW DATABASES")
    schemas = cursor.fetchall()

    # 遍历每个schema
    for schema in schemas:
        schema_name = schema[0]

        if schema_name not in ['admin', 'config', 'idm', 'msg', 'portal', 'strategy']:
            continue

        # 使用schema
        cursor.execute(f"USE {schema_name}")

        # 获取所有表名
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()

        # 遍历每个表
        for table in tables:
            table_name = table[0]

            # 获取表的列名和注释
            cursor.execute(f"SHOW FULL COLUMNS FROM {table_name}")
            columns = cursor.fetchall()

            # 遍历每个列
            for column in columns:
                column_name = column[0]
                column_comment = column[8]

                # 如果列注释为空，生成ALTER TABLE语句设置列注释
                if not column_comment:
                    source_data.append(column_name)
                    alter_statement = f"ALTER TABLE {table_name} MODIFY COLUMN {column_name} {column[1]} COMMENT '%s';"
                    alter_data.append((schema_name, table_name, column_name, 'ALTER COLUMN', alter_statement))

            # 获取表的注释
            cursor.execute(f"SHOW TABLE STATUS LIKE '{table_name}'")
            table_status = cursor.fetchone()
            table_comment = table_status[17]

            # 如果表没有注释，生成ALTER TABLE语句设置表注释
            if not table_comment:

                source_data.append(table_name)

                alter_statement = f"ALTER TABLE {table_name} COMMENT '%s';"
                alter_data.append((schema_name, table_name, '', 'ALTER TABLE', alter_statement))

    # 关闭数据库连接
    cursor.close()
    conn.close()

    source = ','.join(data.lower() for data in source_data)
    # 根据名称翻译注释
    translated_comment = translate_to_chinese(source)
    translated_comment_data = translated_comment.replace('，', ',').replace('、', ',').split(',')
    print(translated_comment_data)
    # 将翻译后的注释添加到ALTER TABLE语句中
    alter_data = [str(name).replace('%s', translated_comment_data[i]) for i, name in enumerate(alter_data)]


    # 将ALTER TABLE语句数据保存到CSV文件
    csv_file = path +'alter_statements_batch.csv'
    with open(csv_file, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(['Schema', 'Table', 'Column', 'Action', 'SQL Statement'])
        csv_writer.writerows(alter_data)

    print(f'ALTER TABLE statements saved to {csv_file}')

if __name__ == "__main__":
    # key = 'id,api,module,status,creator,create_time,updater,update_time,eid,id,name,api_key,api_se'
    # translate_to_chinese(key)
    path = './resources/mysql/target/'
    main(path)
