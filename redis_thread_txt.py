# 连接 redis 数据库，并采用多线程方式获取无过期时间的key，并输出到 txt 文档中
# 用法：python redis_thread_txt.py
# 作者：swan-geese
# 日期：2023-10-10
# 版本：1.0

import redis
from concurrent.futures import ThreadPoolExecutor

# 连接到Redis数据库
def connect_redis():
    # 连接到Redis数据库
    redis_host = '10.10.2.83'
    redis_port = 6379
    redis_password = 'x2PC5bTq'
    redis_db = 0
    return redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, db=redis_db)

# 获取无过期时间的键
def filter_keys_without_expiry(redis_client, cursor = 0):
    valid_keys = []
    while cursor != 0:
        cursor, keys = redis_client.scan(cursor=cursor, count=200)  # count 可以根据需要调整
        valid_keys.extend([key.decode('utf-8') for key in keys if redis_client.ttl(key) == -1])
    return valid_keys

# 批量写入文本文件
def write_to_txt(path, valid_keys):
    with open(path + 'redis_thread_txt_valid_keys.txt', 'a') as file:
        for key in valid_keys:
            file.write(key + '\n')

# 将结果写入文本文件
def operate(path):
    # 连接到Redis数据库
    redis_client = connect_redis()

    # 多线程方式获取无过期时间的键
    cursor = 0
    with ThreadPoolExecutor(max_workers=5) as executor:  # 调整 max_workers 的值
        valid_keys = filter_keys_without_expiry(redis_client, cursor)
        executor.submit(write_to_txt, path, valid_keys)

if __name__ == "__main__":
    path = 'resources/redis/target/'
    operate(path)
