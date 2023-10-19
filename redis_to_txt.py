# 连接 redis 数据库，并获取无过期时间的key，并输出到 txt 文档中
# 用法：python redis_to_txt.py
# 作者：swan-geese
# 日期：2023-10-10
# 版本：1.0

import redis

# 连接到Redis数据库
def connect_redis():
    # 连接到Redis数据库
    # redis_host = 'redis-c5490cc4-3db7-4835-bde4-2934fc35d9cd.cn-east-3.dcs.myhuaweicloud.com'
    # redis_port = 6379
    # redis_password = 'UMaSjilDMHfC~YTW'
    redis_host = '10.10.2.83'
    redis_port = 6379
    redis_password = 'x2PC5bTq'
    redis_db = 0
    return redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, db=redis_db)


# 获取无过期时间的键
def filter_keys_without_expiry(redis_client):
    valid_keys = []

    # 使用SCAN命令替代KEYS命令
    cursor = 0
    while True:
        cursor, keys = redis_client.scan(cursor=cursor, count=1000)  # count 可以根据需要调整
        # method 1
        # for key in keys:
        #     if redis_client.ttl(key) == -1:
        #         valid_keys.append(key.decode('utf-8'))
        # method 2
        valid_keys.extend([key.decode('utf-8') for key in keys if redis_client.ttl(key) == -1])

        if cursor == 0:
            break

    return valid_keys

def wirte_to_txt(path, valid_keys):
    # 将结果写入文本文件
    with open(path + 'redis_to_txt_valid_keys.txt', 'w') as file:
        for key in valid_keys:
            file.write(key + '\n')

# 将结果写入文本文件
def operate(path):
    # 连接到Redis数据库
    redis_client = connect_redis()

    # 获取无过期时间的键
    valid_keys = filter_keys_without_expiry(redis_client)

    # 将结果写入文本文件
    wirte_to_txt(path, valid_keys)

if __name__ == "__main__":
    path = 'resources/redis/target/'
    operate(path)
