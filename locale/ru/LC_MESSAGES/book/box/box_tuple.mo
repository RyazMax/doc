��    }                    �     �  ;   �  -   6  &   d  -   �  +   �  .   �  -   	  -   B	  1   p	  5   �	  /   �	  /   
  6   8
  :   o
  6   �
  z   �
  /   \  L  �     �     �     �  �     (   �  *   �          (  :   H  2   �     �  6   �  ;     �   G  Y   �  T  4  �  �  �  {  �     �   �  �   �  %  �  �   �  �   g  �     m  �  �   )  �   �  w   s  {   �  k   g  l   �  h   @  �   �  =  Z   �  �!  x   3#  �   �#  �   �$     *%  C   0%     t%     y%  
   �%     �%  %   �%     �%  �   �%  �   �&  B  K'  �   �(  �   2)  �   �)  �   �*  �   �+  \   r,  w   �,  "  G-     j.     y.     �.  4   �.  =   �.  D    /  *   E/     p/     |/     �/     �/     �/  ?   �/    0  �  1     �2     �2  	   3  	   3      3  	   -3     73     >3  J   N3     �3     �3  K   �3  t  �3  i  g6  �   �7  �   r8  �   9  �   �9  �   T:  b   L;  h   �;  �   <  [   �<    #=  %   )>  +   O>    {>  .   �?     �?  �  �?  �   MA     �A  �  B     �C  Z   �C  -   D  &   AD  -   hD  +   �D  .   �D  -   �D  -   E  1   ME  5   E  /   �E  /   �E  6   F  :   LF  6   �F  �   �F  ^   �G  4  H  (   DJ     mJ     �J  �   �J  :   K  <   �K  ,   �K  G   $L  w   lL  X   �L  -   =M  r   kM  v   �M     UN  �   vO  �  P  X  �Q  �  FU    �W    �X  M  	Z  �  W[  �   @]  6  ^  ;  P_  9  �`  p  �b     7d  �   8e  �   �e  �   �f  �   �g  �   Th  4  i    Ej  C  Tl  �   �n  �  no    @q     Dr  \   Qr     �r     �r     �r  (   �r  <   s  +   Js  +  vs    �t  x  �u     +x  &  ,y  ?  Sz  �  �{  0  6}  �   g~  �   B  �  >�  #   
�  $   .�     S�  ?   n�  P   ��  U   ��  *   U�     ��  C   ��     ܃  ,   ��  -   $�  g   R�    ��  �  ��  )   ��  4   ��     ߇     �     �      �  
   8�  !   C�  �   e�     �  2   !�  K   T�  t  ��  i  �  �   �  �    �  �   ��  �   W�  �   �  b   ��  h   ]�  �   Ƒ  [   u�    ђ  &   ד  O   ��    N�  R   R�     ��  �  ��  4  ��  2   ��   **Example:** ... And here is what happens when one invokes the function: :ref:`#tuple_object <box_tuple-count_fields>` :ref:`box.tuple.new() <box_tuple-new>` :ref:`tuple_object:bsize() <box_tuple-bsize>` :ref:`tuple_object:find() <box_tuple-find>` :ref:`tuple_object:findall() <box_tuple-find>` :ref:`tuple_object:pairs() <box_tuple-pairs>` :ref:`tuple_object:tomap() <box_tuple-tomap>` :ref:`tuple_object:totable() <box_tuple-totable>` :ref:`tuple_object:transform() <box_tuple-transform>` :ref:`tuple_object:unpack() <box_tuple-unpack>` :ref:`tuple_object:update() <box_tuple-update>` :ref:`tuple_object[field-name] <box_tuple-field_name>` :ref:`tuple_object[field-number] <box_tuple-field_number>` :ref:`tuple_object[field-path] <box_tuple-field_path>` A `Lua table <https://www.lua.org/pil/2.5.html>`_ can have indexed values, also called key:value pairs. For example, here: Below is a list of all ``box.tuple`` functions. Construct a new tuple from either a scalar or a Lua table. Alternatively, one can get new tuples from tarantool's :ref:`select <box_space-select>` or :ref:`insert <box_space-insert>` or :ref:`replace <box_space-replace>` or :ref:`update <box_space-update>` requests, which can be regarded as statements that do ``new()`` implicitly. Count tuple fields Create a tuple Example For details: see the description for ``operator``, ``field_no``, and ``value`` in the section :ref:`box.space.space-name:update{key, format, {field_number, value}...) <box_space-update>`. Get a tuple's field by specifying a name Get a tuple's field by specifying a number Get a tuple's fields Get a tuple's fields as a table Get a tuple's fields as a table along with key:value pairs Get a tuple's fields or parts by specifying a path Get count of bytes in a tuple Get the number of all fields matching the search value Get the number of the first field matching the search value If ``names_only`` is false or omitted (default), then all the fields will appear twice, first with numeric headings and second with name headings. If ``names_only`` is true, then all the fields will appear only once, with name headings. If ``t`` is a tuple instance, :samp:`t:transform({start-field-number},{fields-to-remove})` will return a tuple where, starting from field ``start-field-number``, a number of fields (``fields-to-remove``) are removed. Optionally one can add more arguments after ``fields-to-remove`` to indicate new values that will replace what was removed. If ``t`` is a tuple instance, ``t:bsize()`` will return the number of bytes in the tuple. With both the memtx storage engine and the vinyl storage engine the default maximum is one megabyte (:ref:`memtx_max_tuple_size <cfg_storage-memtx_max_tuple_size>` or :ref:`vinyl_max_tuple_size <cfg_storage-vinyl_max_tuple_size>`). Every field has one or more "length" bytes preceding the actual contents, so ``bsize()`` returns a value which is slightly greater than the sum of the lengths of the contents. If ``t`` is a tuple instance, ``t:find(search-value)`` will return the number of the first field in ``t`` that matches the search value, and ``t:findall(search-value [, search-value ...])`` will return numbers of all fields in ``t`` that match the search value. Optionally one can put a numeric argument ``field-number`` before the search-value to indicate “start searching at field number ``field-number``.” If ``t`` is a tuple instance, ``t:totable()`` will return all fields, ``t:totable(1)`` will return all fields starting with field number 1, ``t:totable(1,5)`` will return all fields between field number 1 and field number 5. If ``t`` is a tuple instance, ``t:unpack()`` will return all fields, ``t:unpack(1)`` will return all fields starting with field number 1, ``t:unpack(1,5)`` will return all fields between field number 1 and field number 5. If ``t`` is a tuple instance, ``t['field-name']`` will return the field named 'field-name' in the tuple. Fields have names if the tuple has been retrieved from a space that has an associated :ref:`format <box_space-format>`. If ``t`` is a tuple instance, ``t['path']`` will return the field or subset of fields that are in ``path``. ``path`` must be a well formed JSON specification. ``path`` may contain field names if the tuple has been retrieved from a space that has an associated :ref:`format <box_space-format>`. If ``t`` is a tuple instance, ``t[field-number]`` will return the field numbered field-number in the tuple. The first field is ``t[1]``. If the original tuple comes from a space that has been formatted with a :ref:`format clause <box_space-format>`, the formatting will be preserved for the result tuple. If the original tuple comes from a space that has been formatted with a :ref:`format clause <box_space-format>`, the formatting will not be preserved for the result tuple. In Lua, `lua-table-value:pairs() <https://www.lua.org/pil/7.3.html>`_ is a method which returns: ``function``, ``lua-table-value``, ``nil``. Tarantool has extended this so that ``tuple-value:pairs()`` returns: ``function``, ``tuple-value``, ``nil``. It is useful for Lua iterators, because Lua iterators traverse a value's components until an end marker is reached. In the following example, ``x`` will be a new table object containing one tuple and ``t`` will be a new tuple object. Saying ``t`` returns the entire tuple ``t``. In the following example, a tuple named ``t1`` is returned from a space that has been formatted, then tables named ``t1map1`` and ``t1map2`` are produced from ``t1``. In the following example, a tuple named ``t`` is created and then all its fields are selected using a Lua for-end loop. In the following example, a tuple named ``t`` is created and then all its fields are selected, then the result is returned. In the following example, a tuple named ``t`` is created and then its second field is updated to equal 'B'. In the following example, a tuple named ``t`` is created and then the number of fields in ``t`` is returned. In the following example, a tuple named ``t`` is created and then the second field in ``t`` is returned. In the following example, a tuple named ``t`` is created and then, starting from the second field, two fields are removed but one new one is added, then the result is returned. In the following example, a tuple named ``t`` is created and then: the number of the first field in ``t`` which matches 'a' is returned, then the numbers of all the fields in ``t`` which match 'a' are returned, then the numbers of all the fields in t which match 'a' and are at or after the second field are returned. In the following example, a tuple named ``t`` is created which has three fields, and for each field it takes one byte to store the length and three bytes to store the contents, and then there is one more byte to store a count of the number of fields, so ``bsize()`` returns ``3*(1+3)+1``. This is the same as the size of the string that :ref:`msgpack.encode({'aaa','bbb','ccc'}) <msgpack-encode>` would return. In the following example, a tuple named ``t`` is created, then all its fields are selected, then the result is returned. In the following example, a tuple named ``t`` is returned from ``replace`` and then only the relevant part (in this case, matching a name) of a relevant field is returned. Namely: the second field, the sixth part, the value following 'value='. In the following example, a tuple named ``t`` is returned from ``replace`` and then the second field in ``t`` named 'field2' is returned. Index It is preferable to use ``t:totable()`` rather than ``t:unpack()``. Name Overview Parameters Prepare for iterating Remove (and replace) a tuple's fields Submodule `box.tuple` The :ref:`tuple_object:totable() <box_tuple-totable>` function only returns a table containing the values. But the ``tuple_object:tomap()`` function returns a table containing not only the values, but also the key:value pairs. The ``#`` operator in Lua means "return count of components". So, if ``t`` is a tuple instance, ``#t`` will return the number of fields. The ``box.tuple`` submodule provides read-only access for the ``tuple`` userdata type. It allows, for a single :ref:`tuple <index-box_tuple>`: selective retrieval of the field contents, retrieval of information about size, iteration over all the fields, and conversion to a `Lua table <https://www.lua.org/pil/2.5.html>`_. The advantage of specifying a path is that Tarantool will use it to search through a tuple body and get only the tuple part, or parts, that are actually necessary. The path must be a well formed JSON specification, but it may be preceded by '.'. The '.' is a signal that the path acts as a suffix for the tuple. The value does not include the size of "struct tuple" (for the current size of this structure look in the `tuple.h <https://github.com/tarantool/tarantool/blob/1.10/src/box/tuple.h>`_ file in Tarantool's source code). Then it will find the field that contains 'b', remove that field from the tuple, and display how many bytes remain in the tuple. The function uses Tarantool ``box.tuple`` functions ``new()``, ``unpack()``, ``find()``, ``transform()``, ``bsize()``. This function updates a tuple which is not in a space. Compare the function :extsamp:`box.space.{*{space-name}*}:update({*{key}*}, {{{*{format}*}, {*{field_no}*}, {*{value}*}}, ...})` which updates a tuple in a space. This function will illustrate how to convert tuples to/from Lua tables and lists of scalars: This only works if the tuple comes from a space that has been formatted with a :ref:`format clause <box_space-format>`. To prevent ambiguity, Tarantool first tries to interpret the request as :ref:`tuple_object[field-number] <box_tuple-field_number>` or :ref:`tuple_object[field-name] <box_tuple-field_name>`. If and only if that fails, Tarantool tries to interpret the request as ``tuple_object[field-path]``. Update a tuple Update a tuple. Use ``a`` is a table with "field1: 10" and "field2: 20". ``t1map_names_only`` will contain "field1: 10", "field2: 20". ``t1map`` will contain "1: 10", "2: 20", "field1: 10", "field2: 20". a = {}; a['field1'] = 10; a['field2'] = 20 a new tuple base 1, may be negative field value. field(s) from the tuple field(s) from the tuple. field-number:value pair(s) and key:value pair(s) from the tuple format = {{'field1', 'unsigned'}, {'field2', 'unsigned'}}
s = box.schema.space.create('test', {format = format})
s:create_index('pk',{parts={1,'unsigned',2,'unsigned'}})
t1 = s:insert{10, 20}
t1map = t1:tomap()
t1map_names_only = t1:tomap({names_only=true}) function example()
  local tuple1, tuple2, lua_table_1, scalar1, scalar2, scalar3, field_number
  local luatable1 = {}
  tuple1 = box.tuple.new({'a', 'b', 'c'})
  luatable1 = tuple1:totable()
  scalar1, scalar2, scalar3 = tuple1:unpack()
  tuple2 = box.tuple.new(luatable1[1],luatable1[2],luatable1[3])
  field_number = tuple2:find('b')
  tuple2 = tuple2:transform(field_number, 1)
  return 'tuple2 = ' , tuple2 , ' # of bytes = ' , tuple2:bsize()
end function, lua-value, nil function, tuple-value, nil lua-table lua-value lua-value(s) new tuple number number of bytes operation type represented in string (e.g. '``=``' for 'assign new value') return rtype tarantool> example()
---
- tuple2 =
- ['a', 'c']
- ' # of bytes = '
- 5
... tarantool> format = {}
---
...
tarantool> format[1] = {name = 'field1', type = 'unsigned'}
---
...
tarantool> format[2] = {name = 'field2', type = 'array'}
---
...
tarantool> format[3] = {name = 'field4', type = 'string' }
---
...
tarantool> format[4] = {name = "[2][6]['пw']['Я']", type = 'string'}
---
...
tarantool> s = box.schema.space.create('test', {format = format})
---
...
tarantool> pk = s:create_index('pk')
---
...
tarantool> field2 = {1, 2, 3, "4", {5,6,7}, {пw={Я="п"}, key="V!", value="K!"}}
---
...
tarantool> t = s:replace{1, field2, "123456", "Not K!"}
---
...
tarantool> t["[2][6]['value']"]
---
- K!
... tarantool> format = {}
---
...
tarantool> format[1] = {name = 'field1', type = 'unsigned'}
---
...
tarantool> format[2] = {name = 'field2', type = 'string'}
---
...
tarantool> s = box.schema.space.create('test', {format = format})
---
...
tarantool> pk = s:create_index('pk')
---
...
tarantool> t = s:replace{1, 'Я'}
---
...
tarantool> t['field2']
---
- Я
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:totable()
---
- ['Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5']
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:transform(2, 2, 'x')
---
- ['Fld#1', 'x', 'Fld#4', 'Fld#5']
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:unpack()
---
- Fld#1
- Fld#2
- Fld#3
- Fld#4
- Fld#5
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:update({{'=', 2, 'B'}})
---
- ['Fld#1', 'B', 'Fld#3', 'Fld#4', 'Fld#5']
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> tmp = ''
---
...
tarantool> for k, v in t:pairs() do
         >   tmp = tmp .. v
         > end
---
...
tarantool> tmp
---
- Fld#1Fld#2Fld#3Fld#4Fld#5
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4'}
---
...
tarantool> #t
---
- 4
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4'}
---
...
tarantool> t[2]
---
- Fld#2
... tarantool> t = box.tuple.new{'a', 'b', 'c', 'a'}
---
...
tarantool> t:find('a')
---
- 1
...
tarantool> t:findall('a')
---
- 1
- 4
...
tarantool> t:findall(2, 'a')
---
- 4
... tarantool> t = box.tuple.new{'aaa', 'bbb', 'ccc'}
---
...
tarantool> t:bsize()
---
- 13
... tarantool> x = box.space.tester:insert{
         >   33,
         >   tonumber('1'),
         >   tonumber64('2')
         > }:totable()
---
...
tarantool> t = box.tuple.new{'abc', 'def', 'ghi', 'abc'}
---
...
tarantool> t
---
- ['abc', 'def', 'ghi', 'abc']
... the number of the field in the tuple. the only possible option is ``names_only``. the only possible option is ``names_only``.  If ``names_only`` is false or omitted (default), then all the fields will appear twice, first with numeric headings and second with name headings.  If ``names_only`` is true, then all the fields will appear only once, with name headings. the value that will become the tuple contents. tuple tuple = box.tuple.new({scalar1, scalar2, ... scalar_n}) -- scalars to tuple
lua_table = {tuple:unpack()}                            -- tuple to Lua table
lua_table = tuple:totable()                             -- tuple to Lua table
scalar1, scalar2, ... scalar_n = tuple:unpack()         -- tuple to scalars
tuple = box.tuple.new(lua_table)                        -- Lua table to tuple what field the operation will apply to. The field number can be negative, meaning the position from the end of tuple. (#tuple + negative field number + 1) what value will be applied Project-Id-Version: Tarantool 1.10
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2020-02-03 19:10+0000
PO-Revision-Date: 2019-12-06 16:11+0300
Last-Translator: 
Language: ru
Language-Team: 
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
 **Пример:** ... А вот что происходит, когда вызывается функция: :ref:`#tuple_object <box_tuple-count_fields>` :ref:`box.tuple.new() <box_tuple-new>` :ref:`tuple_object:bsize() <box_tuple-bsize>` :ref:`tuple_object:find() <box_tuple-find>` :ref:`tuple_object:findall() <box_tuple-find>` :ref:`tuple_object:pairs() <box_tuple-pairs>` :ref:`tuple_object:tomap() <box_tuple-tomap>` :ref:`tuple_object:totable() <box_tuple-totable>` :ref:`tuple_object:transform() <box_tuple-transform>` :ref:`tuple_object:unpack() <box_tuple-unpack>` :ref:`tuple_object:update() <box_tuple-update>` :ref:`tuple_object[field-name] <box_tuple-field_name>` :ref:`tuple_object[field-number] <box_tuple-field_number>` :ref:`tuple_object[field-path] <box_tuple-field_path>` В `Lua-таблице <https://www.lua.org/pil/2.5.html>`_ могут быть индексированные значения, которые также называются пары ключ-значение. Например, здесь: Ниже приведен перечень всех функций модуля ``box.tuple``. Создание нового кортежа либо из скаляра, либо из Lua-таблицы.  Возможен и вариант получения новых кортежей из запросов :ref:`select <box_space-select>` или :ref:`insert <box_space-insert>`. или :ref:`replace <box_space-replace>`, или :ref:`update <box_space-update>` Tarantool'а, которые можно рассматривать в качестве операторов, косвенно выполняющих операцию создания ``new()``. Подсчет полей кортежа Создание кортежа Пример Более подробную информацию см. в описании ``operator``, ``field_no`` и ``value`` в разделе :ref:`box.space.space-name:update{key, format, {field_number, value}...) <box_space-update>`. Получение поля кортежа по имени Получение поля кортежа по номеру Получение полей кортежа Получение полей кортежа в виде таблицы Получение полей кортежа в виде таблицы, а также пар ключ-значение Получение полей кортежа или компонентов по пути Подсчет байтов в кортеже Получение номеров всех полей, совпадающих с искомым значением Получение номера первого поля, совпадающего с искомым значением Если ``names_only`` принимает значение false или не указан (по умолчанию), то все поля появятся дважды: сначала с числовыми заголовками, а затем с именными заголовками. Если же ``names_only`` = true, то все поля будут выведены один раз с именными заголовками. Если ``t`` -- это экземпляр кортежа, то :samp:`t:transform({start-field-number},{fields-to-remove})` вернет кортеж, где начиная с поля ``start-field-number``, удаляется количество полей (``fields-to-remove``). Дополнительно можно добавить аргументы после ``fields-to-remove``, чтобы указать новые значения на замену удаленных. Если ``t`` -- это экземпляр кортежа, то ``t:bsize()`` вернет количество байтов в кортеже. Как для движка базы данных memtx, так и для движка vinyl максимальное количество, используемое по умолчанию, составляет один мегабайт (:ref:`memtx_max_tuple_size <cfg_storage-memtx_max_tuple_size>` или :ref:`vinyl_max_tuple_size <cfg_storage-vinyl_max_tuple_size>`). В каждом поле есть один или более байтов "длины", которые предваряют само содержимое поля, поэтому ``bsize()`` вернет значение, которое незначительно больше, чем сумма длин всего содержимого. Если ``t`` -- это экземпляр кортежа, то ``t:find(search-value)`` вернет номер первого поля в ``t``, которое совпадает с искомым значением, а ``t:findall(search-value [, search-value ...])`` вернет номера всех колей в ``t``, которые совпадают с искомым значением. Можно дополнительно добавить числовой аргумент ``field-number`` перед search-value, чтобы задать условие “начинать поиск с номера поля ``field-number``.” Если ``t`` -- это экземпляр кортежа, то ``t:totable()`` вернет все поля, ``t:totable(1)`` вернет все поля, начиная с поля №1, ``t:totable(1,5)`` вернет все поля между полем №1 и полем №5. Если ``t`` -- это экземпляр кортежа, то ``t:unpack()`` вернет все поля, ``t:unpack(1)`` вернет все поля, начиная с поля №1, ``t:unpack(1,5)`` вернет все поля между полем №1 и полем №5. Если ``t`` -- это экземпляр кортежа, то ``t['field-name']`` вернет поле под названием `field-name` в кортеже. У полей есть имена, если кортеж был получен из спейса с определенным :ref:`форматом <box_space-format>`. Если ``t`` -- это экземпляр кортежа, то ``t['path']`` вернет поле или ряд полей, которые находятся в ``path``. Параметр ``path`` должен представлять собой правильную JSON-спецификацию. ``path`` может содержать имена полей, если кортеж был получен из спейса с заданным :ref:`форматом <box_space-format>`. Если ``t`` -- это экземпляр кортежа, то ``t[номер-поля]`` вернет поле под номером номер-поля в кортеже. Первое поле -- это ``t[1]``. Если первоначальный кортеж приходит из спейса, который был форматирован посредством :ref:`оператора формата <box_space-format>`, форматирование возвращаемого кортежа сохранится. Если первоначальный кортеж приходит из спейса, который был форматирован посредством :ref:`оператора формата <box_space-format>`, форматирование возвращаемого кортежа не сохранится. В языке Lua метод `lua-table-value:pairs() <https://www.lua.org/pil/7.3.html>`_ возвращает: ``функция``, ``значение-Lua-таблицы``, ``nil``. В Tarantool'е метод расширен так, что ``tuple-value:pairs()`` возвращает: ``функция``, ``значение-кортежа``, ``nil``, -- что используется для Lua-итераторов, поскольку они обходят компоненты значения до тех пор, пока не достигнут маркера. В следующем примере ``x`` будет представлять собой новый объект таблицы, который содержит один кортеж, а ``t`` будет представлять собой объект кортежа. Если ввести команду ``t``, будет получен весь кортеж ``t``. В следующем примере возвращается кортеж с именем ``t1`` из спейса после форматирования, затем таблицы с именами ``t1map`` и ``t1map2`` создаются из ``t1``. В следующем примере создается кортеж под названием ``t``, а затем все его поля выбираются с помощью Lua-цикла for. В следующем примере создается кортеж под названием ``t``, а затем делается выборка всех полей, возвращается результат. В следующем примере создается кортеж под названием ``t``, а затем второе поле обновляется до равного 'B'. В следующем примере создается кортеж под названием ``t``, а затем возвращается количество полей в кортеже ``t``. В следующем примере создается кортеж под названием ``t``, а затем возвращается второе поле в кортеже ``t``. В следующем примере создается кортеж под названием ``t``, а затем начиная со второго поля, удаляются два поля, а одно новое поле добавляется, затем возвращается результат. В следующем примере создается кортеж с именем ``t``, а затем: возвращается номер первого поля в ``t``, которое совпадает с 'a', затем возвращаются номера всех полей в ``t``, которые совпадают с 'a', затем возвращаются номера всех полей в t, которые совпадают с 'a', и находятся на втором месте или далее. В следующем примере создается кортеж с именем ``t``, в котором три поля, и для каждого поля один байт занимает хранение длины, и три байта занимает хранение содержимого, кроме того, один бит используется на ресурсы, поэтому ``bsize()`` вернет ``3*(1+3)+1``. Такой же размер строки вернула бы функция :ref:`msgpack.encode({'aaa','bbb','ccc'}) <msgpack-encode>`. В следующем примере создается кортеж под названием ``t``, а затем делается выборка всех полей, возвращается результат. В следующем примере кортеж под названием ``t`` возвращается после операции замены, а затем возвращается только необходимый компонент (в данном случае совпадение имени) соответствующего поля. В частности: второе поле, шестой компонент, значение после 'value='. В следующем примере кортеж под названием ``t`` возвращается после операции замены, а затем возвращается второе поле с именем 'field2' в кортеже ``t``. Индекс Рекомендуется использовать ``t:totable()``, а не ``t:unpack()``. Имя Общие сведения Параметры Подготовка к итерации Удаление (и замена) полей кортежа Вложенный модуль `box.tuple` Функция :ref:`tuple_object:totable() <box_tuple-totable>` вернет только таблицу со значениями. А функция ``tuple_object:tomap()`` вернет таблицу не только со значениями, но и с парами ключ-значение. Оператор ``#`` на языке Lua означает "вернуть количество компонентов". Таким образом, если ``t`` представляет собой кортеж, то ``#t`` вернет количество полей. Вложенный модуль ``box.tuple`` предоставляет доступ только для чтения к пользовательским данным типа кортеж ``tuple``. С его помощью для отдельного :ref:`кортежа <index-box_tuple>` можно сделать следующее: выборочно искать содержимое поля, получать информацию о размере, проводить итерацию по всем полям и выполнять преобразование в `Lua-таблицу <https://www.lua.org/pil/2.5.html>`_. При указании пути Tarantool воспользуется им для поиска по телу кортежа и вернет только тот компонент кортежа, который действительно необходим. Путь path должен представлять собой правильную JSON-спецификацию, но в начале может стоять '.'. Символ '.' означает, что путь выступает в качестве суффикса для кортежа. Значение не содержит размер кортежа "struct tuple" (чтобы узнать текущий размер данной структуры, посмотрите файл `tuple.h <https://github.com/tarantool/tarantool/blob/1.10/src/box/tuple.h>`_ в исходном коде Tarantool'а). Затем она найдет поле, которое содержит значение 'b', удалит это поле из кортежа и отобразит количество байтов, оставшихся в кортеже. Данная функция использует следующие функции ``box.tuple`` Tarantool'а: ``new()``, ``unpack()``, ``find()``, ``transform()``, ``bsize()``. Эта функция обновляет кортеж, который находится не в спейсе. Ср. функцию :extsamp:`box.space.{*{space-name}*}:update({*{key}*}, {{{*{format}*}, {*{field_no}*}, {*{value}*}}, ...})`, которая обновляет кортеж в спейсе. Представленная ниже функция проиллюстрирует, как можно преобразовать кортежи в Lua-таблицы и списки скаляров и обратно: Это сработает только в том случае, если кортеж приходит из спейса, который был форматирован посредством :ref:`оператора формата <box_space-format>`. Во избежание неоднозначности Tarantool сначала пытается интерпретировать запрос как :ref:`tuple_object[field-number] <box_tuple-field_number>` или  :ref:`tuple_object[field-name] <box_tuple-field_name>`. И только в том случае, если это не удается, Tarantool пытается интерпретировать запрос как ``tuple_object[field-path]``. Обновление кортежа Обновление кортежа. Использование ``a`` -- это таблица с "field1: 10" и "field2: 20". ``t1map_names_only`` будет содержать "field1: 10" и "field2: 20". ``t1map`` будет содержать "1: 10", "2: 20", "field1: 10", "field2: 20". a = {}; a['field1'] = 10; a['field2'] = 20 новый кортеж начиная с 1, может быть отрицательным значение поля. поле или поля из кортежа поле или поля из кортежа. пары номер-поля:значение и пары ключ:значение из кортежа format = {{'field1', 'unsigned'}, {'field2', 'unsigned'}}
s = box.schema.space.create('test', {format = format})
s:create_index('pk',{parts={1,'unsigned',2,'unsigned'}})
t1 = s:insert{10, 20}
t1map = t1:tomap()
t1map_names_only = t1:tomap({names_only=true}) function example()
  local tuple1, tuple2, lua_table_1, scalar1, scalar2, scalar3, field_number
  local luatable1 = {}
  tuple1 = box.tuple.new({'a', 'b', 'c'})
  luatable1 = tuple1:totable()
  scalar1, scalar2, scalar3 = tuple1:unpack()
  tuple2 = box.tuple.new(luatable1[1],luatable1[2],luatable1[3])
  field_number = tuple2:find('b')
  tuple2 = tuple2:transform(field_number, 1)
  return 'tuple2 = ' , tuple2 , ' # of bytes = ' , tuple2:bsize()
end функция, Lua-значение, nil функция, значение кортежа, nil Lua-таблица Lua-значение Lua-значение(я) новый кортеж число количество байтов тип операции, представленный строкой (например, '``=``' означает 'присвоить новое значение') возвращается тип возвращаемого значения tarantool> example()
---
- tuple2 =
- ['a', 'c']
- ' # of bytes = '
- 5
... tarantool> format = {}
---
...
tarantool> format[1] = {name = 'field1', type = 'unsigned'}
---
...
tarantool> format[2] = {name = 'field2', type = 'array'}
---
...
tarantool> format[3] = {name = 'field4', type = 'string' }
---
...
tarantool> format[4] = {name = "[2][6]['пw']['Я']", type = 'string'}
---
...
tarantool> s = box.schema.space.create('test', {format = format})
---
...
tarantool> pk = s:create_index('pk')
---
...
tarantool> field2 = {1, 2, 3, "4", {5,6,7}, {пw={Я="п"}, key="V!", value="K!"}}
---
...
tarantool> t = s:replace{1, field2, "123456", "Not K!"}
---
...
tarantool> t["[2][6]['value']"]
---
- K!
... tarantool> format = {}
---
...
tarantool> format[1] = {name = 'field1', type = 'unsigned'}
---
...
tarantool> format[2] = {name = 'field2', type = 'string'}
---
...
tarantool> s = box.schema.space.create('test', {format = format})
---
...
tarantool> pk = s:create_index('pk')
---
...
tarantool> t = s:replace{1, 'Я'}
---
...
tarantool> t['field2']
---
- Я
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:totable()
---
- ['Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5']
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:transform(2, 2, 'x')
---
- ['Fld#1', 'x', 'Fld#4', 'Fld#5']
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:unpack()
---
- Fld#1
- Fld#2
- Fld#3
- Fld#4
- Fld#5
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> t:update({{'=', 2, 'B'}})
---
- ['Fld#1', 'B', 'Fld#3', 'Fld#4', 'Fld#5']
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4', 'Fld#5'}
---
...
tarantool> tmp = ''
---
...
tarantool> for k, v in t:pairs() do
         >   tmp = tmp .. v
         > end
---
...
tarantool> tmp
---
- Fld#1Fld#2Fld#3Fld#4Fld#5
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4'}
---
...
tarantool> #t
---
- 4
... tarantool> t = box.tuple.new{'Fld#1', 'Fld#2', 'Fld#3', 'Fld#4'}
---
...
tarantool> t[2]
---
- Fld#2
... tarantool> t = box.tuple.new{'a', 'b', 'c', 'a'}
---
...
tarantool> t:find('a')
---
- 1
...
tarantool> t:findall('a')
---
- 1
- 4
...
tarantool> t:findall(2, 'a')
---
- 4
... tarantool> t = box.tuple.new{'aaa', 'bbb', 'ccc'}
---
...
tarantool> t:bsize()
---
- 13
... tarantool> x = box.space.tester:insert{
         >   33,
         >   tonumber('1'),
         >   tonumber64('2')
         > }:totable()
---
...
tarantool> t = box.tuple.new{'abc', 'def', 'ghi', 'abc'}
---
...
tarantool> t
---
- ['abc', 'def', 'ghi', 'abc']
... номер поля в кортеже. единственный доступный параметр -- ``names_only``. единственный доступный параметр -- ``names_only``.  Если ``names_only`` принимает значение false или не указан (по умолчанию), то все поля появятся дважды: сначала с числовыми заголовками, а затем с именными заголовками. Если же ``names_only`` = true, то все поля будут выведены один раз с именными заголовками. значение, которое станет содержимым кортежа. кортеж tuple = box.tuple.new({scalar1, scalar2, ... scalar_n}) -- скаляры в кортеж
lua_table = {tuple:unpack()}                            -- кортеж в Lua-таблицу
lua_table = tuple:totable()                             -- кортеж в Lua-таблицу
scalar1, scalar2, ... scalar_n = tuple:unpack()         -- кортеж в скаляры
tuple = box.tuple.new(lua_table)                        -- Lua-таблицу в кортеж к какому полю применяется операция. Номер поля может быть отрицательным, что означает, что позиция рассчитывается с конца кортежа. (#кортеж + отрицательный номер поля + 1) какое значение применяется 