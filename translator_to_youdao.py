# 实现功能：调用有道翻译API，实现英文翻译成中文
# 用法：python translator_to_youdao.py
# 作者：swan-geese
# 日期：2023-11-09
# 版本：1.0

import hashlib
import random
import time
import requests
import re


# 获取翻译数据
def get_data(content):
    if content.strip() == '':
        return ''
    content = camel_to_words(content)
    r = str(round(time.time() * 1000))
    salt = r + str(random.randint(0, 9))

    data = "fanyideskweb" + content + salt + "Tbh5E8=q6U3EXe+&L[4c@"
    sign = hashlib.md5()

    sign.update(data.encode("utf-8"))

    sign = sign.hexdigest()
    return content, salt, sign

# 发送请求
def send_request(content, salt, sign):
    url = 'http://fanyi.youdao.com/translate_o?smartresult=dict&smartresult=rule'

    headers = {
        'Cookie': 'OUTFOX_SEARCH_USER_ID=-1927650476@223.97.13.65;',
        'Host': 'fanyi.youdao.com',
        'Origin': 'http://fanyi.youdao.com',
        'Referer': 'http://fanyi.youdao.com/',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.146 Safari/537.36',
    }

    data = {
        'i': str(content),
        'from': 'AUTO',
        'to': 'AUTO',
        'smartresult': 'dict',
        'client': 'fanyideskweb',
        'salt': str(salt),
        'sign': str(sign),
        # 'lts': '1612879546052',
        # 'bv': '6a1ac4a5cc37a3de2c535a36eda9e149',
        # 'doctype': 'json',
        'version': '2.1',
        'keyfrom': 'fanyi.web',
        'action': 'FY_BY_REALTlME',
    }
    result = content
    try:
        res = requests.post(url=url, headers=headers, data=data).json()
        result = res['translateResult'][0][0]['tgt']
    except Exception as e:
        print('翻译异常：', e)
    finally:
        print('翻译前：', content)
        print('翻译后：', res['translateResult'][0][0]['tgt'])
    return result


# 定义驼峰转单词函数，例如：createTime -> create time
def camel_to_words(camel_case_string):
    # 使用正则表达式将驼峰字符串拆分为单词
    words = re.findall(r'[A-Z][a-z]*|[a-z]+', camel_case_string)
    # 转换单词为小写并使用空格将它们连接起来
    return ' '.join(word.lower() for word in words)

if __name__ == '__main__':
    text = 'app_version'.replace('_', ' ')
    content, salt, sign = get_data(text)
    result = send_request(content, salt, sign)
    print(result)