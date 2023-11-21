# 实现功能：调用百度翻译API，实现英文翻译成中文
# 用法：python translator_to_baidu.py
# 作者：swan-geese
# 日期：2023-11-09
# 版本：1.0

import http.client
import hashlib
import urllib
import random
import json
import requests

# http 方式调用
def trans_lang(q):
    trans_result = q
    # 百度appid和密钥需要通过注册百度【翻译开放平台】账号后获得
    appid = '20231108001874033'  # 填写你的appid
    secretKey = 'lF9UdhGkqwTsO_flbMgL'  # 填写你的密钥

    httpClient = None
    myurl = '/api/trans/vip/translate'  # 通用翻译API HTTP地址

    fromLang = 'en'  # 原文语种
    toLang = 'zh'  # 译文语种
    salt = random.randint(32768, 65536)
    # 手动录入翻译内容，q存放
    sign = appid + q + str(salt) + secretKey
    sign = hashlib.md5(sign.encode()).hexdigest()
    myurl = myurl + '?appid=' + appid + '&q=' + urllib.parse.quote(q) + '&from=' + fromLang + \
            '&to=' + toLang + '&salt=' + str(salt) + '&sign=' + sign

    # 建立会话，返回结果
    try:
        httpClient = http.client.HTTPConnection('api.fanyi.baidu.com')
        httpClient.request('GET', myurl)
        # response是HTTPResponse对象
        response = httpClient.getresponse()
        result_all = response.read().decode("utf-8")
        result = json.loads(result_all)
        trans_result = result['trans_result'][0]['dst']
    except Exception as e:
        print(e)
    finally:
        if httpClient:
            httpClient.close()
    return trans_result


# requests 方式调用
def requests_trans_lang(q):
    trans_result = q
    appid = '20231108001874033'  # 填写你的appid
    secretKey = 'lF9UdhGkqwTsO_flbMgL'  # 填写你的密钥

    myurl = 'https://api.fanyi.baidu.com/api/trans/vip/translate'  # 通用翻译API HTTP地址

    fromLang = 'en'  # 原文语种
    toLang = 'zh'  # 译文语种
    salt = random.randint(32768, 65536)
    sign = appid + q + str(salt) + secretKey
    sign = hashlib.md5(sign.encode()).hexdigest()

    params = {
        'q': q,
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




if __name__ == '__main__':
    a = 'Customer Not Available & Mobile not reachable Customer Not Available & Mobile not reachable by SR: ANIL KUMAR (170435) (117510), MobileNo: 9996366909'
    print(requests_trans_lang(a))