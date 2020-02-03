��          �               �  b  �  K  �  a   <  x   �          1  �   >  o   	     �	  
   �	  -   �	     �	  �   �	     o
  �   u
  �   X  �   �  �   u  �       �  �   �     �  �  �  �  P  �  �  �   |  �   6  ,   /     \  �  n  �        �     �     
     �    �  2   �   s  �   �   ^"  &  Y#    �$  m  �%     �*  �   +     �+     function tarantool_sort(input_table, collation)
      local c = collation or 'binary'
      local tmp_name = 'Temporary_for_tarantool_sort'
      pcall(function() box.space[tmp_name]:drop() end)
      box.schema.space.create(tmp_name, {temporary = true})
      box.space[tmp_name]:create_index('I')
      box.space[tmp_name]:create_index('I2',
                                       {unique = false,
                                        type='tree',
                                        parts={{2, 'scalar',
                                                collation = c,
                                                is_nullable = true}}})
      for i = 1, table.maxn(input_table) do
          box.space[tmp_name]:insert{i, input_table[i]}
      end
      local t = box.space[tmp_name].index.I2:select()
      for i = 1, table.maxn(input_table) do
          input_table[i] = t[i][2]
      end
      box.space[tmp_name]:drop()
    end

For example, suppose table t = {1, 'A', -88.3, nil, true, 'b', 'B', nil, 'À'}.
After tarantool_sort(t, 'unicode_ci') t contains {nil, nil, true, -88.3, 1, 'A', 'À', 'b', 'B'}. (1) If the table contains nils, except nils at the end, the results must still be correct. That is not the case with the default tarantool_sort, and it cannot be fixed by making a comparison that checks whether a and b are nil. (Before trying certain Internet suggestions, test with {1, nil, 2, -1, 44, 1e308, nil, 2, nil, nil, 0}. (2) If strings are to be sorted in a language-aware way, there must be a parameter for collation. (3) If the table has a mix of types, then they must be sorted as booleans, then numbers, then strings, then byte arrays. (table) the table to copy **Example:** Here then is ``tarantool_sort()`` which does the same thing as ``table.sort`` but has those extra features. It is not fast and it requires a database privilege, so it should only be used if the extra features are necessary. In this section we only discuss the additional function that the Tarantool developers have added: ``deepcopy``. Module `table` Parameters Put the input-table contents in sorted order. Return Return a "deep" copy of the table -- a copy which follows nested structures to any depth and does not depend on pointers, it copies the contents. Rtype Since all those features are available in Tarantool spaces, the solution for Tarantool is simple: make a temporary Tarantool space, put the table contents into it, retrieve the tuples from it in order, and overwrite the table. That is efficient and standard. However, sometimes Tarantool users will want an equivalent to ``table.sort`` which has any of these features: The :code:`table` module has everything in the `standard Lua table library <https://www.lua.org/pil/19.html>`_, and some Tarantool extensions. The `basic Lua table.sort <https://www.lua.org/manual/5.1/manual.html#pdf-table.sort>`_ has a default comparison-function: :code:`function (a, b) return a < b end`. You can see this by saying "table": you will see this list of functions: ``clear`` (LuaJIT extension = erase all elements), `concat <https://www.lua.org/manual/5.1/manual.html#pdf-table.concat>`_ (concatenate), ``copy`` (make a copy of an array), ``deepcopy`` (see description below), ``foreach``, ``foreach1``, `getn <https://www.lua.org/pil/19.1.html>`_ (get the number of elements in an array), `insert <https://www.lua.org/manual/5.1/manual.html#pdf-table.insert>`_ (insert an element into an array), `maxn <https://www.lua.org/manual/5.1/manual.html#pdf-table.maxn>`_ (get largest index) `move <https://www.lua.org/manual/5.3/manual.html#pdf-table.move>`_ (move elements between tables), ``new`` (LuaJIT extension = return a new table with pre-allocated elements), `remove <https://www.lua.org/manual/5.1/manual.html#pdf-table.remove>`_ (remove an element from an array), `sort <https://www.lua.org/manual/5.1/manual.html#pdf-table.sort>`_ (sort the elements of an array). table tarantool> input_table = {1,{'a','b'}}
---
...

tarantool> output_table = table.deepcopy(input_table)
---
...

tarantool> output_table
---
- - 1
  - - a
    - b
... the copy of the table Project-Id-Version: Tarantool 1.10
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
 function tarantool_sort(input_table, collation)
      local c = collation or 'binary'
      local tmp_name = 'Temporary_for_tarantool_sort'
      pcall(function() box.space[tmp_name]:drop() end)
      box.schema.space.create(tmp_name, {temporary = true})
      box.space[tmp_name]:create_index('I')
      box.space[tmp_name]:create_index('I2',
                                       {unique = false,
                                        type='tree',
                                        parts={{2, 'scalar',
                                                collation = c,
                                                is_nullable = true}}})
      for i = 1, table.maxn(input_table) do
          box.space[tmp_name]:insert{i, input_table[i]}
      end
      local t = box.space[tmp_name].index.I2:select()
      for i = 1, table.maxn(input_table) do
          input_table[i] = t[i][2]
      end
      box.space[tmp_name]:drop()
    end

Например, предположим, что таблица t = {1, 'A', -88.3, nil, true, 'b', 'B', nil, 'À'}.
После tarantool_sort(t, 'unicode_ci') t содержит {nil, nil, true, -88.3, 1, 'A', 'À', 'b', 'B'}. (1) Если таблица содержит нулевые значения, за исключением нулей в конце, результаты все равно должны быть правильными. Это не работает при использовании стандартного tarantool_sort, и это нельзя исправить, выполнив сравнение, которое проверяет, равны ли значения a и b нулю. (Прежде чем пробовать определенные предложения в Интернете, проверьте {1, nil, 2, -1, 44, 1e308, nil, 2, nil, nil, 0}. (2) Если строки должны быть отсортированы с учетом языка, должен быть параметр для сравнения символов. (3) Если в таблица есть разные типы, то они должны быть отсортированы так: логические, затем числа, затем строки, а затем байтовые массивы. таблица для копирования **Пример:** Тогда ``tarantool_sort()`` сделает то же самое, что и ``table.sort``, но с этими дополнительными функциями. Это не быстрый способ, который требует прав на базу данных, поэтому его следует использовать только при необходимости дополнительных функций. В данном разделе мы рассматриваем только дополнительную функцию, добавленную разработчиками Tarantool'а: ``deepcopy``. Модуль `table` Параметры Размещение содержимого введенной таблицы в отсортированном порядке. Возвращается Возврат детальной копии таблицы -- копии, которая включает в себя вложенные структуры любой глубины и не зависит от указателей, копируется содержимое. Тип возвращаемого значения Поскольку все эти функции доступны в спейсах Tarantool'а, решение простое: создайте временный спейс в Tarantool'е, поместите в него содержимое таблицы, извлеките из него кортежи по порядку и перезапишите таблицу. Эта стандартная функция эффективна. Однако иногда пользователям Tarantool'а может понадобиться эквивалент ``table.sort`` со следующими функциями: Модуль :code:`table` включает в себя всё из `стандартной библиотеки для работы с таблицами в Lua <https://www.lua.org/pil/19.html>`_, а также некоторые расширения специально для Tarantool'а. В базовой сортировке в Lua, `table.sort <https://www.lua.org/manual/5.1/manual.html#pdf-table.sort>`_, есть функция сравнения, которая используется по умолчанию: :code:`function (a, b) return a < b end`. Чтобы убедиться в этом, выполните команду "table": вы увидите список функций: ``clear`` (расширение LuaJIT = удаление всех элементов), `concat <https://www.lua.org/manual/5.1/manual.html#pdf-table.concat>`_ (конкатенация), ``copy`` (создание копии массива), ``deepcopy`` (см. описание ниже), ``foreach``, ``foreach1``, `getn <https://www.lua.org/pil/19.1.html>`_ (получение количества элементов в массиве), `insert <https://www.lua.org/manual/5.1/manual.html#pdf-table.insert>`_ (вставка элемента в массив), `maxn <https://www.lua.org/manual/5.1/manual.html#pdf-table.maxn>`_ (получение самого большого индекса) `move <https://www.lua.org/manual/5.3/manual.html#pdf-table.move>`_ (перемещение элементов между таблицами), ``new`` (расширение LuaJIT = возврат новой таблицы с предварительно выделенными элементами), `remove <https://www.lua.org/manual/5.1/manual.html#pdf-table.remove>`_ (удаление элемента из массива), `sort <https://www.lua.org/manual/5.1/manual.html#pdf-table.sort>`_ (сортировка элементов массива). таблица tarantool> input_table = {1,{'a','b'}}
---
...

tarantool> output_table = table.deepcopy(input_table)
---
...

tarantool> output_table
---
- - 1
  - - a
    - b
... копия таблицы 