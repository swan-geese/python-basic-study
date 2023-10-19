# 遍历sql文件夹中.sql文件，根据 ['库名', '表名', '是否存在租户id', 'sql'] 输出到 output.xlsx 文件中
# 用法：python dml_to_xlsx.py
# 作者：swan-geese
# 日期：2023-09-22
# 版本：1.0

import os
import re
import pandas as pd
import glob


def filter(path):
    # 创建一个空的DataFrame，用于存储所有数据
    all_data = pd.DataFrame(columns=['库名', '表名', '是否存在自增主键id', '是否存在租户id', 'delete sql' , 'select sql'])

    # 指定目标目录
    target_directory = path + 'source' # 请将此路径替换为你的目标目录路径

    # 查找目标目录下的所有.sql文件
    sql_files = glob.glob(os.path.join(target_directory, '*.sql'))

    # 用于提取表名的正则表达式模式
    table_pattern = re.compile(r'CREATE TABLE `([^`]+)`')

    # 用于提取是否存在租户id的正则表达式模式
    id_pattern = re.compile(r'AUTO_INCREMENT')

    # 用于提取是否存在租户id的正则表达式模式
    tenant_pattern = re.compile(r'`tenant_id`')

    # 遍历每个.sql文件
    for sql_file in sql_files:
        # 用于存储解析后的数据
        data = []
        with open(sql_file, 'r') as file:
            sql_statements = file.read().split(';')
            for statement in sql_statements:
                # 查找表名
                match = table_pattern.search(statement)
                if match:
                    table_name = match.group(1)

                    # 查找是否存在自增主键id
                    has_id = '是' if id_pattern.search(statement) else '否'

                    # 查找是否存在租户id
                    has_tenant = '是' if tenant_pattern.search(statement) else '否'

                    # 构建 SQL 语句
                    sql_query = ''
                    delete_sql = ''
                    if (has_tenant == '是'):
                        sql_query = f"select * from `{sql_file.replace(path, '').replace('.sql', '')}`.`{table_name}` where tenant_id = yyy;"
                        delete_sql = f"delete from `{sql_file.replace(path, '').replace('.sql', '')}`.`{table_name}` where tenant_id = yyy;"

                    # 添加到数据列表
                    data.append([sql_file.replace(path, '').replace('.sql', ''), table_name, has_id, has_tenant, delete_sql, sql_query])

        # 创建DataFrame
        df = pd.DataFrame(data, columns=['库名', '表名', '是否存在自增主键id', '是否存在租户id', 'delete sql' , 'select sql'])

        # 追加到总的DataFrame
        all_data = pd.concat([all_data, df], ignore_index=True)

    # 读取现有的Excel文件
    output_file = path + '/output/output.xlsx'
        # 将所有数据追加到Excel文件
    all_data.to_excel(output_file, index=False, engine='openpyxl')

    print(f'Data from SQL files appended to {output_file}')




if __name__ == '__main__':
    path = './resources/sql/'
    filter(path)




