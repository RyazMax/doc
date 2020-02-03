��    /      �                          "   0  &   S     z  �   �  ,   @  -   m  &   �  e   �     (     .     >     @  
   E  *   P  �   {     3  T   7     �     �  ]   �  j   �  m   _  Y   �  b   '  m   �  [   �  a   T	  k   �	  n   "
     �
     �
     �
     �
     �
     �
     �
     �
     �
     �
     �
  #   �
       N       V  �  w       -   ,  "   Z  &   }  *   �  D  �  [     P   p  P   �  �        �     �               
  `     j  ~     �  �   �     �     �  �   �  �     �   p  �   N  �   8  �   )  �     �   �  �   �  �   �     �      �      �      �      �      �      �   2   �      �   C   �      ,!  ?   9!     y!  N  �!     �#   **Example:** **Format specifiers** :ref:`pickle.pack() <pickle-pack>` :ref:`pickle.unpack() <pickle-unpack>` A list of strings or numbers. A scalar value can be either a variable or a literal. Remember that large integers should be entered with :ref:`tonumber64() or LL or ULL suffixes <index-box_number>`. Below is a list of all ``pickle`` functions. Convert Lua variables back from binary format Convert Lua variables to binary format Counterpart to ``pickle.pack()``. Warning: if format specifier 'A' is used, it must be the last item. Index Module `pickle` N Name Parameters Possible errors: unknown format specifier. To use Tarantool binary protocol primitives from Lua, it's necessary to convert Lua variables to binary format. The ``pickle.pack()`` helper function is prototyped after Perl 'pack_'. Use a binary string containing all arguments, packed according to the format specifiers. a, A b, B converts Lua scalar value to a 1-byte integer, and stores the integer in the resulting string converts Lua scalar value to a 2-byte integer, and stores the integer in the resulting string, big endian, converts Lua scalar value to a 2-byte integer, and stores the integer in the resulting string, low byte first converts Lua scalar value to a 4-byte float, and stores the float in the resulting string converts Lua scalar value to a 4-byte integer, and stores the integer in the resulting string, big converts Lua scalar value to a 4-byte integer, and stores the integer in the resulting string, low byte first converts Lua scalar value to a 8-byte double, and stores the double in the resulting string converts Lua scalar value to a sequence of bytes, and stores the sequence in the resulting string converts Lua scalar value to an 8-byte integer, and stores the integer in the resulting string, big endian, converts Lua scalar value to an 8-byte integer, and stores the integer in the resulting string, low byte first d f i, I l, L n q, Q return rtype s, S scalar values to be formatted string string containing format specifiers table tarantool> pickle = require('pickle')
---
...
tarantool> box.space.tester:insert{0, 'hello world'}
---
- [0, 'hello world']
...
tarantool> box.space.tester:update({0}, {{'=', 2, 'bye world'}})
---
- [0, 'bye world']
...
tarantool> box.space.tester:update({0}, {
         >   {'=', 2, pickle.pack('iiA', 0, 3, 'hello')}
         > })
---
- [0, "\0\0\0\0\x03\0\0\0hello"]
...
tarantool> box.space.tester:update({0}, {{'=', 2, 4}})
---
- [0, 4]
...
tarantool> box.space.tester:update({0}, {{'+', 2, 4}})
---
- [0, 8]
...
tarantool> box.space.tester:update({0}, {{'^', 2, 4}})
---
- [0, 12]
... tarantool> pickle = require('pickle')
---
...
tarantool> tuple = box.space.tester:replace{0}
---
...
tarantool> string.len(tuple[1])
---
- 1
...
tarantool> pickle.unpack('b', tuple[1])
---
- 48
...
tarantool> pickle.unpack('bsi', pickle.pack('bsi', 255, 65535, 4294967295))
---
- 255
- 65535
- 4294967295
...
tarantool> pickle.unpack('ls', pickle.pack('ls', tonumber64('18446744073709551615'), 65535))
---
...
tarantool> num, num64, str = pickle.unpack('slA', pickle.pack('slA', 666,
         > tonumber64('666666666666666'), 'string'))
---
... Project-Id-Version: Tarantool 1.10
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
 **Пример:** **Спецификаторы формата** :ref:`pickle.pack() <pickle-pack>` :ref:`pickle.unpack() <pickle-unpack>` Список строк или чисел. Скалярное значение может быть либо переменной, либо литеральным значением. Следует помнить, что большие целые числа нужно вводить с :ref:`tonumber64() или суффиксами LL или ULL <index-box_number>`. Ниже приведен перечень всех функций модуля ``pickle``. Конвертация Lua-переменных в двоичный формат Конвертация Lua-переменных в двоичный формат Противоположность ``pickle.pack()``. Внимание: если используется спецификатор формата 'A', он должен идти последним. Указатель Модуль `pickle` N Имя Параметры Возможные ошибки: неизвестный спецификатор формата. Чтобы использовать примитивы бинарного протокола Tarantool'а из Lua, необходимо конвертировать Lua-переменные в двоичный формат. Прототипом вспомогательной функции ``pickle.pack()`` выступила функция 'pack_' из Perl. Назначение бинарная строка, которая содержит все аргументы, упакованные в соответствии со спецификаторами формата. a, A b, B конвертирует скалярное Lua-значение в 1-байтное целое число и хранит целое число в полученной строке конвертирует скалярное Lua-значение в 2-байтное целое число и хранит целое число в полученной строке, порядок от старшего к младшему, конвертирует скалярное Lua-значение в 2-байтное целое число и хранит целое число в полученной строке, сначала младший байт конвертирует скалярное Lua-значение в 4-байтное число с плавающей запятой и хранит число с плавающей запятой в полученной строке конвертирует скалярное Lua-значение в 4-байтное целое число и хранит целое число в полученной строке, порядок от старшего к младшему, конвертирует скалярное Lua-значение в 4-байтное целое число и хранит целое число в полученной строке, сначала младший байт конвертирует скалярное Lua-значение в 8-байтное число двойной точности и хранит число двойной точности в полученной строке конвертирует скалярное Lua-значение в последовательность байтов и хранит последовательность в полученной строке конвертирует скалярное Lua-значение в 8-байтное целое число и хранит целое число в полученной строке, порядок от старшего к младшему, конвертирует скалярное Lua-значение в 8-байтное целое число и хранит целое число в полученной строке, сначала младший байт d f i, I l, L n q, Q возвращает тип возвращаемого значения s, S скалярные значения к форматированию строка строка со спецификаторами формата таблица tarantool> pickle = require('pickle')
---
...
tarantool> box.space.tester:insert{0, 'hello world'}
---
- [0, 'hello world']
...
tarantool> box.space.tester:update({0}, {{'=', 2, 'bye world'}})
---
- [0, 'bye world']
...
tarantool> box.space.tester:update({0}, {
         >   {'=', 2, pickle.pack('iiA', 0, 3, 'hello')}
         > })
---
- [0, "\0\0\0\0\x03\0\0\0hello"]
...
tarantool> box.space.tester:update({0}, {{'=', 2, 4}})
---
- [0, 4]
...
tarantool> box.space.tester:update({0}, {{'+', 2, 4}})
---
- [0, 8]
...
tarantool> box.space.tester:update({0}, {{'^', 2, 4}})
---
- [0, 12]
... tarantool> pickle = require('pickle')
---
...
tarantool> tuple = box.space.tester:replace{0}
---
...
tarantool> string.len(tuple[1])
---
- 1
...
tarantool> pickle.unpack('b', tuple[1])
---
- 48
...
tarantool> pickle.unpack('bsi', pickle.pack('bsi', 255, 65535, 4294967295))
---
- 255
- 65535
- 4294967295
...
tarantool> pickle.unpack('ls', pickle.pack('ls', tonumber64('18446744073709551615'), 65535))
---
...
tarantool> num, num64, str = pickle.unpack('slA', pickle.pack('slA', 666,
         > tonumber64('666666666666666'), 'string'))
---
... 