# 实现功能：调用google翻译API，实现英文翻译成中文(注：国内被墙，httpcore._exceptions.ConnectTimeout: timed out)
# 用法：python translator_to_google.py
# 作者：swan-geese
# 日期：2023-11-09
# 版本：1.0

from googletrans import Translator

def translate_text(text, source_lang, target_lang):
    translator = Translator()
    translation = translator.translate(text, src=source_lang, dest=target_lang)
    return translation.text

if __name__ == "__main__":
    text_to_translate = "Hello, World!"  # 要翻译的文本
    source_language = "en"  # 源语言
    target_language = "zh-CN"  # 目标语言

    translated_text = translate_text(text_to_translate, source_language, target_language)
    print(f"原文: {text_to_translate}")
    print(f"翻译结果: {translated_text}")
