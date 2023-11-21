# 实现功能：遍历数据库中的表和列注释，找到未添加注释的表和列，利用翻译功能实现英文翻译为中文，再生成ALTER TABLE语句，并输出到csv文件中
# 用法：python mysql_to_alter.py
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
# db_config = {
#     "host": "10.10.2.210",
#     "user": "root",
#     "password": "Parav1ew!",
# }
db_config = {
    "host": "192.168.2.83",
    "user": "esc",
    "password": "T1v0li123!",
}

# 定义驼峰转单词函数，例如：createTime -> create time
def camel_to_words(camel_case_string):
    # 使用正则表达式将驼峰字符串拆分为单词
    words = re.findall(r'[A-Z][a-z]*|[a-z]+', camel_case_string)
    # 转换单词为小写并使用空格将它们连接起来
    return ' '.join(word.lower() for word in words)

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
    # trans_result = camel_to_words(q).replace('_', ' ')
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
                column_default = column[5]
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
                    if column_default:
                        alter_statement = f"ALTER TABLE {table_name} MODIFY COLUMN {column_name} {column[1]} DEFAULT {column_default} COMMENT '{translated_comment}';"
                    else:
                        alter_statement = f"ALTER TABLE {table_name} MODIFY COLUMN {column_name} {column[1]} COMMENT '{translated_comment}';"
                    alter_data.append((schema_name, table_name, column_name, 'ALTER COLUMN', alter_statement))

            # 获取表的注释
            cursor.execute(f"SHOW TABLE STATUS LIKE '{table_name}'")
            table_status = cursor.fetchone()
            table_comment = table_status[17]

            # 如果表没有注释，生成ALTER TABLE语句设置表注释
            if not table_comment:
                # 尝试从缓存中获取翻译结果
                if table_name in translation_cache:
                    translated_comment = translation_cache[table_name]
                else:
                    # 根据名称翻译注释
                    translated_comment = translate_to_chinese(table_name)
                    translation_cache[table_name] = translated_comment

                alter_statement = f"ALTER TABLE {table_name} COMMENT '{translated_comment}';"
                alter_data.append((schema_name, table_name, '', 'ALTER TABLE', alter_statement))

    # 关闭数据库连接
    cursor.close()
    conn.close()

    # 将ALTER TABLE语句数据保存到CSV文件
    csv_file = path +'alter_statements-580.csv'
    with open(csv_file, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(['Schema', 'Table', 'Column', 'Action', 'SQL Statement'])
        csv_writer.writerows(alter_data)

    print(f'ALTER TABLE statements saved to {csv_file}')


if __name__ == "__main__":
    # 测试示例
    # input_strings = ["app_id", "appId", "APP_ID", "APP"]
    # for input_string in input_strings:
    #     output_string = format_string(input_string)
    #     print(f"输入：{input_string}，输出：{output_string}")
    # translate_to_chinese('RESOURCE_ID')
    # translate_to_chinese('createTime')
    # translate_to_chinese('createtime')
    path = './resources/mysql/target/'
    main(path)

