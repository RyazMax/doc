��          �               �  �  �    F  �   V    F  �   T       	  %  �   /  7   �  �   	  R  �	  <     6   X     �     �     �  �   �  /   �     �  ,   �     #     7  |   V  #   �  �  �  �  �  �  3  !  �  	  �  �  �     n  g  �  U  �  S   I  I  �  ^  �  r   F  ^   �  -      2   F   4   y   |  �   T   +"  6   �"  x   �"  &   0#  4   W#  |   �#  #   	$   -- #1
tarantool> box.space.tester:select{1}
-- #2
tarantool> box.space.tester:select({1})
-- #3
tarantool> box.space.tester:select(1)
-- #4
tarantool> box.space.tester.select(box.space.tester,1)
-- #5
tarantool> box.space.tester:select({1},{iterator='EQ'})
-- #6
tarantool> variable = 1
tarantool> box.space.tester:select{variable}
-- #7
tarantool> variable = {1}
tarantool> box.space.tester:select(variable) -- #1 module . submodule . name
tarantool> box.space.tester:select{1}
-- #2 replace name with a literal in square brackets
tarantool> box.space['tester']:select{1}
-- #3 use a variable for the entire object reference
tarantool> s = box.space.tester
tarantool> s:select{1} Also, descriptions in this manual use the syntax "``space_object:``" for references to objects which are spaces, and "``index_object:``" for references to objects which are indexes (for example :samp:`box.space.{tester}.index.{primary}:`). Although there are special cases where braces can be omitted, they are preferable because they signal "Lua table". Examples and descriptions in this manual have the ``{1}`` form. However, this too is a matter of user preference and all the variations exist in the wild. Database objects have loose **rules for names**: the maximum length is 65000 bytes (not characters), and almost any legal Unicode character is allowed, including spaces, ideograms and punctuation. Disallowed: Every one of the examples does the same thing: select a tuple set from a space named 'tester' where the primary-key field value equals 1. For these examples, we assume that the numeric id of 'tester' is 512, which happens to be the case in our sandbox example only. Examples in this manual usually have the ":samp:`box.space.{tester}:`" form (#1). However, this is a matter of user preference and all the variations exist in the wild. First, there are three **object reference variations**: In those cases, to prevent confusion with Lua operators and separators, object references should have the literal-in-square-brackets form (#2), or the variable form (#3). For example: Lua allows to omit parentheses ``()`` when invoking a function if its only argument is a Lua table, and we use it sometimes in our examples. This is why ``select{1}`` is equivalent to ``select({1})``. Literal values such as ``1`` (a scalar value) or ``{1}`` (a Lua table value) may be replaced by variable names, as in examples #6 and #7. Names are "case sensitive", so 'A' and 'a' are not the same. Not recommended: characters which cannot be displayed. Object reference variations Parameter variations Rules for object names The Lua syntax for :ref:`data-manipulation functions <index-box_data-operations>` can vary. Here are examples of the variations with ``select()`` requests. The same rules exist for the other data-manipulation functions. Then, there are seven **parameter variations**: Tips on Lua syntax characters which are unassigned code points, control characters, line and paragraph separators, tarantool> box.space['1*A']:select{1}
tarantool> s = box.space['1*A !@$%^&*()_+12345678901234567890']
tarantool> s:select{1} the replacement character (U+FFFD). Project-Id-Version: Tarantool 1.10
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
 -- #1
tarantool> box.space.tester:select{1}
-- #2
tarantool> box.space.tester:select({1})
-- #3
tarantool> box.space.tester:select(1)
-- #4
tarantool> box.space.tester.select(box.space.tester,1)
-- #5
tarantool> box.space.tester:select({1},{iterator='EQ'})
-- #6
tarantool> variable = 1
tarantool> box.space.tester:select{variable}
-- #7
tarantool> variable = {1}
tarantool> box.space.tester:select(variable) -- #1 модуль.подмодуль.имя
tarantool> box.space.tester:select{1}
-- #2 заменить имя буквенной константой в квадратных скобках
tarantool> box.space['tester']:select{1}
-- #3 использовать переменную для всей ссылки на объект
tarantool> s = box.space.tester
tarantool> s:select{1} Также описания в руководстве используют синтаксис типа  "``space_object:``" для ссылки на спейсы и "``index_object:``" для ссылки на индексы (например, :samp:`box.space.{tester}.index.{primary}:`). Хотя есть особые случаи, когда фигурные скобки можно опустить, рекомендуется использовать их, потому что они означают Lua-таблицу. В примерах и описаниях данного руководства применяется форма ``{1}``. Однако это тоже вопрос предпочтений пользователя, и на практике применимы все варианты. **Правила именования** объектов базы данных не слишком ограничены: максимальная длина составляет 65000 байтов (не символов), допускается практически любой символ Юникода, включая пробелы, идеограммы и знаки пунктуации. Не разрешаются: В каждом из приведенных примеров выполняются следующие действия: производится выборка по набору кортежей из спейса с именем 'tester', где значение поля, которое соответствует ключу в первичном индексе, равно 1. Также во всех примерах мы принимаем, что числовой идентификатор спейса 'tester' равен 512, но это верно только для нашей тестовой базы. Для примеров в документации, как правило, используется вариант синтаксиса №1, например ":samp:`box.space.{tester}:`". Но вы можете с тем же успехом пользоваться любым из трех описанных выше вариантов. Во-первых, есть три *способа ссылки на объект*: В таких случаях во избежание путаницы с операторами и разделителями в Lua ссылки на объекты должны иметь форму типа литерал в квадратных скобках (2) или форму переменной (3). Например: В Lua допускается пропуск круглых скобок ``()`` при вызове функции, если единственным аргументом является Lua-таблица, и иногда мы этим пользуемся в примерах. Вот почему ``select{1}`` аналогично ``select({1})``. Литеральные значения, такие как ``1`` (скалярное значение) или ``{1}`` (значение Lua-таблицы), можно заменить именами переменных, ка в примерах 6 и 7. Имена зависимы от регистра, поэтому 'A' и 'a' -- это не одно и то же. Не рекомендуются: символы, которые не отображаются. Способы ссылки на объект Способы задания параметров Правила именования объектов В :ref:`функциях управления данными <index-box_data-operations>` Lua-синтаксис может различаться. Далее приводятся варианты таких различий на примере запросов ``select()``. Аналогичные правила существуют и для остальных функций. Затем есть семь *способов задания параметров*: Рекомендации по Lua-синтаксису символы, которые представляют собой неназначенные кодовые точки, управляющие символы, разделители строки и абзаца, tarantool> box.space['1*A']:select{1}
tarantool> s = box.space['1*A !@$%^&*()_+12345678901234567890']
tarantool> s:select{1} символ замены (U+FFFD). 