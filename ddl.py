# 遍历source.sql ddl 文件，根据 check.txt 文件，将在 check.txt 文件中的表，输出到 target.sql 文件中
# 用法：python ddl.py
# 作者：swan-geese
# 日期：2023-09-10
# 版本：1.0

def filter(path):
    # 读取原始 ddl sql 文件，并存储到lines list 中
    f = open(path + 'source/source.sql', 'r')
    lines = f.readlines()
    f.close()
    # 读取 check 文件，并存储到checks list 中
    f = open(path + 'source/check.txt', 'r')
    checks = f.readlines()
    f.close()
    #存储部分list，用于存储部分数据(用于存储每一条create完整语句，包括create table 和 drop table)
    portionList = []
    # 将原始ddl sql 文件，按照每一条create完整语句，包括create table 和 drop table，存储到map中
    map = {}
    # 存储key，用于存储tableName，作为map key
    key = ''
    for line in lines:
        portionList.append(line)
        if (line.find('DROP TABLE IF EXISTS') != -1):
            key = line.replace('DROP TABLE IF EXISTS `', '').replace('`', '').replace(';', '').replace('\n', '')
        if (len(line) == 1 and line.find('\n')!= -1) :
            map[key] = portionList
            portionList = []
            key = ''


    print(map)

    targets = []
    for check in checks:
        #去除check中换行符
        check = check.replace('\n', '')
        targets.append(check)
    print(targets)

    #将targets中的数据，与map中的数据进行对比，如果map中的key在targets中，则输出到target.sql文件中
    f = open(path + 'output/target_ddl.sql', 'w')
    for target in targets:
        if target in map.keys():
            f.writelines(map[target])
    f.close()

    # 将targets中的数据，与map中的数据进行对比，如果map中的key不在targets中，则输出到targetNot.sql文件中
    f = open(path + 'output/targetNot_ddl.sql', 'w')
    for key in map.keys():
        if key not in targets:
            f.writelines(map[key])
    f.close()
    print('>>>>>>>>>>> done >>>>>>>>>>>')

if __name__ == '__main__':
    path = './resources/ddl/'
    filter(path)
