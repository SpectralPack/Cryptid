"""
This Script searches for missing entries in a given localization lua-file,
comparing its contents to en-us.lua.
This version also gives the full "path" to a given entry, and can detect
stuff like missing unlock descriptors.

Author: Avery (@onichama)
"""

vars_en = []
vars_other = []

def read_vars_from_file(filename, into_list):
    current_var_path = []
    with open(filename) as file_en:
        for line in file_en:
            if " = {" in line:
                current_var = line.split(" = {")[0].strip()
                current_var_path.append(current_var)
                into_list.append(".".join(current_var_path))
            if ("},\n" in line or "}\n" in line) and len(current_var_path) > 0:
                current_var_path.pop(len(current_var_path)-1)

read_vars_from_file("../en-us.lua", vars_en) # Take EN-US as base language
read_vars_from_file("../de.lua", vars_other) # Change this to the language you want to compare to

for var in vars_en:
    if var not in vars_other:
        print(var)
