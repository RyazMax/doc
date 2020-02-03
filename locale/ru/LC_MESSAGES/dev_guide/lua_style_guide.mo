��    s      �              L    M     S  K  s  �   �  +   �  a   �  0   $  #   U  B   y  %   �  _   �     B  N   X  "   �  =   �       
   '  #   2  Y   V  w   �  �   (     �  "   �  6     !   D     f     �  @   �  :   �  ^     �   q  9   �     3     N     [     k  Q   s  @   �              '     7     V     j     �  7   �    �     �  G   �  7   <     t     �  ]   �  .   �  E   -     s  }   �  >   �  �   >     .  �   I  �   �  4   �  9   �  >   %     d  R        �  f   �     Y  T   v  4   �  �      �  �  �   �"  T   �#  U  �#  �   ,%  �   �%  -   f&  1   �&  &   �&  0   �&  &   '  /   E'  )   u'  �   �'  �   ~(  �   z)  �   *  J   �*  �   &+  L   �+  F   ,  \   _,  c   �,  �    -  X   �-     .  @   7.  �   x.      /  �   /  T   �/  \   0  �   ^0  M   �0     C1  8   Y1  D   �1      �1     �1  <   2  ]   T2  �  �2  ,  U4     �8  J  �8  �  �:  @   q<  �   �<  T   �=  Q   �=  L   L>  f   �>  �    ?  @   �?  �   )@  @   �@  }   A  7   �A     �A  7   �A  �   B  �   �B  v  �C     !E  I   AE  d   �E  -   �E  5   F     TF  h   sF  U   �F  �   2G  �   H  b   	I  .   lI     �I  @   �I     �I  �   J  b   �J     K  /   1K  0  aK  C   �M  1   �M  1   N  9   :N  k   tN    �N     �O  �   P  �   �P  '   'Q  2   OQ    �Q  �   �R  �    S  ,   �S  �   �S  _   �T  �  -U  N   �V    =W  �  \X  �   Z  >   �Z  f   �Z      3[  ]   T[  0   �[  �   �[  B   �\  z   �\  �   K]  �  �]    }_  C  �c  c   �d  v  6e  �   �f    {g  -   �h  1   �h  &   �h  0   i  &   Bi  /   ii  )   �i  �   �i  
  �j  �   �k  �   pl  J   ]m  �   �m  L   kn  F   �n  \   �n  r   \o  �   �o  �   ~p  &   "q  a   Iq  �   �q     �r  �   �r  u   �s  \   &t  �   �t  �   0u  -   �u  d   v  �   kv  O   3w  R   �w  �   �w  �   �x   #!/usr/bin/env tarantool

local test = require('tap').test('table')
test:plan(31)

do -- check basic table.copy (deepcopy)
    local example_table = {
        {1, 2, 3},
        {"help, I'm very nested", {{{ }}} }
    }

    local copy_table = table.copy(example_table)

    test:is_deeply(
        example_table,
        copy_table,
        "checking, that deepcopy behaves ok"
    )
    test:isnt(
        example_table,
        copy_table,
        "checking, that tables are different"
    )
    test:isnt(
        example_table[1],
        copy_table[1],
        "checking, that tables are different"
    )
    test:isnt(
        example_table[2],
        copy_table[2],
        "checking, that tables are different"
    )
    test:isnt(
        example_table[2][2],
        copy_table[2][2],
        "checking, that tables are different"
    )
    test:isnt(
        example_table[2][2][1],
        copy_table[2][2][1],
        "checking, that tables are different"
    )
end

<...>

os.exit(test:check() == true and 0 or 1) -- vim:ts=4 ss=4 sw=4 expandtab --- Copy any table (shallow and deep version)
-- * deepcopy: copies all levels
-- * shallowcopy: copies only first level
-- Supports __copy metamethod for copying custom tables with metatables
-- @function gsplit
-- @table         inp  original table
-- @shallow[opt]  sep  flag for shallow copy
-- @returns            table (copy) 4 spaces instead tabs. PIL suggests using of two spaces, but programmer looks at code 4 up to 8 hours a day, so it's simplier to distinguish indentation with 4 spaces. Why spaces? Similar representation everywhere. <func>'<name>' (strongly avoid require'..') A file should ends w/ one newline symbol, but shouldn't ends w/ blank line (two newline symbols). Although never is often better than *right* now. Although practicality beats purity. Although that way may not be obvious at first unless you're Dutch. Always use prefix to avoid name clash Always use round brackets in call of functions except multiple cases (common lua style idioms): Avoid global variable Avoid multiple concatenations in one statement, use ``string.format`` instead: Avoid these kind of constructions: Be generous in what you accept and strict in what you return. Beautiful is better than ugly. Commenting Complex is better than complicated. Delete whitespace at EOL (strongly forbidden. Use ``:s/\s\+$//gc`` in vim to delete them) Do not use concatenation to convert to string or addition to convert to number (use ``tostring``/``tonumber`` instead): Don't start modules with license/authors/descriptions, you can write it in LICENSE/AUTHORS/README files. For writing modules use one of the two patterns (dont use ``modules()``): Error Handling Errors should never pass silently. Every do/while/for/if/function should indent 4 spaces. Explicit is better than implicit. Flat is better than nested. Idioms and patterns If the implementation is easy to explain, it may be a good idea. If the implementation is hard to explain, it's a bad idea. In case of error, use ``nil`` for the first return value. This makes the error hard to ignore. In rare cases you may want to return ``nil`` as a legal return value. In this case it's OK to check for error first, and return second: In the face of ambiguity, refuse the temptation to guess. Indentation and Formatting Inspiration: Lua Style Guide Modules Multiline comments: use matching (``--[[ ]]--``) instead of simple (``--[[ ]]``). Namespaces are one honking great idea -- let's do more of those! Naming Now is better than never. Programming style is an art. There is some arbitrariness to the rules, but there are sound rationales for them. It is useful not only to provide sound advice on style but to understand the underlying rationale and human aspect of why the style recommendations are formed: Public function comments (??): Readability counts. Simple is better than complex. Sparse is better than dense. Special cases aren't special enough to break the rules. TAP version 13
1..31
ok - checking, that deepcopy behaves ok
ok - checking, that tables are different
ok - checking, that tables are different
ok - checking, that tables are different
ok - checking, that tables are different
ok - checking, that tables are different
... Testing There should be one -- and preferably only one -- obvious way to do it. Try to avoid multiple nested ``if``'s with common body: Type conversion Unless explicitly silenced. Unless performance of your code is paramount, try to avoid using more than two return values. Use ``and``/``or`` for default variable values Use ``tap`` module for writing efficient tests. Example of test file: Using spaces: When checking function return values, check the first argument first. If it's ``nil``, look for error in the second argument: When you'll test your code output will be something like this: With error handling this means that you must provide an error object as second multi-return value in case of error. The error object can be a string, a Lua table or cdata, in the latter cases it must have ``__tostring`` metamethod defined. You can use vim modelines: You must avoid global variables. If you have an exceptional case, use ``_G`` variable to set it, add prefix or add table instead of prefix: You should write code the way it shouldn't be described, but don't forget about commenting it. You shouldn't comment Lua syntax (assume that reader already knows Lua language). Try to tell about functions/variable names/etc. Zen of Python is good; understand it and use wisely: ``*.cfg{ }`` functions (``box.cfg``/``memcached.cfg``/..) ``*_mt`` and ``*_methods`` defines metatable and methods table ``ffi.cdef[[ ]]`` function ``function object:method() end`` (use ``functon object.method(self) end`` instead) ``if``'s and return statements: abbrevations are acceptable if they're unambigous and if you'll document (or they're too common) them. also, you may use alignment: boolean - naming ``is_<...>``, ``isnt_<...>``, ``has_``, ``hasnt_`` is a good style. do not use semicolon as table separator (only comma) extra blank lines may be used (sparingly) to separate groups of related functions. Blank lines may be omitted between a bunch of related one-liners (e.g. a set of dummy implementations) for "very local" variables: - ``t`` is for tables - ``i``, ``j`` are for indexing - ``n`` is for counting - ``k``, ``v`` is what you get out of ``pairs()`` (are acceptable, ``_`` if unused) - ``i``, ``v`` is what you get out of ``ipairs()`` (are acceptable, ``_`` if unused) - ``k``/``key`` is for table keys - ``v``/``val``/``value`` is for values that are passed around - ``x``/``y``/``z`` is for generic math quantities - ``s``/``str``/``string`` is for strings - ``c`` is for 1-char strings - ``f``/``func``/``cb`` are for functions - ``status, <rv>..`` or ``ok, <rv>..`` is what you get out of pcall/xpcall - ``buf, sz`` is a (buffer, size) pair - ``<name>_p`` is for pointers - ``t0``.. is for timestamps - ``err`` is for errors function bad_global_example()
end -- very, very bad

function good_local_example()
end
_G.modulename_good_local_example = good_local_example -- good
_G.modulename = {}
_G.modulename.good_local_example = good_local_example -- better function name (arg1,arg2,...)
end -- bad

function name(arg1, arg2, ...)
end -- good function say_greeting(period, name)
    local a = "good  " .. period .. ", " .. name
end
-- bad

function say_greeting(period, name)
    local a = string.format("good %s, %s", period, name)
end
-- good

local say_greeting_fmt = "good %s, %s"
function say_greeting(period, name)
    local a = say_greeting_fmt:format(period, name)
end
-- best function(input)
    input = input or 'default_value'
end -- good

function(input)
    if input == nil then
        input = 'default_value'
    end
end -- ok, but excessive global variables are written with ALL_CAPS. If it's some system variable, then they're using underscore to define it (``_G``/``_VERSION``/..) http://books.google.com/books?id=QnghAQAAIAAJ http://dev.minetest.net/Lua_code_style_guidelines http://mindprod.com/jgloss/unmain.html http://sputnik.freewisdom.org/en/Coding_Standard http://www.oreilly.com/catalog/perlbp/ https://github.com/Olivine-Labs/lua-style-guide https://www.python.org/dev/peps/pep-0020/ if (a == true and b == false) or (a == false and b == true) then
    <...>
end -- good

if a == true and b == false or a == false and b == true then
    <...>
end -- bad

if a ^ b == true then
end -- good, but not explicit if (a == true and b == false) or (a == false and b == true) then
    do_something()
end
-- good

if a == true then
    if b == false then
        do_something()
    end
if b == true then
    if a == false then
        do_something()
    end
end
-- bad if a == true then
    return do_something()
end
do_other_thing() -- good

if a == true then
    return do_something()
else
    do_other_thing()
end -- bad if thing then
    -- ...stuff...
end
function derp()
    -- ...stuff...
end
local wat = 7
-- bad

if thing then
    -- ...stuff...
end

function derp()
    -- ...stuff...
end

local wat = 7
-- good local M = {}

function M.foo()
...
end

function M.bar()
...
end

return M local a = 123
a = a .. ''
-- bad

local a = 123
a = tostring(a)
-- good

local a = '123'
a = a + 5 -- 128
-- bad

local a = '123'
a = tonumber(a) + 5 -- 128
-- good local data, err = foo()
if not data
    return nil, err
end
return bar(data) local data, err = foo()
if not err
    return data
end
return nil, err local function foo()
...
end

local function bar()
...
end

return {
foo = foo,
bar = bar,
} local thing = {1,2,3}
thing = {1 , 2 , 3}
thing = {1 ,2 ,3}
-- bad

local thing = {1, 2, 3}
-- good local thing=1
thing = thing-1
thing = thing*1
thing = 'string'..'s'
-- bad

local thing = 1
thing = thing - 1
thing = thing * 1
thing = 'string' .. 's'
-- good module naming snake_case (avoid underscores and dashes) - 'luasql', instead of 'Lua-SQL' names of "classes": CamelCase names of variables/"objects" and "methods"/functions: snake_case one shouldn't use spaces between function name and opening round bracket, but arguments must be splitted with one whitespace charachter or private variables/methods (properties in the future) of object starts with underscores ``<object>._<name>``. Avoid using of ``local function private_methods(self) end`` related ``or``/``and`` in ``if`` must be enclosed in the round brackets (). Example: return {
    long_key  = 'vaaaaalue',
    key       = 'val',
    something = 'even better'
} return {1,2,3,4} -- bad
return {
    key1 = val1,key2=val2
} -- bad

return {
    1, 2, 3, 4
    key1 = val1, key2 = val2,
    key3 = vallll
} -- good semicolons at the end of line (only to split multiple statements on one line) surrounding operators try to avoid unnecessary function creation (closures/..) use blank lines in function, sparingly, to indicate logical sections use space after commas in tables use space after comment marker use space in map definitions around equality sign and commas while true do -- inline comment
-- comment
do_something()
end
--[[
  multiline
  comment
]]-- Project-Id-Version: Tarantool 1.10
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2020-02-03 19:10+0000
PO-Revision-Date: 2019-11-14 20:46+0300
Last-Translator: 
Language: ru
Language-Team: 
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
 #!/usr/bin/env tarantool

local test = require('tap').test('table')
test:plan(31)

do -- проверка базовой table.copy (глубокая копия)
    local example_table = {
        {1, 2, 3},
        {"help, I'm very nested", {{{ }}} }
    }

    local copy_table = table.copy(example_table)

    test:is_deeply(
        example_table,
        copy_table,
        "checking, that deepcopy behaves ok"
    )
    test:isnt(
        example_table,
        copy_table,
        "checking, that tables are different"
    )
    test:isnt(
        example_table[1],
        copy_table[1],
        "checking, that tables are different"
    )
    test:isnt(
        example_table[2],
        copy_table[2],
        "checking, that tables are different"
    )
    test:isnt(
        example_table[2][2],
        copy_table[2][2],
        "checking, that tables are different"
    )
    test:isnt(
        example_table[2][2][1],
        copy_table[2][2][1],
        "checking, that tables are different"
    )
end

<...>

os.exit(test:check() == true and 0 or 1) -- vim:ts=4 ss=4 sw=4 expandtab --- Копирование любой таблицы (поверхностное и глубокое)
-- * deepcopy: копирует все уровни
-- * shallowcopy: копирует только первый уровень
-- Поддержка метаметода __copy для копирования специальных таблиц с метатаблицами
-- @function gsplit
-- @table         inp  оригинальная таблица
-- @shallow[opt]  sep  флаг для поверхностной копии
-- @returns            таблица (копия) 4 пробела, а не табуляция. Библиотека PIL предлагает использовать два пробела, но разработчик читает код от 4 до 8 часов в день, а различать отступы с 4 пробелами легче. Почему именно пробелы? Соблюдение однородности. <func>'<name>' (особенно избегайте require'..') Файл должен заканчиваться на один символ переноса строки, но не должен заканчиваться на пустой строке (два символа переноса строки). Хотя никогда зачастую лучше, чем прямо сейчас. При этом практичность важнее безупречности. Хотя он поначалу может быть и не очевиден. Всегда добавляйте префиксы во избежание конфликта имен Всегда пользуйтесь круглыми скобками при вызове функций, за исключением множественных случаев (распространенные идиомы в Lua): Недопущение глобальных переменных Избегайте множества конкатенаций в одном операторе, лучше использовать ``string.format``: Избегайте конструкций такого типа: Принимайте разнообразные значения и выдавайте строго определенные. Красивое лучше, чем уродливое. Комментирование Сложное лучше, чем запутанное. Удаляйте символы пробела в конце файла (они категорически запрещаются). Для их удаления в vim используйте ``:s/\s\+$//gc``. Не используйте конкатенацию для конвертации в строку или в число (вместо этого воспользуйтесь ``tostring``/``tonumber``): Не начинайте создание модуля с указания лицензии/авторов/описания, это можно сделать в файлах LICENSE/AUTHORS/README соответственно. Для написания модулей используйте один из двух шаблонов (не используйте ``modules()``): Обработка ошибок Ошибки никогда не должны замалчиваться. Отступы всех do/while/for/if/function должны составлять 4 пробела. Явное лучше, чем неявное. Плоское лучше, чем вложенное. Идиомы и шаблоны Если реализацию легко объяснить -- идея, возможно, хороша. Если реализацию сложно объяснить -- идея плоха. В случае ошибки нулевое значение ``nil`` должно быть первым возвращаемым значением. В таком случае ошибку трудно игнорировать. В редких случаях ``nil`` можно сделать возвращаемым значением. В таком случае можно сначала проверить ошибку, а потом вернуть значение: Встретив двусмысленность, отбрось искушение угадать. Отступы и форматирование Для вдохновения: Руководство по написанию кода на Lua Модули Многострочные комментарии: используйте соответствующие скобки (``--[[ ]]--``) вместо простых (``--[[ ]]``). Пространства имен -- отличная штука! Сделаем побольше! Именование Сейчас лучше, чем никогда. Придерживаться стиля в программировании -- это искусство. Даже учитывая некоторую произвольность правил, для них есть надежное обоснование. Полезно не только давать значимые советы по стилю, но также понимать основополагающие причины и человеческий аспект того, почему формируются рекомендации по стилю: Комментарии к доступным функциям (??): Читаемость имеет значение. Простое лучше, чем сложное. Разреженное лучше, чем плотное. Особые случаи не настолько особые, чтобы нарушать правила. TAP version 13
1..31
ok - checking, that deepcopy behaves ok
ok - checking, that tables are different
ok - checking, that tables are different
ok - checking, that tables are different
ok - checking, that tables are different
ok - checking, that tables are different
... Тестирование Должен существовать один -- и, желательно, только один -- очевидный способ сделать это. Постарайтесь избегать несколько вложенных ``if`` с общим телом оператора: Преобразование типов Если не замалчиваются явно. Если производительность вашего кода не имеет первоочередное значение, постарайтесь избегать использования более двух возвращаемых значений. Используйте ``and``/``or`` для указания значений переменных, используемых по умолчанию, Используйте модуль ``tap``, чтобы написать эффективные тесты. Пример файла с тестом: Использование пробелов: При проверке возвращаемых значений функции проверяйте сначала первый аргумент. Если это ``nil``, ищите ошибку во втором аргументе: После тестирования кода вывод будет примерно таким: В рамках обработки ошибок это означает, что в случае ошибки вы должны предоставить объект ошибки как второе возвращаемое значение. Объектом ошибки может быть строка, Lua-таблица или cdata, в последнем случае должен быть определен метаметод ``__tostring``. Можно использовать строки режима (modelines) vim: Следует избегать глобальных переменных. В исключительных случаях используйте переменную ``_G`` для объявления, добавьте префикс или таблицу вместо префикса: Пишите код так, чтобы его не нужно было описывать, но не забывайте о комментировании. Не следует комментировать Lua-синтаксис (примите, что читатель знаком с языком Lua). Постарайтесь рассказать о функциях, именах переменных и так далее. Дзен языка программирования Python подходит и здесь; используйте его с умом: функции ``*.cfg{ }`` (``box.cfg``/``memcached.cfg``/..) ``*_mt`` и ``*_methods`` определяют метатаблицу и таблицу методов функция ``ffi.cdef[[ ]]`` ``function object:method() end`` (используйте ``functon object.method(self) end``) операторов ``if`` и возврата: допускается использование сокращений, если они недвусмысленны, и если вы документируете их. также можно применить выравнивание: логическое именование приветствуется ``is_<...>``, ``isnt_<...>``, ``has_``, ``hasnt_``. не вставляйте точку с запятой в качестве символа-разделителя в таблице (только запятые) также можно добавлять пустые строки (не слишком часто) для выделения групп связанных функций. Пустые строки не стоит добавлять между несколькими связанными программами в одну строку (например, в формальной реализации) для "самых локальных" переменных: - ``t`` для таблиц - ``i``, ``j`` для индексации - ``n`` для подсчета - ``k``, ``v`` для получения из ``pairs()`` (допускаются, ``_`` если не используются) - ``i``, ``v`` is what you get out of ``ipairs()`` (допускаются, ``_`` если не используются) - ``k``/``key`` для ключей таблицы - ``v``/``val``/``value`` для передаваемых значений - ``x``/``y``/``z`` для общих математических величин - ``s``/``str``/``string`` для строк - ``c`` для односимвольных строк - ``f``/``func``/``cb`` для функций - ``status, <rv>..`` или ``ok, <rv>..`` для получения из pcall/xpcall - ``buf, sz`` -- это пара (буфер, размер) - ``<name>_p`` для указателей - ``t0``.. для временных отметок - ``err`` для ошибок function bad_global_example()
end -- глобальная, очень-очень плохо

function good_local_example()
end
_G.modulename_good_local_example = good_local_example -- локальная, хорошо
_G.modulename = {}
_G.modulename.good_local_example = good_local_example -- локальная, лучше function name (arg1,arg2,...)
end -- плохо

function name(arg1, arg2, ...)
end -- хорошо function say_greeting(period, name)
     local a = "good  " .. period .. ", " .. name
end
-- плохо

function say_greeting(period, name)
    local a = string.format("good %s, %s", period, name)
end
-- хорошо

local say_greeting_fmt = "good %s, %s"
function say_greeting(period, name)
    local a = say_greeting_fmt:format(period, name)
end
-- лучше всего function(input)
    input = input or 'default_value'
end -- хорошо

function(input)
    if input == nil then
        input = 'default_value'
    end
end -- нормально, но избыточно глобальные переменные пишутся ЗАГЛАВНЫМИ_БУКВАМИ. Если это системная переменная, для определения используется символ подчеркивания (``_G``/``_VERSION``/..) http://books.google.com/books?id=QnghAQAAIAAJ http://dev.minetest.net/Lua_code_style_guidelines http://mindprod.com/jgloss/unmain.html http://sputnik.freewisdom.org/en/Coding_Standard http://www.oreilly.com/catalog/perlbp/ https://github.com/Olivine-Labs/lua-style-guide https://www.python.org/dev/peps/pep-0020/ if (a == true and b == false) or (a == false and b == true) then
    <...>
end -- хорошо

if a == true and b == false or a == false and b == true then
    <...>
end -- плохо

if a ^ b == true then
end -- хорошо, но не явно if (a == true and b == false) or (a == false and b == true) then
    do_something()
end
-- хорошо

if a == true then
    if b == false then
        do_something()
    end
if b == true then
    if a == false then
        do_something()
    end
end
-- плохо if a == true then
    return do_something()
end
do_other_thing() -- хорошо

if a == true then
    return do_something()
else
    do_other_thing()
end -- плохо if thing then
    -- ...что-то...
end
function derp()
    -- ...что-то...
end
local wat = 7
-- плохо

if thing then
    -- ...что-то...
end

function derp()
    -- ...что-то...
end

local wat = 7
-- хорошо local M = {}

function M.foo()
...
end

function M.bar()
...
end

return M local a = 123
a = a .. ''
-- плохо

local a = 123
a = tostring(a)
-- хорошо

local a = '123'
a = a + 5 -- 128
-- плохо

local a = '123'
a = tonumber(a) + 5 -- 128
-- хорошо local data, err = foo()
if not data
    return nil, err
end
return bar(data) local data, err = foo()
if not err
    return data
end
return nil, err local function foo()
...
end

local function bar()
...
end

return {
foo = foo,
bar = bar,
} local thing = {1,2,3}
thing = {1 , 2 , 3}
thing = {1 ,2 ,3}
-- плохо

local thing = {1, 2, 3}
-- хорошо local thing=1
thing = thing-1
thing = thing*1
thing = 'string'..'s'
-- плохо

local thing = 1
thing = thing - 1
thing = thing * 1
thing = 'string' .. 's'
-- хорошо именование модулей -- с помощью snake_case (избегайте подчеркивания и дефисов) - 'luasql', а не 'Lua-SQL' имена "классов": CamelCase имена переменных/"объектов" и "методов"/функций: snake_case не следует вставлять пробелы между именем функции и открывающей круглой скобкой, но аргумент необходимо разделять одним символом пробела или частные переменные/методы (в будущем параметры) объекта начинаются с символа подчеркивания ``<object>._<name>``. Избегайте ``local function private_methods(self) end`` ``or``/``and`` в ``if`` должны быть обрамлены круглыми скобками (). Пример: return {
    long_key  = 'vaaaaalue',
    key       = 'val',
    something = 'even better'
} return {1,2,3,4} -- плохо
return {
    key1 = val1,key2=val2
} -- плохо

return {
    1, 2, 3, 4
    key1 = val1, key2 = val2,
    key3 = vallll
} -- хорошо точки с запятой в конце строки (только для разделения нескольких операторов в одной строке) примыкающие конструкции старайтесь избегать создания ненужных функций (closures/..) не слишком часто можно добавлять пустые строки в коде функций, чтобы отделить друг от друга логические части добавляйте пробел после запятых в таблицах добавляйте пробел после маркера комментария используйте пробелы в определениях ассоциативного массива по сторонам от знаков равенства и запятых while true do -- встроенный комментарий
-- комментарий
do_something()
end
--[[
  многострочный
  комментарий
]]-- 