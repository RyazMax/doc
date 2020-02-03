��          �                 �       �  �   �     R  ?   `  b   �  -     7  1  �   i  .     .   N     }     �  �   �  �  (  �  �     }
  �   �
     k  d     �   �  o   �  �    C    6   V  ]   �     �  2      �   3   (...)
---
- - {'BODY':   {'space_id': 272, 'index_base': 1, 'key': ['max_id'],
                'tuple': [['+', 2, 1]]},
     'HEADER': {'type': 'UPDATE', 'timestamp': 1477846870.8541,
                'lsn': 1, 'server_id': 1}}
  - {'BODY':   {'space_id': 280,
                 'tuple': [512, 1, 'tester', 'memtx', 0, {}, []]},
     'HEADER': {'type': 'INSERT', 'timestamp': 1477846870.8597,
                'lsn': 2, 'server_id': 1}} **Example:** Each result from ``pairs()`` is formatted with MsgPack so its structure can be specified with :ref:`__serialize <msgpack-serialize>`. Module `xlog` Open a file, and allow iterating over one file entry at a time. Possible errors: File does not contain properly formatted snapshot or write-ahead-log information. The first lines of the result will look like: The xlog module contains one function: ``pairs()``. It can be used to read Tarantool's :ref:`snapshot files<index-box_persistence>` or :ref:`write-ahead-log (WAL) <internals-wal>` files. A description of the file format is in section :ref:`Data persistence and the WAL file format <internals-data_persistence>`. This will read the first write-ahead-log (WAL) file that was created in the :ref:`wal_dir <cfg_basic-wal_dir>` directory in our :ref:`"Getting started" exercises <getting_started>`. `iterator <https://www.lua.org/pil/7.1.html>`_ iterator  which can be used in a for/end loop. returns rtype xlog = require('xlog')
t = {}
for k, v in xlog.pairs('00000000000000000000.xlog') do
  table.insert(t, setmetatable(v, { __serialize = "map"}))
end
return t Project-Id-Version: Tarantool 1.10
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2020-02-03 19:10+0000
PO-Revision-Date: 2019-12-06 16:16+0300
Last-Translator: 
Language: ru
Language-Team: 
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
 (...)
---
- - {'BODY':   {'space_id': 272, 'index_base': 1, 'key': ['max_id'],
                'tuple': [['+', 2, 1]]},
     'HEADER': {'type': 'UPDATE', 'timestamp': 1477846870.8541,
                'lsn': 1, 'server_id': 1}}
  - {'BODY':   {'space_id': 280,
                 'tuple': [512, 1, 'tester', 'memtx', 0, {}, []]},
     'HEADER': {'type': 'INSERT', 'timestamp': 1477846870.8597,
                'lsn': 2, 'server_id': 1}} **Пример:** Каждый результат из ``pairs()`` выводится в формате MsgPack, поэтому его структуру можно указать с помощью :ref:`__serialize <msgpack-serialize>`. Модуль `xlog` Открытие файла и итерация по одной записи файла за раз. Возможные ошибки: Файл не содержит снимок в правильном формате или информацию журнала упреждающей записи. Первые строки результата будут выглядеть следующим образом: Модуль xlog включает в себя одну функцию: ``pairs()``. Ее можно использовать для чтения :ref:`файлов снимка <index-box_persistence>` или :ref:`файлов журнала упреждающей записи (WAL) <internals-wal>` в Tarantool'е. Описание формата файла дается в разделе :ref:`Персистентность данных и формат WAL-файла <internals-data_persistence>`. В данном примере производится чтение первого WAL-файла, который был создан в директории :ref:`wal_dir <cfg_basic-wal_dir>` в рамках наших :ref:`упражнений в "Руководстве для начинающих" <getting_started>`. `итератор <https://www.lua.org/pil/7.1.html>`_ итератор, который можно использовать в цикле for / end. возвращает тип возвращаемого значения xlog = require('xlog')
t = {}
for k, v in xlog.pairs('00000000000000000000.xlog') do
  table.insert(t, setmetatable(v, { __serialize = "map"}))
end
return t 