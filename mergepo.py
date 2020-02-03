"""
    Merges msgstr from .po files in po_path in .po files in dest_path

    Usage:
        * Change dest_path so as to point to directory with .po files you want to update
        * Change po_path so as to point to directory with .po compendium files
    Run:
        sudo python3 mergepo.py
"""

import os 
import argparse

dest_path = 'locale/ru/LC_MESSAGES'
po_path = 'oldlocale/ru/LC_MESSAGES'


def get_folders(path):
    folders = []
    while 1:
        path, folder = os.path.split(path)

        if folder != "":
            folders.append(folder)
        else:
            if path != "":
                folders.append(path)
            break
    folders.reverse()
    return folders

for root, dirs, files in os.walk(dest_path):
    for file in files:
        compendium = file if root == dest_path else get_folders(root)[len(get_folders(dest_path))] + ".po"
        compendium = os.path.join(po_path, compendium) + " "
        name, ext = os.path.splitext(file)
        if ext != ".po":
            continue

        folders = get_folders(root)
        file_to_change = os.path.join(root, file) + " "
        template_file = os.path.join(folders[0], *folders[3:], file) +"t "

        # Update file_to_change using compendium file from old locale folder, thus file_to_change will get msgsr from compendium for its msgid
        cmd = "msguniq " + compendium + "--use-first | msgmerge -C - -o " +  file_to_change + "/dev/null " + template_file
        print(cmd)
        os.system(cmd)
