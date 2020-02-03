��    ?                      t     T   �  �   �     r     �  P   �  \   �  f   B  P  �  �   �  �   �  �   |	  1   
  ,  J
  �   w  �   �  |   �    d     t  �  �  -        K  /   b  a   �  {   �  �   p  �     }   �  �   `  �   X  >    �   G  8    d   P  Q   �  �     ]   �  U   �  ?   N  -   �  #   �  M   �  =   .  G   l  /   �  0   �       J   ,     w  �   �  ]     K   r  z   �  ]   9  {   �  �     O  �  �   !     �!     "  %   "     B"  �  �"  �   e$  X   %  C  o%  %   �&     �&  f   �&  �   S'  �   �'  �  q(  �   *  �   +  �   �+  M   �,  �  �,  �   �.  �  P/  �   �0  G  �1  9   3  U  W3  Z   �5  6   6  T   ?6  �   �6  �   e7  �   J8  #  A9  �   e;  Z  M<    �>     �?  r  �A    ,C  n   DE  �   �E  �   gF  �   )G  �   �G  |   jH  W   �H  d   ?I  �   �I  �   HJ  �   �J  S   nK  c   �K     &L  �   EL  -   �L    )M  �   FN  t   �N  �   HO  �   4P  �   �P  �   |Q  \  QR  d  �T  �   V  ?   �V  J   �V  �   2W   $ # attaching to a Tarantool instance
$ tarantoolctl enter <instance_name>
$ # -- OR --
$ tarantoolctl connect <URI> $ sudo yum install tarantool-stat
$ # -- OR --
$ sudo apt-get install tarantool-stat **Example:** Given 1000 RPS, 1 Кbyte of query size, and 10 seconds of maximal query processing time, the minimal readahead buffer size must be 10 Mbytes. **Possible reasons** **Solution** -- changing the readahead value
tarantool> box.cfg{readahead = 10 * 1024 * 1024} -- checking RPS per query type
tarantool> require('stat').stat()['stat.op.<query_type>.rps'] -- checking the RPS of calling stored procedures
tarantool> require('stat').stat()['stat.op.call.rps'] -- loading Tarantool's "clock" module with time-related routines
tarantool> local clock = require 'clock'
-- starting the timer
tarantool> local b = clock.proc()
-- launching garbage collection
tarantool> local c = collectgarbage('count')
-- stopping the timer after garbage collection is completed
tarantool> return c, clock.proc() - b -- requesting arena_used_ratio value
tarantool> require('stat').stat()['slab.arena_used_ratio']

-- requesting quota_used_ratio value
tarantool> require('stat').stat()['slab.quota_used_ratio'] -- requesting quota_used_ratio value
tarantool> require('stat').stat()['slab.quota_used_ratio']

-- requesting items_used_ratio value
tarantool> require('stat').stat()['slab.items_used_ratio'] -- restarting replication
tarantool> original_value = box.cfg.replication
tarantool> box.cfg{replication={}}
tarantool> box.cfg{replication=original_value} :ref:`Restart replication <replication-recover>`. :ref:`Upgrade Tarantool 1.6 to 1.9+ <admin-upgrades_instance>`, where this error is fixed: in case of duplicate connections, replication is stopped and the following message is added to the log: ``'Incorrect value for option ''replication_source'': duplicate connection with the same replica UUID'``. All reasons that we discuss here can be identified by messages in Tarantool's log file, all starting with the words ``'Too long...'``. Attach to the Tarantool instance with :ref:`tarantoolctl <tarantoolctl>` utility, analyze the query statistics with :ref:`box.stat() <box_introspection-box_stat>` and spot the CPU consumption leader. The following commands can help: Both fast and slow queries are processed within a single connection, so the readahead buffer is cluttered with slow queries. Call the Lua garbage collector with the `collectgarbage('count') function <https://www.lua.org/manual/5.1/manual.html#pdf-collectgarbage>`_ and measure its execution time with the Tarantool functions :ref:`clock.bench() <clock-bench>` or :ref:`clock.proc() <clock-proc>`. Check NTP server settings. Check disk performance (use `iostat <https://linux.die.net/man/1/iostat>`_, `iotop <https://linux.die.net/man/1/iotop>`_ or `strace <https://linux.die.net/man/1/strace>`_ utility to check ``iowait`` parameter) and try to put .xlog files and snapshot files on different physical disks (i.e. use different locations for :ref:`wal_dir <cfg_basic-wal_dir>` and :ref:`memtx_dir <cfg_basic-memtx_dir>`). Check the indicators of memory fragmentation: Clean up the database. Example of calculating memory usage statistics: For this guide, you need to install Tarantool `stat <https://github.com/tarantool/stat>`_ module: If the load is mostly generated by INSERT/UPDATE/DELETE requests, we recommend :ref:`sharding the database <shard-module>`. If the load is mostly generated by SELECT requests, we recommend adding a :ref:`slave server <replication-bootstrap>` and let it process part of the queries. If the returned ``clock.proc()`` value is greater than 0.001, this may be an indicator of inefficient memory usage (no active measures are required, but we recommend to optimize your Tarantool application code). If the value is greater than 0.01, your application definitely needs thorough code analysis aimed at optimizing memory usage. If you found no problems with the NTP server, just do nothing then. Lag calculation uses operating system clock from two different machines. If they get out of sync, the remote master clock can get consistently behind the local instance’s clock. In Tarantool's :ref:`instance file <admin-instance_config>`, increase the value of :ref:`box.cfg{memtx_memory} <cfg_storage-memtx_memory>` (if memory resources are available). In a master-master replica set of two Tarantool instances, one of the masters has tried to perform an action already performed by the other server, for example re-insert a tuple with the same unique key. This would cause an error message like ``'Duplicate key exists in unique index 'primary' in space <space_name>'``. In case of heavy memory fragmentation (``quota_used_ratio`` is getting close to 100%, ``items_used_ratio`` is about 50%), we recommend restarting Tarantool in the :ref:`hot standby <index-hot_standby>` mode. In versions of Tarantool before 1.10, the server needs to be restarted to change this parameter. The Tarantool server will be unavailable while restarting from .xlog files, unless you restart it using :ref:`hot standby <index-hot_standby>` mode. In the latter case, nearly 100% server availability is guaranteed. Increase the readahead buffer size (:ref:`box.cfg{readahead} <cfg_networking-readahead>` parameter). Inefficient memory usage (RAM is cluttered with a huge amount of unused objects). Lack of RAM (parameters ``arena_used_ratio`` and ``quota_used_ratio`` in :ref:`box.slab.info() <box_slab_info>` report are getting close to 100%). On the business logic level, split fast and slow queries processing by different connections. Operating system clock on the hosts is not synchronized, or the NTP server is faulty. Problem: INSERT/UPDATE-requests result in ER_MEMORY_ISSUE error Problem: Master-master replication is stopped Problem: Query processing times out Problem: Replication "idle" keeps growing, but no related log messages appear Problem: Replication "lag" and "idle" contain negative values Problem: Replication statistics differ on replicas within a replica set Problem: Tarantool generates too heavy CPU load Problem: Tarantool works much slower than before Replication is broken. Restart replication with the following commands (at each master instance): Slow disks. Some server was assigned different IP addresses, or some server was specified twice in ``box.cfg{}``, so duplicate connections were established. The :ref:`transaction processor thread <atomic-threads_fibers_yields>` consumes over 60% CPU. The critical RPS value for SELECT/INSERT/UPDATE/DELETE requests is 100 000. The critical RPS value is 75 000, boiling down to 10 000 - 20 000 for a rich Lua application (a Lua module of 200+ lines). This is about :ref:`box.info.replication(.upstream).status <box_info_replication>` = stopped. This is about ``box.info.replication.(upstream.)idle`` value in :ref:`box.info.replication <box_info_replication>` section. This is about ``box.info.replication.(upstream.)lag`` and ``box.info.replication.(upstream.)idle`` values in :ref:`box.info.replication <box_info_replication>` section. This is about a replica set that consists of one master and several replicas. In a replica set of this type, values in :ref:`box.info.replication <box_info_replication>` section, like ``box.info.replication.lsn``, come from the master and must be the same on all replicas within the replica set. The problem is that they get different. This parameter can be changed on the fly, so you don't need to restart Tarantool. Attach to the Tarantool instance with :ref:`tarantoolctl <tarantoolctl>` utility and call ``box.cfg{}`` with a new ``readahead`` value: To check these parameters, say: Troubleshooting guide Try either of the following measures: We also recommend using text primary keys or setting up :ref:`master-slave replication <replication-master_replica_bootstrap>`. Project-Id-Version: Tarantool 1.10
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
 $ # подключаемся к админ-консоли нужного экземпляра
$ tarantoolctl enter <instance_name>
$ # -- ИЛИ --
$ tarantoolctl connect <URI> $ sudo yum install tarantool-stat
$ # -- ИЛИ --
$ sudo apt-get install tarantool-stat **Пример расчета:** при 1000 RPS, размере одного запроса в 1 Кбайт и максимальном времени обработки одного запроса в 10 секунд минимальный размер readahead-буфера должен равняться 10 Мбайт. **Возможные причины** **Решение** -- задаем новое значение readahead
tarantool> box.cfg{readahead = 10 * 1024 * 1024} -- запрашиваем RPS для запросов указанного типа
tarantool> require('stat').stat()['stat.op.<query_type>.rps'] -- запрашиваем RPS для вызовов хранимых процедур
tarantool> require('stat').stat()['stat.op.call.rps'] -- загрузка модуля clock для работы со временем
tarantool> local clock = require 'clock'
-- запускаем таймер
tarantool> local b = clock.proc()
-- запускаем сборку мусора
tarantool> local c = collectgarbage('count')
-- останавливаем таймер по завершении сборки мусора
tarantool> return c, clock.proc() - b -- запрашиваем значение arena_used_ratio
tarantool> require('stat').stat()['slab.arena_used_ratio']

-- запрашиваем значение quota_used_ratio
tarantool> require('stat').stat()['slab.quota_used_ratio'] -- запрашиваем значение quota_used_ratio
tarantool> require('stat').stat()['slab.quota_used_ratio']

-- запрашиваем значение items_used_ratio
tarantool> require('stat').stat()['slab.items_used_ratio'] -- перезапускаем репликацию
tarantool> original_value = box.cfg.replication
tarantool> box.cfg{replication={}}
tarantool> box.cfg{replication=original_value} :ref:`Перезапустить репликацию <replication-recover>`. :ref:`Обновить Tarantool 1.6 до 1.9+ <admin-upgrades_instance>`, где эта ошибка была исправлена: в описанной ситуации репликация будет остановлена, а в журнал будет записана следующая ошибка: ``'Incorrect value for option ''replication_source'': duplicate connection with the same replica UUID'``. Все описанные ниже ситуации можно распознать по записям в журнале Tarantool, начинающимся со слов ``'Too long...'``. Подключиться к Tarantool с помощью утилиты :ref:`tarantoolctl <tarantoolctl>`, внимательно изучить статистику запросов с помощью :ref:`box.stat() <box_introspection-box_stat>` и выявить источник потребления. Для этой цели могут оказаться полезными следующие команды: Быстрые и медленные запросы обрабатываются в одном подключении, что приводит к забиванию readahead-буфера медленными запросами. Запустить сборщик мусора в Lua с помощью `функции collectgarbage(count) <https://www.lua.org/manual/5.1/manual.html#pdf-collectgarbage>`_ и измерить время ее выполнения с помощью :ref:`clock.bench() <clock-bench>`  или :ref:`clock.proc() <clock-proc>`. Проверить настройки NTP-сервера. Проверить занятость дисков (с помощью утилиты `iostat <https://linux.die.net/man/1/iostat>`_, `iotop <https://linux.die.net/man/1/iotop>`_ или `strace <https://linux.die.net/man/1/strace>`_ посмотреть на параметр ``iowait``)  и попробовать разнести .xlog-файлы и снимки состояния базы данных по разным дискам (т.е. указать разные значения для параметров  :ref:`wal_dir  <cfg_basic-wal_dir>` и :ref:`memtx_dir <cfg_basic-memtx_dir>`). Проверьте, нет ли проблем с фрагментацией памяти: Провести очистку базы данных. Пример кода для подсчета потребляемой памяти: В данном руководстве используется сторонний модуль `stat <https://github.com/tarantool/stat>`_. Для его установки выполните команду: Если же нагрузка по большей части приходится на INSERT/UPDATE/DELETE-запросы, рекомендуется провести :ref:`шардинг базы данных <shard-module>`. Если основная нагрузка генерируется SELECT-запросами, следует добавить :ref:`slave-сервер <replication-bootstrap>` и часть запросов обрабатывать  на нем. Если возвращаемое ``clock.proc()`` значение больше 0.001, это может являться признаком неэффективного использования памяти (активного вмешательства не требуется, но рекомендуется оптимизация кода). Если значение превышает 0.01, необходимо провести подробный анализ кода и оптимизировать потребление памяти. Если значение больше 0,01, код приложения однозначно необходимо проанализировать на предмет оптимизации использования памяти. Если проблем с NTP-сервером не обнаружено, то не следует ничего предпринимать, потому что при вычислении лага репликации используются показания системных часов на двух разных машинах, и в случае рассинхронизации может случиться так, что часы удаленного мастер-сервера всегда будут отставать от часов локального экземпляра Tarantool. Зайти в :ref:`конфигурационный файл <admin-instance_config>` Tarantool и увеличить значение параметра :ref:`box.cfg{memtx_memory} <cfg_storage-memtx_memory>` (при наличии свободных ресурсов). В репликационном кластере, состоящем из двух мастер-серверов, один из серверов попытался выполнить действие, уже выполненное другим сервером, -- например, повторно вставить кортеж с таким же уникальным ключом (распознается по ошибке вида ``'Duplicate key exists in unique index 'primary' in space <space_name>'``). При высокой степени фрагментации памяти (значение параметра ``quota_used_ratio`` приближается к 100%, ``items_used_ratio`` около 50%)  рекомендуется перезапустить Tarantool в режиме горячего резервирования :ref:`hot standby <index-hot_standby>`. В версиях Tarantool'а до 1.10 для изменения данного параметра требуется перезагрузить сервер. При обычной перезагрузке сервер будет недоступен на время старта Tarantool из .xlog-файлов. При перезагрузке в режиме горячего резервирования :ref:`hot standby <index-hot_standby>` гарантирована практически 100%-ная доступность. Увеличить размер readahead-буфера (:ref:`box.cfg{readahead} <cfg_networking-readahead>`). Неэффективное использование памяти (память занята большим количеством неиспользуемых объектов). Нехватка памяти (значения параметров ``arena_used_ratio`` и ``quota_used_ratio`` из  :ref:`box.slab.info() <box_slab_info>` приближаются к 100%). Обрабатывать быстрые и медленные запросы в отдельных подключениях (решается на уровне бизнес-логики). Не синхронизированы часы на машинах или  неправильно работает NTP-сервер. Проблема: при выполнении INSERT/UPDATE-запросов возникает ошибка ER_MEMORY_ISSUE Проблема: репликация мастер-мастер остановлена Проблема: обработка запросов прекращается по таймауту Проблема: значение параметра idle растет, но журнал не содержит связанных  с этим сообщений Проблема: параметры репликации lag и idle принимают отрицательные значения Проблема: общие параметры репликации не совпадают на репликах в рамках одного кластера Проблема: Tarantool создает большую нагрузку на CPU Проблема: Tarantool работает заметно медленнее, чем раньше Сбой репликации. Возобновить репликацию с помощью следующих команд (должны быть выполнены на всех мастер-серверах): Медленная работа дисков. Одному серверу были назначены различные IP-адреса или один и тот же сервер был указан в ``box.cfg{}`` дважды, что привело к установлению дублирующего подключения. :ref:`Поток обработки транзакций <atomic-threads_fibers_yields>` нагружает ЦП более чем на 60%. Критическое значение RPS для запросов типа SELECT/INSERT/UPDATE/DELETE -- 100 000. Критическое значение RPS -- 75 000, в случае большого Lua-приложения (модульного приложения, содержащего более 200 строк кода) -- 10 000 - 20 000. Речь идет о том, что параметр :ref:`box.info.replication(.upstream).status <box_info_replication>` имеет значение stopped. Речь идет о параметре ``box.info.replication.(upstream.)idle`` из сводной  таблицы :ref:`box.info.replication <box_info_replication>`. Речь идет о параметрах ``box.info.replication.(upstream.)lag`` и ``box.info.replication.(upstream.)idle`` из сводной таблицы :ref:`box.info.replication <box_info_replication>`. Речь идет о кластере, состоящем из одного мастера и нескольких реплик. В таком случае значения общих параметров из сводной таблицы :ref:`box.info.replication <box_info_replication>`, например ``box.info.replication.lsn``, должны приходить с мастера и должны быть одинаковыми на всех репликах. Если такие параметры не совпадают, это свидетельствует о наличии проблем. Перезапускать Tarantool при этом не требуется. Для обновления конфигурации необходимо подключиться к Tarantool с помощью утилиты :ref:`tarantoolctl <tarantoolctl>` и передать в ``box.cfg{}`` новое значение параметра ``readahead``: Чтобы проверить значения данных параметров, выполните соответствующие команды: Руководство по разрешению проблем У вас есть несколько вариантов действий: Также рекомендуется перейти на текстовые первичные ключи или настроить :ref:`репликацию мастер-реплика <replication-master_replica_bootstrap>`. 