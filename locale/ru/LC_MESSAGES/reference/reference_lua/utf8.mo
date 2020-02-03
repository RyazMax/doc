��    I      d              �     �  :   �  <   �  �   2     �  @   �          4  �   J  �        �  �   �     :  �  Y  �  �	     k     w  �   �  v     �   �     [     p     ~     �  
   �  F   �  %  �  I     I   N  
   �  a   �  B      H  �  J  �   �  �        K  �  O     B  2   Q  &   �  M   �     �          /  $   7  R   \  <   �     �                         #    )  G   0  &   x  ?   �  `   �  a   @  a   �  a     t   f  B   �  ;     B   Z  @   �  #   �  "        %     A     ]  �  k        g       <   �   �   �      R!  @   n!     �!     �!  [  �!  �   9#     $  �   %$  )   �$  �  !%  �  �'     \*  .   o*    �*  �   �+  9  �,     �-     
.     .     %.     A.  �   T.  �  �.  �   �0  �   �1     R2  �   e2  �  3  �  �4  �  �6  �   �9  �  }:     G<    \<     �?  `   �?  T   S@  �   �@  $   EA  $   jA     �A  7   �A  �   �A  �   wB  3   �B  
   1C     <C  2   QC     �C     �C  v  �C  G   E  &   _E  ?   �E  `   �E  a   'F  a   �F  a   �F  t   MG  B   �G  ;   H  B   AH  c   �H  ,   �H  2   I  7   HI  9   �I  +   �I   **Example:** -1 meaning "less", 0 meaning "equal", +1 meaning "greater" :ref:`casecmp <utf8-casecmp>` and |br| :ref:`cmp <utf8-cmp>` :ref:`isalpha <utf8-isalpha>`, |br| :ref:`isdigit <utf8-isdigit>`, |br| :ref:`islower <utf8-islower>` and |br| :ref:`isupper <utf8-isupper>` :ref:`length <utf8-length>` :ref:`lower <utf8-islower>` and |br| :ref:`upper <utf8-isupper>` :ref:`next <utf8-next>` :ref:`sub <utf8-sub>` Another way to construct a string with Unicode characters is with the \\u{hex-digits} escape mechanism, for example '\\u{41}\\u{42}' and ``utf8.char(65,66)`` both produce the string 'AB'. Byte positions for start and end can be negative, which indicates "calculate from end of string" rather than "calculate from start of string". Case conversions Character positions for start and end can be negative, which indicates "calculate from end of string" rather than "calculate from start of string". Character-at-a-time iterations Compare two strings with the Default Unicode Collation Element Table (DUCET) for the `Unicode Collation Algorithm <http://www.unicode.org/Public/UCA/10.0.0/allkeys.txt>`_. Thus 'å' is less than 'B', even though the code-point value of å (229) is greater than the code-point value of B (66), because the algorithm depends on the values in the Collation Element Table, not the code values. Compare two strings with the Default Unicode Collation Element Table (DUCET) for the `Unicode Collation Algorithm <http://www.unicode.org/Public/UCA/10.0.0/allkeys.txt>`_. Thus 'å' is less than 'B', even though the code-point value of å (229) is greater than the code-point value of B (66), because the algorithm depends on the values in the Collation Element Table, not the code-point values. Comparisons Determine character types If the string contains a byte sequence which is not valid in UTF-8, each byte in the invalid byte sequence will be counted as one character. In rare cases the upper-case result may be longer than the lower-case input, for example ``utf8.upper('ß')`` is 'SS'. In the string 'åa' the first character is 'å', it starts at position 1, it takes two bytes to store so the character after it will be at position 3, its Unicode code point value is (decimal) 229. Length in characters Module `utf8` Name Overview Parameters Return true if the input character is a digit, otherwise return false. Return true if the input character is an "alphabetic-like" character, otherwise return false. Generally speaking a character will be considered alphabetic-like provided it is typically used within a word, as opposed to a digit or punctuation. It does not have to be a character in an alphabet. Return true if the input character is lower case, otherwise return false. Return true if the input character is upper case, otherwise return false. Substrings The ``next`` function is often used in a loop to get one character at a time from a UTF-8 string. The code-point number is the value that corresponds to a character in the `Unicode Character Database <http://www.unicode.org/Public/5.2.0/ucd/UnicodeData.txt>`_ This is not the same as the byte values of the encoded character, because the UTF-8 encoding scheme is more complex than a simple copy of the code-point number. The comparison is done with at least three weights. Therefore the elements which affect secondary or later weights (such as "case" in Latin or Cyrillic alphabets, or "kana differentiation" in Japanese) are not ignored. and upper case comes after lower case. The comparison is done with primary weights. Therefore the elements which affect secondary or later weights (such as "case" in Latin or Cyrillic alphabets, or "kana differentiation" in Japanese) are ignored. If asked "is this like a Microsoft case-insensitive accent-insensitive collation" we tend to answer "yes", though the Unicode Collation Algorithm is far more sophisticated than those terms imply. The default value for end-character is the length of the input string. Therefore, saying ``utf8.sub(1, 'abc')`` will return 'abc', the same as the input string. UTF-8 is a variable-size encoding scheme. Typically a simple Latin letter takes one byte, a Cyrillic letter takes two bytes, a Chinese/Japanese character takes three bytes, and the maximum is four bytes. Use ``utf8`` is Tarantool's module for handling UTF-8 strings. It includes some functions which are compatible with ones in `Lua 5.3 <https://www.lua.org/manual/5.3/manual.html#6.5>`_ but Tarantool has much more. For example, because internally Tarantool contains a complete copy of the "International Components For Unicode" library, there are comparison functions which understand the default ordering for Cyrillic (Capital Letter Zhe Ж = Small Letter Zhe ж) and Japanese (Hiragana A = Katakana A). a UTF-8 string a UTF-8 string, the "substring" of the input value a Unicode code point value, repeatable a single UTF8 character, expressed as a one-byte string or a code point value a string encoded as UTF-8 a string encoded with UTF-8 boolean byte position of the first character byte position of the next character and the code point value of the next character byte position where to start within the string, default is 1 byte position where to stop number return rtype string table tarantool> -- show next-character position + first-character codepoint
tarantool> utf8.next('åa', 1)
---
- 3
- 229
...
tarantool> -- (loop) show codepoint of every character
tarantool> for position,codepoint in utf8.next,'åa' do print(codepoint) end
229
97
... tarantool> utf8.casecmp('é','e'),utf8.casecmp('E','e')
---
- 0
- 0
... tarantool> utf8.char(229)
---
- å
... tarantool> utf8.cmp('é','e'),utf8.cmp('E','e')
---
- 1
- 1
... tarantool> utf8.isalpha('Ж'),utf8.isalpha('å'),utf8.isalpha('9')
---
- true
- true
- false
... tarantool> utf8.isdigit('Ж'),utf8.isdigit('å'),utf8.isdigit('9')
---
- false
- false
- true
... tarantool> utf8.islower('Ж'),utf8.islower('å'),utf8.islower('9')
---
- false
- true
- false
... tarantool> utf8.isupper('Ж'),utf8.isupper('å'),utf8.isupper('9')
---
- true
- false
- false
... tarantool> utf8.len('G'),utf8.len('ж')
---
- 1
- 1
...

tarantool> string.len('G'),string.len('ж')
---
- 1
- 2
... tarantool> utf8.lower('ÅΓÞЖABCDEFG')
---
- åγþжabcdefg
... tarantool> utf8.sub('åγþжabcdefg', 5, 8)
---
- abcd
... tarantool> utf8.upper('åγþжabcdefg')
---
- ÅΓÞЖABCDEFG
... the number of characters in the string, or between start and end the position of the first character the position of the last character the same string, lower case the same string, upper case true or false Project-Id-Version: Tarantool 1.10
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
 **Пример:** -1 означает "меньше", 0 означает "равно", +1 означает "больше" :ref:`casecmp <utf8-casecmp>` and |br| :ref:`cmp <utf8-cmp>` :ref:`isalpha <utf8-isalpha>`, |br| :ref:`isdigit <utf8-isdigit>`, |br| :ref:`islower <utf8-islower>` and |br| :ref:`isupper <utf8-isupper>` :ref:`length <utf8-length>` :ref:`lower <utf8-islower>` and |br| :ref:`upper <utf8-isupper>` :ref:`next <utf8-next>` :ref:`sub <utf8-sub>` Другой способ создать строку с символами Юникода -- с помощью механизма экранирования символов \\u{шестнадцатеричные-числа}, например, в результате и '\\u{41}\\u{42}', и ``utf8.char(65,66)`` получим строку 'AB'. Позиции байта в начале и в конце могут быть отрицательными, что указывает на отсчет с конца строки, а не с начала. Замена регистра Позиции символа в начале и в конце могут быть отрицательными, что указывает на отсчет с конца строки, а не с начала. Посимвольная итерация Сравнение двух строк с Таблицей сортировки символов Юникода по умолчанию (DUCET) для `Алгоритма сортировки по Юникоду (Unicode Collation Algorithm) <http://www.unicode.org/Public/UCA/10.0.0/allkeys.txt>`_. В результате 'å' меньше, чем 'B', хотя значение кодовой точки å (229) больше значения кодовой точки B (66), поскольку алгоритм основывается на значениях Таблица сортировки символов, а не на значениях кода. Сравнение двух строк с Таблицей сортировки символов Юникода по умолчанию (DUCET) для `Алгоритма сортировки по Юникоду (Unicode Collation Algorithm) <http://www.unicode.org/Public/UCA/10.0.0/allkeys.txt>`_. В результате 'å' меньше, чем 'B', хотя значение кодовой точки å (229) больше значения кодовой точки B (66), поскольку алгоритм основывается на значениях Таблица сортировки символов, а не на значениях кодовых точек. Сравнения Определение типа символа Если строка содержит последовательность байтов, которая неприменима для UTF-8, каждый байт в неправильной последовательности будет считаться за один символ. В редких случаях результат в верхнем регистре может быть длиннее введенной строки в нижнем регистре, например, ``utf8.upper('ß')`` вернет 'SS'. В строке 'åa' первый символ -- 'å', он начинается в позиции 1, занимает два байта, поэтому символ после него будет на позиции 3, значение кодовой точки в Юникоде (десятичное) -- 229. Длина в символах Модуль `utf8` Имя Общие сведения Параметры Возврат true (правда), если введенный символ является цифрой, в остальных случаях -- false (ложь). Возврат true (правда), если введенный символ является буквенным, в остальных случаях -- false (ложь). В целом, символ считается буквенным, если он используется в рамках слова, а не как число или знак пунктуации. Такой символ необязательно должен быть буквой алфавита. Возврат true (правда), если введенный символ относится к нижнему регистру, в остальных случаях -- false (ложь). Возврат true (правда), если введенный символ относится к верхнему регистру, в остальных случаях -- false (ложь). Подстроки Функция ``next`` часто используется в цикле для получения символа за раз из строки в формате UTF-8. Число кодовой точки -- это значение, которое соответствует символу в `Базе данных символов Юникода <http://www.unicode.org/Public/5.2.0/ucd/UnicodeData.txt>`_ This is not the same as the byte values of the encoded character, because the UTF-8 encoding scheme is more complex than a simple copy of the code-point number. Сравнение осуществляется на основании не менее трех значений веса. Таким образом, не учитываются элементы, которые влияют на вторичный или последующий вес (такие как "регистр" в латинице или кириллице, или "отличия каны" в японском языке), а верхний регистр следует за нижним. Сравнение осуществляется на основании основного веса. Таким образом, не учитываются элементы, которые влияют на вторичный или последующий вес (такие как "регистр" в латинице или кириллице, или "отличия каны" в японском языке). Если спросить: "Это похоже на сортировку без учета регистра и ударения от компании Майкрософт?" - ответом будет: "Скорее да", хотя Алгоритм сортировки по Юникоду гораздо сложнее, чем это описание. Значение end-character по умолчанию -- длина введенной строки. Таким образом, выполнение ``utf8.sub(1, 'abc')`` вернет 'abc', т.е. введенную строку. UTF-8 представляет собой схему кодирования изменяемого размера. Как правило, одна буква латиницы занимает один байт, буква кириллицы занимает два байта, а символ из китайского или японского языка занимает три байта, максимальный размер -- четыре байта. Назначение ``utf8`` -- это модуль Tarantool'а для обработки строк в формате UTF-8. Он содержит некоторые функции, которые совместимы с функциями `Lua 5.3 <https://www.lua.org/manual/5.3/manual.html#6.5>`_, но возможности Tarantool'а намного больше. Например, поскольку Tarantool включает в себя полную копию библиотеки Международных компонентов для Юникода ("International Components For Unicode"), доступны также функции сравнения, которые понимают упорядочение символов в кириллице (заглавная буква  Ж = строчная буква ж) и японском языке (A в хирагане = A в катакане). строка в UTF-8 строка в формате UTF-8, "подстрока" введенного значения значение кодовой точки в Юникоде, повторяется отдельный символ UTF8, выраженный в виде однобайтной строки или значения кодовой точки строка в формате UTF-8 строка в формате UTF-8 boolean (логический) позиция байта первого символа позиция байта следующего символа и значение кодовой точки следующего символа  позиция байта внутри строки, с которой начать выполнение, по умолчанию = 1 позиция байта для остановки число возвращает тип возвращаемого значения строка таблица tarantool> -- показать позицию следующего символа + кодовую точку первого символа
tarantool> utf8.next('åa', 1)
---
- 3
- 229
...
tarantool> -- (цикл) показать кодовую точку каждого символа
tarantool> for position,codepoint in utf8.next,'åa' do print(codepoint) end
229
97
... tarantool> utf8.casecmp('é','e'),utf8.casecmp('E','e')
---
- 0
- 0
... tarantool> utf8.char(229)
---
- å
... tarantool> utf8.cmp('é','e'),utf8.cmp('E','e')
---
- 1
- 1
... tarantool> utf8.isalpha('Ж'),utf8.isalpha('å'),utf8.isalpha('9')
---
- true
- true
- false
... tarantool> utf8.isdigit('Ж'),utf8.isdigit('å'),utf8.isdigit('9')
---
- false
- false
- true
... tarantool> utf8.islower('Ж'),utf8.islower('å'),utf8.islower('9')
---
- false
- true
- false
... tarantool> utf8.isupper('Ж'),utf8.isupper('å'),utf8.isupper('9')
---
- true
- false
- false
... tarantool> utf8.len('G'),utf8.len('ж')
---
- 1
- 1
...

tarantool> string.len('G'),string.len('ж')
---
- 1
- 2
... tarantool> utf8.lower('ÅΓÞЖABCDEFG')
---
- åγþжabcdefg
... tarantool> utf8.sub('åγþжabcdefg', 5, 8)
---
- abcd
... tarantool> utf8.upper('åγþжabcdefg')
---
- ÅΓÞЖABCDEFG
... количество символов в строке или же от начала до конца позиция первого символа позиция последнего символа та же строка в нижнем регистре та же строка в верхнем регистре true (правда) или false (ложь) 