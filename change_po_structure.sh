# Usage:
# Locate this and mergepo.py scripts in tarantool doc directory
# Add `gettext_compact = False` to conf.py
# Run:
# sudo change_po_structure.sh
# 
# Script save previous locale file into oldlocale directory

mkdir oldlocale
mkdir oldlocale/ru
mkdir oldlocale/ru/LC_MESSAGES
mv locale/*.pot oldlocale/
mv locale/ru/LC_MESSAGES/*.po oldlocale/ru/LC_MESSAGES
docker run --rm -it -v $(pwd):/doc tarantool-doc-builder sh -c "make update-po"
python3 mergepo.py

# To build html use:
# sudo sphinx-build -b html -d output/_html_ru/ -c html/ doc output/html/ru -D language=ru
# or 
# docker run --rm -it -v $(pwd):/doc tarantool-doc-builder sh -c "make html-ru"
