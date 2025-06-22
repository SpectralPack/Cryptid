"""
This Script searches for missing entries in a given localization lua-file,
comparing its contents to en-us.lua.

Author: Avery (@onichama)
"""

vars_en = []
vars_other = []

def read_vars_from_file(filename, into_list):
    with open(filename) as file_en:
        for line in file_en:
            if " = {" in line and "text = {" not in line and "unlock = {" not in line:
                into_list.append(line.split(" = {")[0].strip())

read_vars_from_file("../en-us.lua", vars_en) # Take EN-US as base language
read_vars_from_file("../de.lua", vars_other) # Change this to the language you want to compare to

for var in vars_en:
    if var not in vars_other:
        print(var)
