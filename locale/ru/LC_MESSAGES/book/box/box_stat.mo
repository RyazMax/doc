��    '      T              �  !  �  �   �  1  U    �  �   �  `   A  J   �  6   �  �  $  �   �	     �
  M   �
      u  -  �   �  �   6  �   �  �   �  <  i  -  �  �   �  e   {  O   �  �   1  �   #  �     �  �  %  ^  �   �      �   �  Y   ^    �  �   �   g  k!  5   �"  ^   	#  2  h#  �  �&    >(  
  Z*  �  e+  �  �-     �/  �   �0  |   f1  p   �1  �  T2  y  *5  *   �6  �   �6  �  �7     	<    
>  i  ?  �   �@  �  MA  �  �B  }  hE  k  �F  �   RH  z   �H  �  jI  ~  K  D  �L  �  �M    �P  �  �S  �  6U  K  �V  �   ?X  �  �X  �   �Z  |  �[  S   !^  o   u^  ~  �^   **Details about box.stat.vinyl().disk:** Since vinyl is an on-disk storage engine (unlike memtx which is an in-memory storage engine), it can handle large databases -- but if a database is larger than the amount of memory that is allocated for vinyl, then there will be more disk activity. **Details about box.stat.vinyl().memory:** Although the vinyl storage engine is not "in-memory", Tarantool does need to have memory for write buffers and for caches: **Details about box.stat.vinyl().regulator:** The vinyl regulator decides when to take or delay actions for disk IO, grouping activity in batches so that it is consistent and efficient. The regulator is invoked by the vinyl scheduler, once per second, and updates related variables whenever it is invoked. **Details about box.stat.vinyl().scheduler:** This primarily has counters related to tasks that the scheduler has arranged for dumping or compaction: (most of these items are reset to 0 when the server restarts or when :ref:`box.stat.reset() <box_introspection-box_stat_reset>` occurs): **Details about box.stat.vinyl().tx:** This is about requests that affect transactional activity ("tx" is used here as an abbreviation for "transaction"): A "dump" is explained in section :ref:`Storing data with vinyl <engines-algorithm_filling_lsm>`: A dump will also occur during a  :ref:`snapshot <box-snapshot>` operation. Here are details about the ``box.stat.vinyl()`` items. In the tables that ``box.stat()`` and ``box.stat.net()`` return: ``rps`` stands for "[average number of] requests per second [in the last 5 seconds]", ``total`` stands for "total [number processed since the server began]", ``current`` stands for "[number of] current [requests in progress, which can be limited by :ref:`box.cfg.net_msg_max <cfg_networking-net_msg_max>`]". "ERROR" is the count of requests that resulted in an error. Sooner or later the number of elements in an LSM tree exceeds the L0 size and that is when L0 gets written to a file on disk (called a 'run') and then cleared for storing new elements. This operation is called a 'dump'. Submodule `box.stat` The ``box.stat`` submodule provides access to request and network statistics. Therefore we can say that "L0 is becoming full" when the amount in ``memory.level0`` is close to the maximum, which is :ref:`regulator.dump_watermark <box_introspection-box_stat_vinyl_regulator>`. We can expect that "L0 = 0" immediately after a dump. ``box.stat.vinyl().memory.page_index`` and  ``box.stat.vinyl().memory.bloom_filter`` have the current amount being used for index-related structures. The size is a function of the number and size of keys, plus :ref:`page_size <cfg_storage-vinyl_page_size>`, plus :ref:`bloom_fpr <cfg_storage-vinyl_bloom_fpr>`. This is not a count of bloom filter "hits" (the number of reads that could be avoided because the bloom filter predicts their presence in a run file) -- that statistic can be found with :ref:`index_object:stat() <box_index-stat>`. Thus it can be predicted that a dump will occur if the size of L0 (which is :ref:`memory.level0 <box_introspection-box_stat_vinyl_memory>`) is approaching the maximum (which is :ref:`regulator.dump_watermark <box_introspection-box_stat_vinyl_regulator>`) and a dump is not already in progress. In fact Tarantool will try to arrange a dump before this hard limit is reached. Use ``box.stat()`` to show the average number of requests per second, and the total number of requests since startup, broken down by request type. Use ``box.stat.net()`` to see network activity: the number of bytes sent and received, the number of connections, and the number of requests (current, average, and total). Use ``box.stat.reset()`` to reset the statistics of ``box.stat()``, ``box.stat.net()``, ``box.stat.vinyl()`` and :ref:`box.space.index <box_space-space_index>`. Use ``box.stat.vinyl()`` to see vinyl-storage-engine activity, for example ``box.stat.vinyl().tx`` has the number of commits and rollbacks. See details at :ref:`the end of this section <box_introspection-box_stat_vinyl_details>`. ``box.stat.vinyl().disk.data_compacted`` Sum size of data stored at the last LSM tree level, in bytes, without taking disk compression into account. It can be thought of as the size of disk space that the user data would occupy if there were no compression, indexing, or space increase caused by the LSM tree design. ``box.stat.vinyl().disk.data`` and ``box.stat.vinyl().disk.index`` are the amount of data that has gone into files in a subdirectory of :ref:`vinyl_dir <cfg_basic-vinyl_dir>`, with names like ``{lsn}.run`` and ``{lsn}.index``. The size of the run will be related to the output of ``scheduler.dump_*``. ``box.stat.vinyl().memory.level0`` is the "level0" memory area, sometimes abbreviated "L0", which is the area that vinyl can use for in-memory storage of an LSM tree. ``box.stat.vinyl().memory.tuple_cache`` is the number of bytes that are being used for tuples (data). ``box.stat.vinyl().memory.tx`` is transactional memory. This will usually be 0. ``box.stat.vinyl().regulator.dump_bandwidth`` is the estimated average rate at which dumps are done. Initially this will appear as 10485760 (10 megabytes per second). Only significant dumps (larger than one megabyte) are used for estimating. ``box.stat.vinyl().regulator.dump_watermark`` is the point when dumping must occur. The value is slightly smaller than the amount of memory that is allocated for vinyl trees, which is the :ref:`vinyl_memory <cfg_storage-vinyl_memory>` parameter. ``box.stat.vinyl().regulator.rate_limit`` is the write rate limit, in bytes per second, imposed on transactions by the regulator based on the observed dump/compaction performance. ``box.stat.vinyl().regulator.write_rate`` is the actual average rate at which recent writes to disk are done. Averaging is done over a 5-second time window, so if there has been no activity for 5 seconds then ``regulator.write_rate = 0``. The ``write_rate`` may be slowed when a dump is in progress or when the user has set :ref:`snap_io_rate_limit <cfg_binary_logging_snapshots-snap_io_rate_limit>`. ``box.stat.vinyl().scheduler.compaction_*`` is the amount of data from recent changes that has been :ref:`compacted <box_index-compact>`. This is divided into ``scheduler.compaction_input`` (the amount that is being compacted), ``scheduler.compaction_queue`` (the amount that is waiting to be compacted), ``scheduler.compaction_time`` (total time spent by all worker threads performing compaction, in seconds), and ``scheduler.compaction_output`` (the amount that has been compacted, which is presumably smaller than ``scheduler.compaction_input``). ``box.stat.vinyl().scheduler.tasks_*`` is about dump/compaction tasks, in three categories, ``scheduler.tasks_inprogress`` (currently running), ``scheduler.tasks_completed`` (successfully completed) ``scheduler.tasks_failed`` (aborted due to errors). ``box.stat.vinyl().scheduler_dump_*`` has the amount of data from recent changes that has been dumped, including ``dump_time`` (total time spent by all worker threads performing dumps, in seconds), and ``dump_count`` (the count of completed dumps), ``dump_input`` and ``dump_output``. ``box.stat.vinyl().tx.commit`` is the count of commits (successful transaction ends). It includes implicit commits, for example any insert causes a commit unless it is within a begin-end block. ``box.stat.vinyl().tx.conflict`` counts conflicts that caused a transaction to roll back. ``box.stat.vinyl().tx.gap_locks`` is the number of gap locks that are outstanding during execution of a request. For a low-level description of Tarantool's implementation of gap locking, see `Gap locks in Vinyl transaction manager <https://github.com/tarantool/tarantool/issues/2671>`_. ``box.stat.vinyl().tx.read_views`` shows whether a transaction has entered a read-only state to avoid conflict temporarily. This will usually be 0. ``box.stat.vinyl().tx.rollback`` is the count of rollbacks (unsuccessful transaction ends). This is not merely a count of explicit :ref:`box.rollback <box-rollback>` requests -- it includes requests that ended in errors. For example, after an attempted insert request that causes a "Duplicate key exists in unique index" error, ``tx.rollback`` is incremented. ``box.stat.vinyl().tx.statements`` will usually be 0. ``box.stat.vinyl().tx.transactions`` is the number of transactions that are currently running. tarantool> box.stat() -- return 10 tables
---
- DELETE:
    total: 1873949
    rps: 123
  SELECT:
    total: 1237723
    rps: 4099
  INSERT:
    total: 0
    rps: 0
  EVAL:
    total: 0
    rps: 0
  CALL:
    total: 0
    rps: 0
  REPLACE:
    total: 1239123
    rps: 7849
  UPSERT:
    total: 0
    rps: 0
  AUTH:
    total: 0
    rps: 0
  ERROR:
    total: 0
    rps: 0
  UPDATE:
    total: 0
    rps: 0
...
tarantool> box.stat().DELETE -- total + requests per second from one table
---
- total: 0
  rps: 0
...
tarantool> box.stat.net() -- 4 tables
---
- SENT:
    total: 0
    rps: 0
  CONNECTIONS:
    current: 0
    rps: 0
    total: 0
  REQUESTS:
    current: 0
    rps: 0
    total: 0
  RECEIVED:
    total: 0
    rps: 0
...
tarantool> box.stat.vinyl().tx.commit -- one item of the vinyl table
---
- 1047632
... Project-Id-Version: Tarantool 1.10
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
 **Подробная информация о box.stat.vinyl().disk:** Поскольку vinyl является дисковым движком базы данных (в отличие от memtx'а, который представляет собой in-memory движок), он может обрабатывать большие базы данных -- однако если база данных больше объема памяти, выделенного для vinyl'а, дисковых операций будет больше. **Подробная информация о box.stat.vinyl().memory:** Хотя движок базы данных vinyl не является "in-memory", Tarantool'у всё же требуется память для записи буфера и для кэша: **Подробная информация о box.stat.vinyl().regulator:** Регулятор vinyl'а определяет, когда следует предпринимать или отложить действия по дисковому вводу-выводу, путем группировки действий в пакеты так, чтобы обеспечить согласованность и эффективность. Регулятор вызывается планировщиком vinyl'а раз в секунду и обновляет соответствующие переменные при каждом вызове. **Подробная информация о box.stat.vinyl().scheduler:** В основном содержит счетчики, связанные с задачами планировщика по созданию дампов или слиянию: (большинство сбрасываются на 0 при перезапуске сервера или вызове :ref:`box.stat.reset() <box_introspection-box_stat_reset>`): **Подробная информация о box.stat.vinyl().tx:** Информация о запросах, которые влияют на операции транзакций ("tx" используется в качестве сокращения слова "транзакция"): Понятие "дамп" (dump) объясняется в разделе :ref:`Хранение данных с помощью vinyl <engines-algorithm_filling_lsm>`: Дамп также создается во время операции создания :ref:`снимка <box-snapshot>`. Ниже приводится подробная информация о пунктах в ``box.stat.vinyl()``. В таблицах, которые возвращают ``box.stat()`` и ``box.stat.net()``: ``rps`` означает "[среднее количество] запросы в секунду [за последние 5 секунд]", ``total`` означает "всего [количество запросов, обработанных с момента запуска сервера]", ``current`` означает "[количество запросов] в ходе выполнения [которое можно ограничить с помощью :ref:`box.cfg.net_msg_max <cfg_networking-net_msg_max>`]". "ERROR" -- это счетчик запросов, которые завершились с ошибкой. Рано или поздно количество элементов в дереве превысит размер L0. Тогда L0 записывается в файл на диске (который называется забегом -- 'run') и освобождается под новые элементы. Эта операция называется 'дамп' (dump). Вложенный модуль `box.stat` Вложенный модуль ``box.stat`` предоставляет доступ к статистике Tarantool'а по запросам и использованию сети. Таким образом, можно сказать, что "L0 заполняется", когда объем данных в ``memory.level0`` приближается к максимальному, а именно :ref:`regulator.dump_watermark <box_introspection-box_stat_vinyl_regulator>`. Можно ожидать, что "L0 = 0" сразу после создания дампа. Текущий объем в ``box.stat.vinyl().memory.page_index`` и  ``box.stat.vinyl().memory.bloom_filter`` используется для структур, связанных с индексами. Размер -- это количество и размер ключей плюс :ref:`page_size <cfg_storage-vinyl_page_size>` плюс :ref:`bloom_fpr <cfg_storage-vinyl_bloom_fpr>`. Это не счетчик совпадений по фильтру Блума (количество чтений, которых можно избежать, поскольку фильтра Блума предсказывает их наличие в файле типа run) -- эта статистика указана в :ref:`index_object:stat() <box_index-stat>`. Таким образом, можно предсказать создание дампа, если размер L0 (указан в :ref:`memory.level0 <box_introspection-box_stat_vinyl_memory>`) приближается к максимальному (указан в :ref:`regulator.dump_watermark <box_introspection-box_stat_vinyl_regulator>`), и создание дампа еще не началось. На самом деле Tarantool планирует дамп до достижения предела. Используйте ``box.stat()``, чтобы узнать среднее количество запросов в секунду и общее количество запросов с момента запуска с разбивкой по типу запроса. Используйте ``box.stat.net()``, чтобы просмотреть статистику сетевой активности: количество отправленных и полученных пакетов, количество соединений, а также количество запросов (текущее, среднее, общее). Используйте ``box.stat.reset()``, чтобы сбросить статистику ``box.stat()``, ``box.stat.net()``, ``box.stat.vinyl()`` и :ref:`box.space.index <box_space-space_index>`. Используйте ``box.stat.vinyl()``, чтобы просмотреть данные по работе движка базы данных vinyl, например: ``box.stat.vinyl().tx`` содержит количество коммитов и откатов. Более подробную информацию см. в :ref:`конце раздела <box_introspection-box_stat_vinyl_details>`. ``box.stat.vinyl().disk.data_compacted`` представляет собой общий размер данных, которые хранятся на последнем уровне LSM-дерева, в байтах. При этом не учитывается сжатие диска. Его можно рассматривать как размер места на диске, которое заняли бы пользовательские данные, если бы не было компрессии, индексирования или увеличения спейса, вызванного конструкцией LSM-дерева. ``box.stat.vinyl().disk.data`` и ``box.stat.vinyl().disk.index`` содержат объем данных, который поступил в файлы во вложенной директории :ref:`vinyl_dir <cfg_basic-vinyl_dir>` с именами вида ``{lsn}.run`` и ``{lsn}.index``. Размер файла run зависит от вывода ``scheduler.dump_*``. ``box.stat.vinyl().memory.level0`` -- это объем памяти уровня 0 "level0", который иногда сокращается до "L0" и представляет собой область, которую vinyl может использовать для хранения данных в оперативной памяти в LSM-дереве. ``box.stat.vinyl().memory.tuple_cache`` содержит количество байтов, используемых для кортежей (данные). ``box.stat.vinyl().memory.tx`` -- это транзакционная память, как правило, равная 0. ``box.stat.vinyl().regulator.dump_bandwidth`` представляет собой предполагаемую среднюю скорость создания дампов. Изначально она составляет 10 485 760 (10 мегабайтов в секунду). Только значительные дампы (более одного мегабайта) используются при оценке. ``box.stat.vinyl().regulator.dump_watermark`` -- это точка, когда должно произойти создание дампа. Это значение несколько меньше объема памяти, выделенного для деревьев в vinyl'е, которое указано в параметре :ref:`vinyl_memory <cfg_storage-vinyl_memory>`. ``box.stat.vinyl().regulator.rate_limit`` -- это предел скорости записи в байтах в секунду, который налагается регулятором на основании установленной производительности создания дампов / слияния. ``box.stat.vinyl().regulator.write_rate`` представляет собой действительную среднюю скорость записи последних данных на диск. Средняя скорость вычисляется в течение 5-секундного интервала, поэтому если за последние 5 секунд ничего не происходило, то ``regulator.write_rate = 0``. Скорость ``write_rate`` может замедлиться во время создания дампа, или если пользователь задал предел :ref:`snap_io_rate_limit <cfg_binary_logging_snapshots-snap_io_rate_limit>`. ``box.stat.vinyl().scheduler.compaction_*`` содержит объем данных из последних изменений, для которых было произведено :ref:`слияние <box_index-compact>`. Он подразделяется на ``scheduler.compaction_input`` (объем данных текущего слияния), ``scheduler.compaction_queue`` (объем данных в ожидании слияния), ``scheduler.compaction_time`` (общее время, затраченное рабочими потоками на слияние, в секундах) и ``scheduler.compaction_output`` (объем данных после слияния, который, предположительно, меньше ``scheduler.compaction_input``). ``box.stat.vinyl().scheduler.tasks_*`` содержит информацию о задачах по созданию дампов или слиянию, разделенную на три категории: ``scheduler.tasks_inprogress`` (текущие), ``scheduler.tasks_completed`` (успешно завершенные) ``scheduler.tasks_failed`` (прерванные из-за ошибки). ``box.stat.vinyl().scheduler_dump_*`` содержит объем данных из последних изменений, для которых был создан дамп, включая ``dump_time`` (общее время, затраченное рабочими потоками на создание дампов, в секундах) и ``dump_count`` (счетчик созданных дампов), ``dump_input`` и ``dump_output``. ``box.stat.vinyl().tx.commit`` -- это счетчик коммитов (успешно завершенных транзакций). Он включает в себя неявные коммиты, например, любая вставка вызывает коммит, если она не входит в блок begin-end. ``box.stat.vinyl().tx.conflict`` содержит счетчик конфликтов, которые вызвали откат транзакции. ``box.stat.vinyl().tx.gap_locks`` представляет собой число блокировок разрывов во время выполнения запроса. Чтобы получить низкоуровневое описание имплементации блокировки разрывов в Tarantool'е, см. `Блокировка разрывов в менеджере транзакций Vinyl'а <https://github.com/tarantool/tarantool/issues/2671>`_. ``box.stat.vinyl().tx.read_views`` показывает, получила ли транзакция статус только для чтения, во избежание временного конфликта. Как правило, 0. ``box.stat.vinyl().tx.rollback`` -- это счетчик откатов (невыполненные транзакции). Это не просто счетчик явных запросов :ref:`box.rollback <box-rollback>`, он также включает в себя запросы, которые привели к ошибке. Например, после попытки вставки, в результате которой была выведена ошибка наличия дубликата ключа "Duplicate key exists in unique index", значение счетчика ``tx.rollback`` увеличивается. ``box.stat.vinyl().tx.statements``, как правило, будет равен 0. ``box.stat.vinyl().tx.transactions`` содержит количество текущих транзакций. tarantool> box.stat() -- вернуть 10 таблиц
---
- DELETE:
    total: 1873949
    rps: 123
  SELECT:
    total: 1237723
    rps: 4099
  INSERT:
    total: 0
    rps: 0
  EVAL:
    total: 0
    rps: 0
  CALL:
    total: 0
    rps: 0
  REPLACE:
    total: 1239123
    rps: 7849
  UPSERT:
    total: 0
    rps: 0
  AUTH:
    total: 0
    rps: 0
  ERROR:
    total: 0
    rps: 0
  UPDATE:
    total: 0
    rps: 0
...
tarantool> box.stat().DELETE -- всего + запросов в секунду из одной таблицы
---
- total: 0
  rps: 0
...
tarantool> box.stat.net() -- 4 таблицы
---
- SENT:
    total: 0
    rps: 0
  CONNECTIONS:
    current: 0
    rps: 0
    total: 0
  REQUESTS:
    current: 0
    rps: 0
    total: 0
  RECEIVED:
    total: 0
    rps: 0
...
tarantool> box.stat.vinyl().tx.commit -- один пункт из таблицы vinyl
---
- 1047632
... 