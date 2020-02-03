��    >                    �  �   �     �  �  �     r  #   �  "   �  "   �  P   �     J  6   `  %   �  &   �  %   �  &   
  �   1     �     �     �  �   �     }	  
   �	  �   �	  W   #
     {
  g   �
  @   �
  2  5  @   h  w   �  H   !  $   j  �   �     P     T  "   t  E   �  P   �  S   .  f   �  ]   �  E   G  P   �  N   �  [   -  H   �  K   �  [        z  +   �  h   �     +     2  %   8     ^     e  �   k  �  F  =   �  b    /   �  0   �  �  �  (  �     �    �     �  #   �  "   !  "   D  �   g  %   P  o   v  <   �  =   #  >   a  ?   �  �   �     �      �      !    !     %"     A"  �   T"  �   T#  8   �#  �   *$  a   �$  �  -%  R   �&  �   %'  �   �'  F   �(    �(     �)  H    *  +   I*  _   u*  �   �*  c   d+  z   �+  �   C,  _   �,  �   C-  �   �-  �   g.  z   '/  z   �/  �   0  $   �0  T   �0  h   01     �1  2   �1  %   �1     2     2  �   #2  �  �2  =   �4  b  �4  S   :6  _   �6   **Behavior change:** Before Tarantool version 1.10.4, if a nested structure was deeper than ``cfg.encode_max_depth``, the deeper levels were cropped (encoded as nil). **Example:** -- When nil is assigned to a Lua-table field, the field is null
tarantool> {nil, 'a', 'b'}
---
- - null
  - a
  - b
...
-- When json.NULL is assigned to a Lua-table field, the field is json.NULL
tarantool> {json.NULL, 'a', 'b'}
---
- - null
  - a
  - b
...
-- When json.NULL is assigned to a JSON field, the field is null
tarantool> json.encode({field2 = json.NULL, field1 = 'a', field3 = 'c'})
---
- '{"field2":null,"field1":"a","field3":"c"}'
... :ref:`json.NULL <json-null>` :ref:`json.cfg() <json-module_cfg>` :ref:`json.decode() <json-decode>` :ref:`json.encode() <json-encode>` A value comparable to Lua "nil" which may be useful as a placeholder in a tuple. Analog of Lua's "nil" Below is a list of all ``json`` functions and members. Convert a JSON string to a Lua object Convert a JSON string to a Lua object. Convert a Lua object to a JSON string Convert a Lua object to a JSON string. For example, the following code will encode 0/0 as nan ("not a number") and 1/0 as inf ("infinity"), rather than returning nil or an error message: Index Module `json` Name Now, the result is an error suggesting that ``cfg.encode_max_depth`` is not deep enough. To return to the old behavior, say ``cfg.encode_deep_as_nil = true``. Overview Parameters See the tutorial :ref:`Sum a JSON field for all tuples <c_lua_tutorial-sum_a_json_field>` to see how ``json.decode()`` can fit in an application. Serializing 'A' and 'B' with different ``__serialize`` values causes different results: Set global flags Set values affecting behavior of :ref:`json.encode <json-encode>` and :ref:`json.decode <json-decode>`. The JSON output structure can be specified with ``__serialize``: The ``json`` module provides JSON manipulation routines. It is based on the `Lua-CJSON module by Mark Pulford <http://www.kyne.com.au/~mark/software/lua-cjson.php>`_. For a complete manual on Lua-CJSON please read `the official documentation <http://www.kyne.com.au/~mark/software/lua-cjson-manual.html>`_. The result of the ``json.encode()`` request will look like this: The same configuration settings exist for json, for :ref:`MsgPack <msgpack-module>`, and for :ref:`YAML <yaml-module>`. The values are all either integers or boolean ``true``/``false`` values. This option is ignored for ``YAML``. To achieve the same effect for only one call to ``json.encode()`` without changing the configuration persistently, one could say ``json.encode({1, x, y, 2}, {encode_invalid_numbers = true})``. Use ``__serialize="map"`` for a map ``__serialize="seq"`` for an array ``cfg.decode_invalid_numbers`` (default is true) -- allow nan and inf ``cfg.decode_max_depth`` (default is 32) -- maximum nesting depth in a structure ``cfg.decode_save_metatables`` (default is true) -- like ``encode_load_metatables`` ``cfg.encode_deep_as_nil`` (default is false) -- see :ref:`below <json-module.cfg_encode_deep_as_nil>` ``cfg.encode_invalid_as_nil`` (default is false) -- use ``null`` for all unrecognizable types ``cfg.encode_invalid_numbers`` (default is true) -- allow nan and inf ``cfg.encode_max_depth`` (default is 32) -- maximum nesting depth in a structure ``cfg.encode_number_precision`` (default is 14) -- maximum post-decimal digits ``cfg.encode_sparse_convert`` (default is true) -- handle excessively sparse arrays as maps ``cfg.encode_sparse_ratio`` (default is 2) -- how sparse an array can be ``cfg.encode_sparse_safe`` (default is 10) -- how much can safely be sparse ``cfg.encode_use_tostring`` (default is false) -- use ``tostring`` for unrecognizable types a string formatted as JSON. either a scalar value or a Lua table value. json = require('json')
json.cfg{encode_invalid_numbers = true}
x = 0/0
y = 1/0
json.encode({1, x, y, 2}) return rtype see :ref:`json.cfg <json-module_cfg>` string table tarantool> json = require('json')
---
...
tarantool> json.decode('123')
---
- 123
...
tarantool> json.decode('[123, "hello"]')
---
- [123, 'hello']
...
tarantool> json.decode('{"hello": "world"}').hello
---
- world
... tarantool> json.encode(setmetatable({'A', 'B'}, { __serialize="seq"}))
---
- '["A","B"]'
...
tarantool> json.encode(setmetatable({'A', 'B'}, { __serialize="map"}))
---
- '{"1":"A","2":"B"}'
...
tarantool> json.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="map"})})
---
- '[{"f2":"B","f1":"A"}]'
...
tarantool> json.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="seq"})})
---
- '[[]]'
... tarantool> json.encode({1, x, y, 2})
---
- '[1,nan,inf,2]
... tarantool> json=require('json')
---
...
tarantool> json.encode(123)
---
- '123'
...
tarantool> json.encode({123})
---
- '[123]'
...
tarantool> json.encode({123, 234, 345})
---
- '[123,234,345]'
...
tarantool> json.encode({abc = 234, cde = 345})
---
- '{"cde":345,"abc":234}'
...
tarantool> json.encode({hello = {'world'}})
---
- '{"hello":["world"]}'
... the original contents formatted as a Lua table. the original value reformatted as a JSON string. Project-Id-Version: Tarantool 1.10
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
 **Поведение изменилось:** До версии 1.10.4 Tarantool'а, если глубина вложения структуры была больше, чем ``cfg.encode_max_depth``, более глубокие уровни обрезаются (кодируются как nil). **Пример:** -- Когда полю Lua-таблицы присваивается nil, это поле -- null
tarantool> {nil, 'a', 'b'}
---
- - null
  - a
  - b
...
-- Когда полю Lua-таблицы присваивается json.NULL, это поле --  json.NULL
tarantool> {json.NULL, 'a', 'b'}
---
- - null
  - a
  - b
...
-- Когда JSON-полю присваивается json.NULL, это поле -- null
tarantool> json.encode({field2 = json.NULL, field1 = 'a', field3 = 'c'})
---
- '{"field2":null,"field1":"a","field3":"c"}'
... :ref:`json.NULL <json-null>` :ref:`json.cfg() <json-module_cfg>` :ref:`json.decode() <json-decode>` :ref:`json.encode() <json-encode>` Значение, сопоставимое с нулевым значением "nil" в языке Lua, которое можно использовать в качестве объекта-заполнителя в кортеже. Аналог "nil" в языке Lua  Ниже приведен перечень всех функций и элементов модуля ``json``. Конвертация JSON-строки в Lua-объект Конвертация JSON-строки в Lua-объект. Конвертация Lua-объекта в JSON-строку Конвертация Lua-объекта в JSON-строку. Например, следующий код интерпретирует 0/0 как nan ("не является числом"), а 1/0 -- как inf ("бесконечность"), вместо того, чтобы вернуть nil или ошибку: Указатель Модуль `json` Имя Теперь результатом станет ошибка с указанием недостаточной глубины ``cfg.encode_max_depth``. Чтобы вернуть старое поведение системы, выполните ``cfg.encode_deep_as_nil = true``. Общие сведения Параметры Чтобы увидеть применение ``json.decode()`` в приложении, см. практическое задание :ref:`Подсчет суммы по JSON-полям во всех кортежах <c_lua_tutorial-sum_a_json_field>`. Сериализация 'A' и' B' различными значениями ``__serialize`` приводит к различным результатам: Определение глобальных флагов Определяет значения, которые влияют на поведение :ref:`json.encode <json-encode>` и :ref:`json.decode <json-decode>`. Структуру JSON-вывода можно указать с помощью ``__serialize``: Модуль ``json`` определяет процедуры работы с форматом JSON. Он создан на основе `модуля Lua-CJSON от Mark Pulford <http://www.kyne.com.au/~mark/software/lua-cjson.php>`_. Полное руководство по Lua-CJSON включено в `официальную документацию <http://www.kyne.com.au/~mark/software/lua-cjson-manual.html>`_. Результат запроса ``json.encode()`` будет следующим: Такие параметры конфигурации применяются для формата JSON, для :ref:`MsgPack <msgpack-module>` и для :ref:`YAML <yaml-module>`. Задаются либо все целочисленные значения, либо все логические значения ``true``/``false`` (правда/ложь). Этот параметр не учитывается для ``YAML``. Чтобы получить такой же эффект для одиночного вызова ``json.encode()`` без постоянного изменения конфигурации, можно вызвать ``json.encode({1, x, y, 2}, {encode_invalid_numbers = true})``. Назначение ``__serialize="map"`` для ассоциативного массива ``__serialize="seq"`` для массива ``cfg.decode_invalid_numbers`` (по умолчанию, true) -- разрешить nan и inf ``cfg.decode_max_depth`` (по умолчанию, 32) -- максимальная глубина вложенности в структуре ``cfg.decode_save_metatables`` (по умолчанию, true) -- как ``encode_load_metatables`` ``cfg.encode_deep_as_nil`` ((по умолчанию, false) -- см. :ref:`ниже <json-module.cfg_encode_deep_as_nil>` ``cfg.encode_invalid_as_nil`` (по умолчанию, false) -- использовать ``null`` для всех нераспознаваемых типов ``cfg.encode_invalid_numbers`` (по умолчанию, true) -- разрешить nan и inf ``cfg.encode_max_depth`` (по умолчанию, 32) -- максимальная глубина вложенности в структуре ``cfg.encode_number_precision`` (по умолчанию, 14) -- максимальное количество цифр в дробной части ``cfg.encode_sparse_convert`` (по умолчанию, true) -- обрабатывать излишне разреженные массивы как ассоциативные массивы ``cfg.encode_sparse_ratio`` (по умолчанию, 2) -- допустимая разреженность массива ``cfg.encode_sparse_safe`` (по умолчанию, 10) -- безопасная разреженность массивы ``cfg.encode_use_tostring`` (по умолчанию, false) -- использовать ``tostring`` для нераспознаваемых типов строка в формате JSON. скалярное значение или значение из Lua-таблицы. json = require('json')
json.cfg{encode_invalid_numbers = true}
x = 0/0
y = 1/0
json.encode({1, x, y, 2}) возвращает тип возвращаемого значения see :ref:`json.cfg <json-module_cfg>` строка таблица tarantool> json = require('json')
---
...
tarantool> json.decode('123')
---
- 123
...
tarantool> json.decode('[123, "hello"]')
---
- [123, 'hello']
...
tarantool> json.decode('{"hello": "world"}').hello
---
- world
... tarantool> json.encode(setmetatable({'A', 'B'}, { __serialize="seq"}))
---
- '["A","B"]'
...
tarantool> json.encode(setmetatable({'A', 'B'}, { __serialize="map"}))
---
- '{"1":"A","2":"B"}'
...
tarantool> json.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="map"})})
---
- '[{"f2":"B","f1":"A"}]'
...
tarantool> json.encode({setmetatable({f1 = 'A', f2 = 'B'}, { __serialize="seq"})})
---
- '[[]]'
... tarantool> json.encode({1, x, y, 2})
---
- '[1,nan,inf,2]
... tarantool> json=require('json')
---
...
tarantool> json.encode(123)
---
- '123'
...
tarantool> json.encode({123})
---
- '[123]'
...
tarantool> json.encode({123, 234, 345})
---
- '[123,234,345]'
...
tarantool> json.encode({abc = 234, cde = 345})
---
- '{"cde":345,"abc":234}'
...
tarantool> json.encode({hello = {'world'}})
---
- '{"hello":["world"]}'
... оригинальное содержание в формате Lua-таблицы. оригинальное значение, преобразованное в JSON-строку. 