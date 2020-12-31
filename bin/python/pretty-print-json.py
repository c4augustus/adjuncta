#!/usr/bin/env python3
# pretty print JSON files

import argparse
import json
import os

def pretty_print_json_file(filepath):
    with open(filepath, "r") as infile:
        jsondata = json.load(infile)
    (filestem, fileext) = os.path.splitext(os.path.basename(filepath))
    with open(filestem + "-pretty.json", "w") as outfile:
        json.dump(jsondata, outfile, indent=2)
    print(json.dumps(jsondata, indent=2))

def main():
    parser = argparse.ArgumentParser(
        description='pretty print JSON',
    )
    parser.add_argument(
        'filepaths',
        metavar='filepaths',
        nargs='+',
        help='input JSON file(s)',
    )
    args = parser.parse_args()
    for filepath in args.filepaths:
        pretty_print_json_file(filepath)

if __name__ == '__main__':
    main()
