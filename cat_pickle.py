#!/usr/bin/env python3

import sys
import pickle

args = sys.argv

for file_name in args[1:]:
    with open(file_name, "rb")  as fin:
        print(pickle.load(fin))
