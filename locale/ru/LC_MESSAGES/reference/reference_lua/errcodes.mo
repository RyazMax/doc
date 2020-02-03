��    /      �                �     L        X  0   p  T   �  )   �  �     e   �  +   =  )   i  t   �               ,     >     P     `     m     ~     �     �     �  	   �  !   �  m   �  �   T	    	
       u   !  /   �  �  �     ~  2   �     �  U   �  ?     �   _  �   �  �   �  :   '  #   b  �   �  �   y  <   �     ;     J  �  N  �   �  �   �  (   �  A   �  n     T   {  �  �  �   s  L   <  8   �  �   �  +   �     �     �     �     �     �     	          +     7     F  	   V  H   `  �   �  �   �  �  �     h   �   �   r   l!  >  �!  #   %  z   B%     �%  �   �%  q   r&  �   �&    �'    �(  N   �)  5   K*  |  �*  �   �+  <   �,     -     -   #!/usr/bin/env tarantool

local fio = require('fio')
local errno = require('errno')
local f = fio.open('/tmp/xxxx.txt', {'O_RDONLY' })
if not f then
    error("Failed to open file: "..errno.strerror())
end
local data = f:read(4096)
f:close()
print(data) (In replication) A server instance cannot modify data unless it is a master. **List of error codes** :samp:`box.space.{space-name}:{function-name}()` :samp:`if pcall(box.space.{space-name}.{function-name}, box.space.{space-name}) ...` A duplicate key exists in a unique index. After a function call that might fail, like fio.open() above, it is common to see syntax like ``if not f then ...`` or ``if f == nil then ...``, which check for common failures. But if there had been a syntax error, for example fio.opex instead of fio.open, then there would have been a Lua error and f would not have been changed. If checking for such an obvious error had been a concern, the programmer would probably have used pcall(). All functions in Tarantool modules should work this way, unless the manual explicitly says otherwise. An error occurred during update of a field. An error occurred inside a Lua procedure. And filter messages that are automatically generated, with the :ref:`log <cfg_logging-log>` configuration parameter. Database error codes ER_FIBER_STACK ER_ILLEGAL_PARAMS ER_KEY_PART_COUNT ER_MEMORY_ISSUE ER_NONMASTER ER_NO_SUCH_INDEX ER_NO_SUCH_SPACE ER_PROC_LUA ER_TUPLE_FOUND ER_UPDATE_FIELD ER_WAL_IO Examine and raise with box.error. Failed to write to disk. May mean: failed to record a change in the write-ahead log. Some sort of disk error. For some Tarantool box functions, pcall also returns error details including a file-name and line-number within Tarantool's source code. This can be seen by unpacking. For example: Generally, for Tarantool built-in functions which are designed to return objects: the result will be an object, or nil, or `a Lua error <https://www.lua.org/pil/8.3.html>`_. For example consider the :ref:`fio_read.lua <cookbook-fio_read>` program in our cookbook: Handling errors Here are some procedures that can make Lua functions more robust when there are errors, particularly database errors. Illegal parameters. Malformed protocol message. In the current version of the binary protocol, error messages, which are normally more descriptive than error codes, are not present in server responses. The actual message may contain a file name, a detailed reason or operating system error code. All such messages, however, are logged in the error log. Below are general descriptions of some popular codes. A complete list of errors can be found in file `errcode.h`_ in the source tree. Invoke with pcall. Key part count is not the same as index part count Log. Out of memory: :ref:`memtx_memory <cfg_storage-memtx_memory>` limit has been reached. Put messages in a log using the :ref:`log module <log-module>`. See the tutorial :ref:`Sum a JSON field for all tuples <c_lua_tutorial-sum_a_json_field>` to see how pcall can fit in an application. Take advantage of Lua's mechanisms for `"Error handling and exceptions" <http://www.lua.org/pil/8.4.html>`_, particularly ``pcall``. That is, instead of simply invoking with The recursion limit was reached when creating a new fiber. This usually indicates that a stored procedure is recursively invoking itself too often. The specified index in the specified space does not exist. The specified space does not exist. To find the last error, the box.error module provides :ref:`box.error.last() <box_error-last>`. (There is also a way to find the text of the last operating-system error for certain functions -- :ref:`errno.strerror([code]) <errno-strerror>`.) To make a new error and pass it on, the box.error module provides :ref:`box.error(code, errtext [, errtext ...]) <box_error-error>`. ``x, y = pcall(function() box.schema.space.create('') end)`` ``y:unpack()`` say Project-Id-Version: Tarantool 1.10
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
 #!/usr/bin/env tarantool

local fio = require('fio')
local errno = require('errno')
local f = fio.open('/tmp/xxxx.txt', {'O_RDONLY' })
if not f then
    error("Failed to open file: "..errno.strerror())
end
local data = f:read(4096)
f:close()
print(data) (Репликация) Экземпляр сервера не может вносить изменения в данные, если он не является мастером. **Список кодов ошибок** :samp:`box.space.{имя-спейса}:{имя-функции}()` :samp:`if pcall(box.space.{имя-спейса}.{имя-функции}, box.space.{имя-спейса}) ...` В уникальном индексе есть повторяющийся ключ. После вызова функции, который может не сработать, как fio.open() выше, обычно можно увидеть такой синтаксис, как ``if not f then ...`` или ``if f == nil then ...``, который проверяет на типичные отказы. Но если есть ошибка синтаксиса, например, fio.opex вместо fio.open, то появится Lua-ошибка, и f не изменится. Если речь идет о проверке таких очевидных ошибок, программист вероятно будет использовать pcall(). Все функции в модулях Tarantool'а должны работать таким образом, если в руководстве явно не говорится об обратном. Возникла ошибка во время обновления поля. Возникла ошибке в Lua-процедуре. И отфильтровывайте автоматически созданные сообщения с помощью конфигурационного параметра :ref:`log <cfg_logging-log>`. Коды ошибок базы данных ER_FIBER_STACK ER_ILLEGAL_PARAMS ER_KEY_PART_COUNT ER_MEMORY_ISSUE ER_NONMASTER ER_NO_SUCH_INDEX ER_NO_SUCH_SPACE ER_PROC_LUA ER_TUPLE_FOUND ER_UPDATE_FIELD ER_WAL_IO Проверка и вызов ошибки с помощью box.error. Запись на диск не удалась. Может означать, что не удалось записать изменение в журнале упреждающей записи. Некоторая ошибка на диске. Для некоторых функций модуля box в Tarantool'е pcall также вернет описание ошибки, включая имя файла и номер строки в исходном коде Tarantool'а. Например: Как правило, встроенные функции Tarantool'а, которые предназначены для возврата объектов, вернут либо объект, либо нулевое значение nil, либо `Lua-ошибку <https://www.lua.org/pil/8.3.html>`_. Например, рассмотрим программу :ref:`fio_read.lua <cookbook-fio_read>` из рекомендаций по разработке: Обработка ошибок Ниже представлены несколько процедур для более надежного вызова Lua-функций в случае ошибок, в частности, ошибок базы данных. Недопустимые параметры. Некорректное протокольное сообщение. В текущей версии бинарного протокола в ответы сервера не включены сообщения об ошибках, которые как правило, содержат больше информации, чем коды ошибок. Само сообщение может содержать имя файла, подробное описание причины или код ошибки операционной системы. Однако все такие сообщения регистрируются в журнале ошибок. Ниже приведены общие описания некоторых распространенных кодов. Полный список ошибок можно найти в файле `errcode.h`_ в исходном дереве. Вызов с помощью pcall. Количество частей ключа не совпадает с количеством частей индекса Запись в журнал. Нехватка оперативной памяти: достижение предела памяти :ref:`memtx_memory <cfg_storage-memtx_memory>`. Записывайте сообщения в журнал с помощью :ref:`модуля log <log-module>`. Чтобы увидеть применение pcall в приложении, см. практическое задание :ref:`Подсчет суммы по JSON-полям во всех кортежах <c_lua_tutorial-sum_a_json_field>`. Используйте механизмы Lua для `"Обработки ошибок и исключений" <http://www.lua.org/pil/8.4.html>`_, в частности ``pcall``. То есть вместо простого вызова функции с помощью При создании нового файбера был достигнут предел рекурсии. Обычно это указывает на то, что хранимая процедура слишком часто рекурсивно вызывает себя. Указанного индекса нет в указанном спейсе. Указанный спейс отсутствует. Чтобы найти последнюю ошибку, в модуле box.error предусмотрена функция :ref:`box.error.last() <box_error-last>`. (Также можно найти текст последней ошибки операционной системы для определенной функции -- :ref:`errno.strerror([code]) <errno-strerror>`.) В модуле box.error предусмотрена функция :ref:`box.error(code, errtext [, errtext ...]) <box_error-error>`, чтобы создать ошибку и передать ее. ``x, y = pcall(function() box.schema.space.create('') end)`` ``y:unpack()`` выполните 