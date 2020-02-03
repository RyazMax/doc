��    D      <              \     ]     j     �  "   �      �      �          "     A     `       $   �     �      �  (   �     (  T   :     �      �     �  P   �     2  *   G     r     �      �  5   �  +   �  )   +     U     [     g     l  
   u  �   �  L   9	  ?   �	     �	     �	     �	     
     2
  #   K
  4   o
  9   �
  /   �
  -        <     X  2  u     �  "   �  #   �  $   �  8     :   Q  O   �  ,  �  9   	  O   C  +   �  _   �  .     )   N  1   x  T   �     �  �       �     �     �  "   �             A     b     }     �     �     �  $   �           9  W   Z     �  ~   �  8   Q  9   �  "   �  �   �  -   �  [   �  :   !  ;   \  =   �  w   �  d   N  I   �     �          "     )     E    X  t   ^  \   �  7   0  8   h  C   �  D   �  *   *  :   U  X   �  t   �  a   ^  F   �  >     ?   F  �  �     J"  C   _"  I   �"  $   �"  8   #  :   K#  O   �#  ,  �#  9   %  O   =%  +   �%  _   �%  .   &  )   H&  1   r&  T   �&     �&   **Example:** :ref:`os.clock() <os-clock>` :ref:`os.date() <os-date>` :ref:`os.difftime() <os-difftime>` :ref:`os.environ() <os-environ>` :ref:`os.execute() <os-execute>` :ref:`os.exit() <os-exit>` :ref:`os.getenv() <os-getenv>` :ref:`os.remove() <os-remove>` :ref:`os.rename() <os-rename>` :ref:`os.setenv() <os-setenv>` :ref:`os.setlocale() <os-setlocale>` :ref:`os.time() <os-time>` :ref:`os.tmpname() <os-tmpname>` Below is a list of all ``os`` functions. Change the locale Change the locale. If new-locale-string is not specified, return the current locale. Execute by passing to the shell Execute by passing to the shell. Exit the program Exit the program. If this is done on a server instance, then the instance stops. Get a formatted date Get a table with all environment variables Get an environment variable Get environment variable. Get the name of a temporary file Get the number of CPU seconds since the program start Get the number of seconds between two times Get the number of seconds since the epoch Index Module `os` Name Overview Parameters Parameters: (string) format-string = instructions; (string) time-since-epoch = number of seconds since 1970-01-01. If time-since-epoch is omitted, it is assumed to be the current time. Parameters: (string) name = name of file or directory which will be removed. Parameters: (string) variable-name = environment variable name. Remove a file or directory Remove file or directory. Rename a file or directory Rename a file or directory. Return a formatted date. Return a name for a temporary file. Return a table containing all environment variables. Return the number of CPU seconds since the program start. Return the number of seconds between two times. Return the number of seconds since the epoch. Set an environment variable Set an environment variable. The ``os`` module contains the functions :ref:`execute() <os-execute>`, :ref:`rename() <os-rename>`, :ref:`getenv() <os-getenv>`, :ref:`remove() <os-remove>`, :ref:`date() <os-date>`, :ref:`exit() <os-exit>`, :ref:`time() <os-time>`, :ref:`clock() <os-clock>`, :ref:`tmpname() <os-tmpname>`, :ref:`environ() <os-environ>`, :ref:`setenv() <os-setenv>`, :ref:`setlocale() <os-setlocale>`, :ref:`difftime() <os-difftime>`. Most of these functions are described in the Lua manual Chapter 22 `The Operating System Library <https://www.lua.org/pil/contents.html#22>`_. Use changed name of file or directory. name of existing file or directory, tarantool> os.clock()
---
- 0.05
... tarantool> os.date("%A %B %d")
---
- Sunday April 24
... tarantool> os.difftime(os.time() - 0)
---
- 1486594859
... tarantool> os.environ()['TERM']..os.environ()['SHELL']
---
- xterm/bin/bash
... tarantool> os.execute('ls -l /usr')
total 200
drwxr-xr-x   2 root root 65536 Apr 22 15:49 bin
drwxr-xr-x  59 root root 20480 Apr 18 07:58 include
drwxr-xr-x 210 root root 65536 Apr 18 07:59 lib
drwxr-xr-x  12 root root  4096 Apr 22 15:49 local
drwxr-xr-x   2 root root 12288 Jan 31 09:50 sbin
---
... tarantool> os.exit()
user@user-shell:~/tarantool_sandbox$ tarantool> os.getenv('PATH')
---
- /usr/local/sbin:/usr/local/bin:/usr/sbin
... tarantool> os.remove('file')
---
- true
... tarantool> os.rename('local','foreign')
---
- null
- 'local: No such file or directory'
- 2
... tarantool> os.setenv('VERSION','99')
---
-
... tarantool> os.time()
---
- 1461516945
... tarantool> os.tmpname()
---
- /tmp/lua_7SW1m2
... tarantool> require('string').sub(os.setlocale(),1,20)
---
- LC_CTYPE=en_US.UTF-8
... what to execute. Project-Id-Version: Tarantool 1.10
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
 **Пример:** :ref:`os.clock() <os-clock>` :ref:`os.date() <os-date>` :ref:`os.difftime() <os-difftime>` :ref:`os.environ() <os-environ>` :ref:`os.execute() <os-execute>` :ref:`os.exit() <os-exit>` :ref:`os.getenv() <os-getenv>` :ref:`os.remove() <os-remove>` :ref:`os.rename() <os-rename>` :ref:`os.setenv() <os-setenv>` :ref:`os.setlocale() <os-setlocale>` :ref:`os.time() <os-time>` :ref:`os.tmpname() <os-tmpname>` Ниже приведен перечень всех функций модуля ``os``. Изменение локали Изменение локали. Если не указать new-locale-string, вернется текущая локаль. Выполнение путем передачи в ОС Выполнение путем передачи в ОС. Выход из программы Выход из программы. Если выполняется на экземпляре сервера, останавливается работа экземпляра. Получение даты в формате Получение таблицы со всеми переменными окружения Получение переменной окружения Получение переменной окружения. Получение имени временного файла Получение числа времени ЦП в секундах с момента начала программы Получение числа секунд между двумя значениями времени Получение числа секунд с начала отсчета Указатель Модуль `os` Имя Общие сведения Параметры Parameters: (string) format-string = инструкции; (string) time-since-epoch = число секунд с 1970-01-01. Если не указать time-since-epoch, предполагается использование текущего времени. Parameters: (string) name = имя файла или директории, которые будут удалены. Параметры: (string) variable-name = имя переменной окружения. Удаление файла или директории Удаление файла или директории. Переименование файла или директории Переименование файла или директории. Возврат даты в формате. Возврат имени временного файла. Возврат таблицы со всеми переменными окружения. Возврат числа времени ЦП в секундах с момента начала программы. Возврат числа секунд между двумя значениями времени. Возврат числа секунд с начала отсчета. Определение переменной окружения Определение переменной окружения. Модуль ``os`` включает в себя следующие функции: :ref:`execute() <os-execute>`, :ref:`rename() <os-rename>`, :ref:`getenv() <os-getenv>`, :ref:`remove() <os-remove>`, :ref:`date() <os-date>`, :ref:`exit() <os-exit>`, :ref:`time() <os-time>`, :ref:`clock() <os-clock>`, :ref:`tmpname() <os-tmpname>`, :ref:`environ() <os-environ>`, :ref:`setenv() <os-setenv>`, :ref:`setlocale() <os-setlocale>`, :ref:`difftime() <os-difftime>`. Большинство этих функций описаны в Главе 22 руководства по языку Lua `Библиотека функций операционной системы <https://www.lua.org/pil/contents.html#22>`_. Назначение измененное имя файла или директории. имя существующего файла или директории, tarantool> os.clock()
---
- 0.05
... tarantool> os.date("%A %B %d")
---
- Sunday April 24
... tarantool> os.difftime(os.time() - 0)
---
- 1486594859
... tarantool> os.environ()['TERM']..os.environ()['SHELL']
---
- xterm/bin/bash
... tarantool> os.execute('ls -l /usr')
total 200
drwxr-xr-x   2 root root 65536 Apr 22 15:49 bin
drwxr-xr-x  59 root root 20480 Apr 18 07:58 include
drwxr-xr-x 210 root root 65536 Apr 18 07:59 lib
drwxr-xr-x  12 root root  4096 Apr 22 15:49 local
drwxr-xr-x   2 root root 12288 Jan 31 09:50 sbin
---
... tarantool> os.exit()
user@user-shell:~/tarantool_sandbox$ tarantool> os.getenv('PATH')
---
- /usr/local/sbin:/usr/local/bin:/usr/sbin
... tarantool> os.remove('file')
---
- true
... tarantool> os.rename('local','foreign')
---
- null
- 'local: No such file or directory'
- 2
... tarantool> os.setenv('VERSION','99')
---
-
... tarantool> os.time()
---
- 1461516945
... tarantool> os.tmpname()
---
- /tmp/lua_7SW1m2
... tarantool> require('string').sub(os.setlocale(),1,20)
---
- LC_CTYPE=en_US.UTF-8
... что выполнить. 