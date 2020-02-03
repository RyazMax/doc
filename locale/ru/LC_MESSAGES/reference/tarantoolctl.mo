��    F      L              |  �   }  �   	      �  )   �     �  )   �  '   "  &   J  Y   q  -   �  ,   �  :   &  w  a  *   �     	  E    	  4   f	     �	  U   �	  �   
  "   �
  Y   �
  �   	  +   �     �     �  $        8  I   K     �  C   �  L   �  Z   =  F   �  8   �  X     =   q     �  �   �  9   t  n   �  @     .   ^  6   �  {   �     @     \     y     �     �  �   �     V  #   t     �  =   �  "   �  "         8  K   Y     �     �     �    �  e     P     o   �     @  �   ]     �  �  �    �    �  A   �  X   �     R  P   l  H   �  [     �   b  t     O   �  u   �  �  Q  G   I   K   �   �   �   b   a!     �!  �   �!  �  �"  6   `$  �   �$  *  F%  Y   q&  1   �&  5   �&  G   3'  (   {'  �   �'     ((  m   F(  �   �(  �   @)  }   �)  i   m*  �   �*  j   p+     �+  �   �+  [   �,  �   A-  l   �-  E   6.  6   |.  {   �.     //     K/     h/     �/     �/  �   �/     E0  #   c0     �0  D   �0  "   �0  "   1      .1  R   O1     �1     �1     �1  �  �1  �   �3  �   x4  �   
5  A   �5  �   6     �6   Additionally, this command sets the TARANTOOLCTL environment variable to 'true', to mark that the instance was started by ``tarantoolctl``. Additionally, this command sets the TARANTOOL_RESTARTED environment variable to 'true', to mark that the instance was restarted by ``tarantoolctl``. As an argument, you can specify: Check an instance file for syntax errors. Command format Commands for managing Tarantool instances Commands for managing Tarantool modules Commands for managing checkpoint files Connect to a Tarantool instance on an admin-console port. Supports both TCP/Unix sockets. Create a rock by packing sources or binaries. Enter an instance's interactive Lua console. Evaluate a local Lua file on a running Tarantool instance. For example, this can be used to manage instances which receive configuration from an external server. For such instances, ``tarantoolctl start`` goes to background when ``box.cfg{}`` is called, so it will wait until options for ``box.cfg`` are received. However this is not the case for daemon management systems like ``systemd``, as they handle backgrounding on their side. Install a module in the current directory. List all installed modules. Play the contents of .snap/.xlog files to another Tarantool instance. Print into stdout the contents of .snap/.xlog files. Remove a module. Reports typical problems to stderr (e.g. pid file exists and control socket doesn't). Rotate logs of a started Tarantool instance. Works only if logging-into-file is enabled in the instance file. Pipe/syslog make no effect. Search the repository for modules. See also ``tarantoolctl`` usage examples in :ref:`Server administration <admin>` section. Show an instance's status (started/stopped). If pid file exists and an alive control socket exists, the return code is ``0``. Otherwise, the return code is not ``0``. Show information about an installed module. Start a Tarantool instance. Stop a Tarantool instance. Stop and start a Tarantool instance. Supported options: Unpack the contents of a rock into a new directory under the current one. Utility `tarantoolctl` ``--from=from_lsn`` to show operations starting from the given lsn. ``--only-server=server_name`` check this server only, ignore the usual list. ``--replica=replica_id`` to filter the output by replica id. May be passed more than once. ``--server=server_name`` check this server first, then the usual list. ``--show-system`` to show the contents of system spaces. ``--space=space_no`` to filter the output by space number. May be passed more than once. ``--to=to_lsn`` to show operations ending with the given lsn. ``.rockspec`` files, or ``COMMAND`` is one of the following: ``start``, ``stop``, ``status``, ``restart``, ``logrotate``, ``check``, ``enter``, ``eval``, ``connect``, ``cat``, ``play``, ``rocks``. ``FILE`` is the path to some file (.lua, .xlog or .snap). ``NAME`` is the name of an :ref:`instance file <admin-instance_file>` or a :ref:`module <app_server-modules>`. ``OPTIONS`` are options taken by some ``tarantoolctl`` commands. ``URI`` is the URI of some Tarantool instance. ``tarantoolctl COMMAND NAME [URI] [FILE] [OPTIONS..]`` ``tarantoolctl cat FILE.. [--space=space_no ..] [--show-system] [--from=from_lsn] [--to=to_lsn] [--replica=replica_id ..]`` ``tarantoolctl check NAME`` ``tarantoolctl connect URI`` ``tarantoolctl enter NAME`` ``tarantoolctl eval NAME FILE`` ``tarantoolctl logrotate NAME`` ``tarantoolctl play URI FILE.. [--space=space_no ..] [--show-system] [--from=from_lsn] [--to=to_lsn] [--replica=replica_id ..]`` ``tarantoolctl restart NAME`` ``tarantoolctl rocks install NAME`` ``tarantoolctl rocks list`` ``tarantoolctl rocks pack {<rockspec> | <name> [<version>]}`` ``tarantoolctl rocks remove NAME`` ``tarantoolctl rocks search NAME`` ``tarantoolctl rocks show NAME`` ``tarantoolctl rocks unpack {<rock_file> | <rockspec> | <name> [version]}`` ``tarantoolctl start NAME`` ``tarantoolctl status NAME`` ``tarantoolctl stop NAME`` ``tarantoolctl`` is a utility for administering Tarantool :ref:`instances <tarantoolctl-instance_management>`, :ref:`checkpoint files <tarantoolctl-checkpoint_management>` and :ref:`modules <tarantoolctl-module_management>`. It is shipped and installed as part of Tarantool distribution. ``tarantoolctl`` works for instances without ``box.cfg{}`` called or with delayed ``box.cfg{}`` call. a ``.rockspec`` file to create a source rock containing the module's sources, or names of rocks or ``.rockspec`` files in remote repositories (and the rock version if there are more than one). source or binary rock files, the name of an installed module (and its version if there are more than one) to create a binary rock containing the compiled module. where: Project-Id-Version: Tarantool 1.10
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
 Кроме того, данная команда задает значение переменной окружения TARANTOOLCTL = 'true' (правда), чтобы отметить, что экземпляр был запущен с помощью ``tarantoolctl``. Кроме того, данная команда задает значение переменной окружения TARANTOOL_RESTARTED = 'true' (правда), чтобы отметить, что экземпляр был перезапущен с помощью ``tarantoolctl``. В качестве аргумента можно указать: Проверка файла экземпляра на ошибки синтаксиса. Формат команд Команды для управления экземплярами Tarantool'а Команды для управления модулями Tarantool'а Команды для управления файлами контрольной точки Подключение к экземпляру Tarantool'а по порту административной консоли. Поддерживаются TCP и Unix сокеты. Создание модуля путем компоновки исходных или бинарных файлов. Вход в интерактивную Lua-консоль экземпляра. Выполнение локального Lua-файла на работающем экземпляре Tarantool'а. Например, это можно использовать для управления экземплярами, которые получают конфигурацию из внешнего сервера. Для таких экземпляров ``tarantoolctl start`` goes to background when ``box.cfg{}`` is called, so it will wait until options for ``box.cfg`` are received. However this is not the case for daemon management systems like ``systemd``, as they handle backgrounding on their side. Установка модуля в текущей директории. Вывод списка всех установленных модулей. Передача содержимого .snap-файла или .xlog-файла на другой экземпляр Tarantool'а. Стандартный вывод содержимого .snap-файла или .xlog-файла. Удаление модуля. Сообщает о типичных проблемах стандартного вывода ошибок (например, PID-файл есть, а управляющий сокет отсутствует). Ротация файлов журнала работающего Tarantool-экземпляра. Работает только в том случае, если в файле экземпляра задан параметр записи журнала в файл. Отправка записей в конвейер или системный журнал syslog не имеет значения в данном случае. Поиск модулей по репозиторию. См. также примеры использования ``tarantoolctl`` в разделе :ref:`Администрирование серверной части <admin>`. Отображение статуса экземпляра (работает/остановлен). Если есть PID-файл и активный управляющий сокет, возвращается код ``0``. В остальных случаях возвращается не ``0``. Отображение информации об установленном модуле. Запуск экземпляра Tarantool’а. Остановка экземпляра Tarantool'а. Остановка и запуск экземпляра Tarantool’а. Поддерживаемые опции: Распаковка содержимого модуля в новую директорию в текущей директории. Утилита `tarantoolctl` ``--from=from_lsn`` для отображения операций, начиная с заданного LSN. ``--only-server=имя_сервера`` проверить только данный сервер, остальные пропустить. ``--replica=replica_id`` для фильтрации вывода по идентификатору реплики. Можно передавать несколько раз. ``--server=имя_севрера`` сначала проверить данный сервер, затем по списку. ``--show-system`` для отображения содержимого системных спейсов. ``--space=space_no`` для фильтрации вывода по номеру спейса. Можно передавать несколько раз. ``--to=to_lsn`` для отображения операций, заканчивая заданным LSN. файлы ``.rockspec`` или ``COMMAND`` -- это одна из следующих команд, описанных ниже: ``start``, ``stop``, ``status``, ``restart``, ``logrotate``, ``check``, ``enter``, ``eval``, ``connect``, ``cat``, ``play``, ``rocks``. ``FILE`` -- это путь к какому-либо файлу (.lua, .xlog или .snap). ``NAME`` -- это имя :ref:`файла экземпляра <admin-instance_file>` или :ref:`модуля <app_server-modules>`. ``OPTIONS`` -- это параметры, которые принимают команды ``tarantoolctl``. ``URI`` -- это URI некого экземпляра Tarantool'а. ``tarantoolctl COMMAND NAME [URI] [FILE] [OPTIONS..]`` ``tarantoolctl cat FILE.. [--space=space_no ..] [--show-system] [--from=from_lsn] [--to=to_lsn] [--replica=replica_id ..]`` ``tarantoolctl check NAME`` ``tarantoolctl connect URI`` ``tarantoolctl enter NAME`` ``tarantoolctl eval NAME FILE`` ``tarantoolctl logrotate NAME`` ``tarantoolctl play URI FILE.. [--space=space_no ..] [--show-system] [--from=from_lsn] [--to=to_lsn] [--replica=replica_id ..]`` ``tarantoolctl restart NAME`` ``tarantoolctl rocks install NAME`` ``tarantoolctl rocks list`` ``tarantoolctl rocks pack {<rockspec> | <имя> [<версия>]}`` ``tarantoolctl rocks remove NAME`` ``tarantoolctl rocks search NAME`` ``tarantoolctl rocks show NAME`` ``tarantoolctl rocks unpack {<rock_file> | <rockspec> | <имя> [версия]}`` ``tarantoolctl start NAME`` ``tarantoolctl status NAME`` ``tarantoolctl stop NAME`` ``tarantoolctl`` представляет собой утилиту для администрирования :ref:`экземпляров <tarantoolctl-instance_management>`, :ref:`файлов контрольной точки <tarantoolctl-checkpoint_management>` и :ref:`модулей <tarantoolctl-module_management>` в Tarantool'е. Утилита поставляется и устанавливается как часть дистрибутива Tarantool'а. ``tarantoolctl`` работает для экземпляров, где не вызвана функция ``box.cfg{}`` или вызов ``box.cfg{}`` отложен. файл в формате ``.rockspec`` для создания модуля, который содержит исходные файлы или имя модулей или файлов в формате ``.rockspec`` в удаленных репозиториях (с версией модуля, если их больше одной). исходные или бинарные файлы модуля, имя установленного модуля (с версией, если их больше одной) для создания модуля, который содержит скомпилированные файлы. где: 