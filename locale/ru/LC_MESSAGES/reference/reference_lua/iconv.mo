��                               *        E  �   d  +   @     l     �     �  x   �  H   '     p     v     �     �  
   �     �  �   �     t  z  x  6   �     *     D     K  D   Q  �   �  3   r	  1   �	  =   �	  .   
     E
  �  N
     �  *        .  _  M  Z   �  9        B  +   `  �   �  �   X          (     =     D     `  )   s  <  �     �  �  �  d   �          4  2   I  D   |  �   �  =   �  3   �  ^     9   n  -   �   **Example:** :ref:`iconv.converter() <iconv-converter>` :ref:`iconv.new() <iconv-new>` An exact list of the available encodings may depend on environment. Typically the list includes ASCII, BIG5, KOI8R, LATIN8, MS-GREEK, SJIS, and about 100 others. For a complete list, type ``iconv --list`` on a terminal. Below is a list of all ``iconv`` functions. Construct a new iconv instance. Convert. Create an iconv instance If anything in input-string cannot be converted, there will be an error message and the result string will be unchanged. If either parameter is not a valid name, there will be an error message. Index Module `iconv` Name Overview Parameters Perform conversion on a string The ``iconv`` module provides a way to convert a string with one encoding to a string with another encoding, for example from ASCII to UTF-8. It is based on the POSIX iconv routines. Use We know that the Unicode code point for "Д" (CYRILLIC CAPITAL LETTER DE) is hexadecimal 0414 according to the character database of Unicode_. Therefore that is what it will look like in UTF-16. We know that Tarantool typically uses the UTF-8 character set. So make a from-UTF-8-to-UTF-16 converter, use string.hex('Д') to show what Д's encoding looks like in the UTF-8 source, and use string.hex('Д'-after-conversion) to show what it looks like in the UTF-16 target. Since the result is 0414, we see that iconv conversion works. (Different iconv implementations might use different names, for example UTF-16BE instead of UTF16BE.) a new iconv instance -- in effect, a callable function param string input-string return rtype tarantool> converter = require('iconv').new('UTF8', 'ASCII')
---
... tarantool> string.hex('Д')
---
- d094
...

tarantool> converter = require('iconv').new('UTF16BE', 'UTF8')
---
...

tarantool> utf16_string = converter('Д')
---
...

tarantool> string.hex(utf16_string)
---
- '0414'
... the name of the encoding that we will convert from. the name of the encoding that we will convert to. the string that results from the conversion (the "to" string) the string to be converted (the "from" string) userdata Project-Id-Version: Tarantool 1.10
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
 **Пример:** :ref:`iconv.converter() <iconv-converter>` :ref:`iconv.new() <iconv-new>` Точный список доступных кодировок зависит от окружения. Как правило, в список входят ASCII, BIG5, KOI8R, LATIN8, MS-GREEK, SJIS и около 100 других. Чтобы увидеть общий список, введите команду ``iconv --list`` в терминале. Ниже приведен перечень всех функций модуля ``iconv``. Создание нового iconv-экземпляра. Преобразование. Создание экземпляра iconv Если что-либо в строке input-string нельзя преобразовать, появится сообщение об ошибке, строка останется неизменной. Если значение одного из параметров представляет собой недопустимое имя, появится сообщение об ошибке. Указатель Модуль `iconv` Имя Общие сведения Параметры Преобразование строки Модуль ``iconv`` предоставляет метод конвертации строки с одним типом кодировки в строку с другим типом кодировки, например из ASCII в UTF-8. Он основывается на процедурах с iconv в POSIX. Назначение Мы знаем, что кодовая точка для заглавной буквы "Д" в Unicode представляет собой шестнадцатеричное число 0414 в соответствии с таблицей символов Unicode_. Таким образом, так она будет выглядеть в UTF-16. Мы знаем, что как правило, Tarantool использует набор символов UTF-8. Поэтому для создания конвертора из UTF-8 в UTF-16 используем string.hex('Д'), чтобы показать, как выглядит кодировка Д в исходном наборе символов UTF-8, а затем используем string.hex('Д'-after-conversion), чтобы показать, как она будет выглядеть в целевом наборе символов UTF-16. Поскольку результатом будет 0414, видим, что преобразование с помощью iconv сработало. (В разных реализациях iconv могут использоваться разные имена, например UTF-16BE вместо UTF16BE.) новый экземпляр iconv -- на самом деле, вызываемая функция param string input-string возвращает тип возвращаемого значения tarantool> converter = require('iconv').new('UTF8', 'ASCII')
---
... tarantool> string.hex('Д')
---
- d094
...

tarantool> converter = require('iconv').new('UTF16BE', 'UTF8')
---
...

tarantool> utf16_string = converter('Д')
---
...

tarantool> string.hex(utf16_string)
---
- '0414'
... название используемой кодировки. название будущей кодировки. строка, получаемая в результате преобразования ("в") строка для преобразования ("из") пользовательские данные 