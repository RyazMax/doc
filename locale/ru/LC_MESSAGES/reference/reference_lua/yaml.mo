��    $      <              \     ]  "   z  "   �  P   �  �        �  6   �  %   �  &     %   ;  &   a     �     �     �     �     �  
   �  W   �  h     z   ~     �  -   �  2   +  0   ^  6   �     �  +   �                    "  �   (    &  /   5
  0   e
  �  �
     9  "   V  "   y  �   �  �   �  %   Q  o   w  >   �  ?   &  <   f  =   �     �     �                    8  �   K  �   �  �   j     A  }   V     �  `   T  c   �  $     T   >     �  2   �     �     �  �   �    �  S     _   X   :ref:`yaml.NULL <yaml-null>` :ref:`yaml.decode() <yaml-decode>` :ref:`yaml.encode() <yaml-encode>` A value comparable to Lua "nil" which may be useful as a placeholder in a tuple. Also, some YAML configuration settings for encoding can be changed, in the same way that they can be changed for :ref:`JSON <json-module_cfg>`. Analog of Lua's "nil" Below is a list of all ``yaml`` functions and members. Convert a Lua object to a YAML string Convert a Lua object to a YAML string. Convert a YAML string to a Lua object Convert a YAML string to a Lua object. Example Index Module `yaml` Name Overview Parameters Serializing 'A' and 'B' with different ``__serialize`` values causes different results: The `YAML collection style <http://yaml.org/spec/1.1/#id930798>`_ can be specified with ``__serialize``: The ``yaml`` module takes strings in YAML_ format and decodes them, or takes a series of non-YAML values and encodes them. Use ``__serialize="map"`` for a Flow Mapping map. ``__serialize="mapping"`` for a Block Mapping map, ``__serialize="seq"`` for a Flow Sequence array, ``__serialize="sequence"`` for a Block Sequence array, a string formatted as YAML. either a scalar value or a Lua table value. return rtype string table tarantool> yaml = require('yaml')
---
...
tarantool> y = yaml.encode({'a', 1, 'b', 2})
---
...
tarantool> z = yaml.decode(y)
---
...
tarantool> z[1], z[2], z[3], z[4]
---
- a
- 1
- b
- 2
...
tarantool> if yaml.NULL == nil then print('hi') end
hi
---
... tarantool> yaml = require('yaml')
---
...
tarantool> yaml.encode(setmetatable({'A', 'B'}, { __serialize="sequence"}))
---
- |
  ---
  - A
  - B
  ...
...
tarantool> yaml.encode(setmetatable({'A', 'B'}, { __serialize="seq"}))
---
- |
  ---
  ['A', 'B']
  ...
...
tarantool> yaml.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="map"})})
---
- |
  ---
  - {'f2': 'B', 'f1': 'A'}
  ...
...
tarantool> yaml.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="mapping"})})
---
- |
  ---
  - f2: B
    f1: A
  ...
... the original contents formatted as a Lua table. the original value reformatted as a YAML string. Project-Id-Version: Tarantool 1.10
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
 :ref:`yaml.NULL <yaml-null>` :ref:`yaml.decode() <yaml-decode>` :ref:`yaml.encode() <yaml-encode>` Значение, сопоставимое с нулевым значением "nil" в языке Lua, которое можно использовать в качестве объекта-заполнителя в кортеже. Кроме того, некоторые параметры конфигурации YAML для кодировки можно изменить так же, как и для :ref:`JSON <json-module_cfg>`. Аналог "nil" в языке Lua  Ниже приведен перечень всех функций и элементов модуля ``yaml``. Конвертация Lua-объекта в YAML-строку Конвертация Lua-объекта в YAML-строку. Конвертация YAML-строки в Lua-объект Конвертация YAML-строки в Lua-объект. Пример Указатель Модуль `yaml` Имя Общие сведения Параметры Сериализация 'A' и' B' различными значениями ``__serialize`` приводит к различным результатам: `Набор YAML-стилей <http://yaml.org/spec/1.1/#id930798>`_ можно указать с помощью ``__serialize``: Модуль ``yaml`` берет строки в формате YAML_ и декодирует их или берет ряд значений в ином формате и кодирует их в формат YAML. Назначение ``__serialize="map"`` для ассоциативного массива последовательности потоков. ``__serialize="mapping"`` для ассоциативного массива последовательности блоков, ``__serialize="seq"`` для массива последовательности потоков, ``__serialize="sequence"`` для массива последовательности блоков, строка в формате YAML. скалярное значение или значение из Lua-таблицы. возвращает тип возвращаемого значения строка таблица tarantool> yaml = require('yaml')
---
...
tarantool> y = yaml.encode({'a', 1, 'b', 2})
---
...
tarantool> z = yaml.decode(y)
---
...
tarantool> z[1], z[2], z[3], z[4]
---
- a
- 1
- b
- 2
...
tarantool> if yaml.NULL == nil then print('hi') end
hi
---
... tarantool> yaml = require('yaml')
---
...
tarantool> yaml.encode(setmetatable({'A', 'B'}, { __serialize="sequence"}))
---
- |
  ---
  - A
  - B
  ...
...
tarantool> yaml.encode(setmetatable({'A', 'B'}, { __serialize="seq"}))
---
- |
  ---
  ['A', 'B']
  ...
...
tarantool> yaml.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="map"})})
---
- |
  ---
  - {'f2': 'B', 'f1': 'A'}
  ...
...
tarantool> yaml.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="mapping"})})
---
- |
  ---
  - f2: B
    f1: A
  ...
... оригинальное содержание в формате Lua-таблицы. оригинальное значение, преобразованное в YAML-строку. 