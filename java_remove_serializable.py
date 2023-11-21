# 实现功能：利用python3.x来实现判断java文件中是否存在继承Serializable的类，并删除改内容，需要实现：
# 1.在目标src目录下判断是否存在.java文件（可能为多级目录，需循环判断）
# 2.在其中.java文件中搜索是否存在implements Serializable的类，并删除implements Serializable以及import java.io.Serializable;
# 3.最后输出到原始文件中
# 用法：python java_remove_serializable.py
# 作者：swan-geese
# 日期：2023-11-21
# 版本：1.0

import os
import re

def process_java_file(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # 检查是否存在 implements Serializable
    if 'implements Serializable' in content:
        # 删除 implements Serializable
        content = re.sub(r'implements Serializable\s+', '', content)

        # 删除 import java.io.Serializable;
        content = re.sub(r'import\s+java\.io\.Serializable;', '', content)

        # 写回文件
        with open(file_path, 'w') as file:
            file.write(content)

def process_directory(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.java'):
                file_path = os.path.join(root, file)
                process_java_file(file_path)

if __name__ == "__main__":
    # 目标src目录
    src_directory = "/Users/dearzhang/paraview/code/iam/msg/"

    # 处理目录下的所有.java文件
    process_directory(src_directory)

    print("处理完成！")
