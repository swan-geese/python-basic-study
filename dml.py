# 遍历source.sql ddl 文件，根据 check.txt 文件，将在 check.txt 文件中的表，输出到 target.sql 文件中
# 用法：python dml.py
# 作者：swan-geese
# 日期：2023-09-10
# 版本：1.0
import re

def filter(path):
    # 读取原始 ddl sql 文件，并存储到lines list 中
    f = open(path + 'source/source_init.sql', 'r')
    lines = f.readlines()
    f.close()
    # 读取 check 文件，并存储到checks list 中
    f = open(path + 'source/check.txt', 'r')
    checks = f.readlines()
    f.close()
    # 存储部分list，用于存储部分数据(用于存储每一条create完整语句，包括create table 和 drop table)

    # 将原始ddl sql 文件，按照每一条create完整语句，包括create table 和 drop table，存储到map中
    map = {}
    # 存储key，用于存储tableName，作为map key
    tableNamePattern = re.compile(r'INSERT INTO `(.*)`')
    for line in lines:
        # 使用正则表达式判断是否匹配 insert into 语句
        match = re.search(tableNamePattern, line);
        if match:
            # 使用正则表达式提取 insert into 语句中的表名
            key = match.group(1)
            # map[key] 不为空，且 map[key] 中不包含 line ，则将 line 添加到 map[key] 中
            values = map.get(key)
            if (values != None):
                if line not in values:
                    values.append(line)
                    map[key] = values
            else:
                values = []
                values.append(line)
                map[key] = values
    print(map)

    targets = []
    for check in checks:
        #去除check中换行符
        check = check.replace('\n', '')
        targets.append(check)
    # print(targets)

    #将 targets 中的数据，与 map 中的数据进行对比，如果 map 中的 key 在 targets 中，则输出到 target_dml.sql文件中
    f = open(path + 'output/target_dml.sql', 'w')
    for key in map.keys():
        if key in targets:
            f.writelines(map[key])
    f.close()

    #将 targets 中的数据，与 map 中的数据进行对比，如果 map 中的 key 不在 targets 中，则输出到 targetNot_dml.sql文件中
    f = open(path + 'output/targetNot_dml.sql', 'w')
    for key in map.keys():
        if key not in targets:
           f.writelines(map[key])
    f.close()
    print('>>>>>>>>>>> done >>>>>>>>>>>')

if __name__ == '__main__':
    path = './resources/dml/'
    filter(path)
