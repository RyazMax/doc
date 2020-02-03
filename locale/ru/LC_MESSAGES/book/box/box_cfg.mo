��          T               �      �   �   �   �   j  �   �  !   �  e  �  �  "  )   �  j  �    Z  �   u  !     �  ?   Submodule `box.cfg` The first call to ``box.cfg{...}`` (with or without parameters) initiates Tarantool's database module :ref:`box <box-module>`. To perform any database operations, you must call ``box.cfg{...}`` first. ``box.cfg{...}`` is also the command that reloads :ref:`persistent data files <index-box_persistence>` into RAM upon restart once we have data. tarantool> box.cfg
---
- checkpoint_count: 2
  too_long_threshold: 0.5
  slab_alloc_factor: 1.1
  memtx_max_tuple_size: 1048576
  background: false
  <...>
... tarantool> box.cfg{listen = 3301} tarantool> box.cfg{}
tarantool> box.cfg -- sorted in the alphabetic order
---
- background                   = false
  checkpoint_count             = 2
  checkpoint_interval          = 3600
  coredump                     = false
  custom_proc_title            = nil
  feedback_enabled             = true
  feedback_host                = 'https://feedback.tarantool.io'
  feedback_interval            = 3600
  force_recovery               = false
  hot_standby                  = false
  io_collect_interval          = nil
  listen                       = nil
  log                          = nil
  log_format                   = plain
  log_level                    = 5
  log_nonblock                 = true
  memtx_dir                    = '.'
  memtx_max_tuple_size         = 1024 * 1024
  memtx_memory                 = 256 * 1024 *1024
  memtx_min_tuple_size         = 16
  net_msg_max                  = 768
  pid_file                     = nil
  readahead                    = 16320
  read_only                    = false
  replication                  = nil
  replication_connect_timeout  = 4
  replication_skip_conflict    = false
  replication_sync_lag         = 10
  replication_sync_timeout     = 300
  replication_timeout          = 1
  rows_per_wal                 = 500000
  slab_alloc_factor            = 1.05
  snap_io_rate_limit           = nil
  too_long_threshold           = 0.5
  username                     = nil
  vinyl_bloom_fpr              = 0.05
  vinyl_cache                  = 128
  vinyl_dir                    = '.'
  vinyl_max_tuple_size         = 1024 * 1024* 1024 * 1024
  vinyl_memory                 = 128 * 1024 * 1024
  vinyl_page_size              = 8 * 1024
  vinyl_range_size             = nil
  vinyl_read_threads           = 1
  vinyl_run_count_per_level    = 2
  vinyl_run_size_ratio         = 3.5
  vinyl_timeout                = 60
  vinyl_write_threads          = 2
  wal_dir                      = '.'
  wal_dir_rescan_delay         = 2
  wal_max_size                 = 256 * 1024 * 1024
  wal_mode                     = 'write'
  worker_pool_threads          = 4
  work_dir                     = nil Project-Id-Version: Tarantool 1.10
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
 Вложенный модуль `box.cfg` Первый вызов ``box.cfg{...}`` (с параметрами или без них) запускает модуль базы данных Tarantool'а под названием :ref:`box <box-module>`. Чтобы выполнить любые операции с базой данных, необходимо сначала вызвать ``box.cfg{...}``. Команда ``box.cfg{...}`` также перезагружает :ref:`файлы с данными длительного хранения <index-box_persistence>` в оперативную память при перезапуске после получения данных. tarantool> box.cfg
 ---
 - checkpoint_count: 2
   too_long_threshold: 0.5
   slab_alloc_factor: 1.1
   memtx_max_tuple_size: 1048576
   background: false
   <...>
 ... tarantool> box.cfg{listen = 3301} tarantool> box.cfg{}
tarantool> box.cfg -- сортировка в алфавитном порядке
---
- background                   = false
  checkpoint_count             = 2
  checkpoint_interval          = 3600
  coredump                     = false
  custom_proc_title            = nil
  feedback_enabled             = true
  feedback_host                = 'https://feedback.tarantool.io'
  feedback_interval            = 3600
  force_recovery               = false
  hot_standby                  = false
  io_collect_interval          = nil
  listen                       = nil
  log                          = nil
  log_format                   = plain
  log_level                    = 5
  log_nonblock                 = true
  memtx_dir                    = '.'
  memtx_max_tuple_size         = 1024 * 1024
  memtx_memory                 = 256 * 1024 *1024
  memtx_min_tuple_size         = 16
  net_msg_max                  = 768
  pid_file                     = nil
  readahead                    = 16320
  read_only                    = false
  replication                  = nil
  replication_connect_timeout  = 4
  replication_skip_conflict    = false
  replication_sync_lag         = 10
  replication_sync_timeout     = 300
  replication_timeout          = 1
  rows_per_wal                 = 500000
  slab_alloc_factor            = 1.05
  snap_io_rate_limit           = nil
  too_long_threshold           = 0.5
  username                     = nil
  vinyl_bloom_fpr              = 0.05
  vinyl_cache                  = 128
  vinyl_dir                    = '.'
  vinyl_max_tuple_size         = 1024 * 1024* 1024 * 1024
  vinyl_memory                 = 128 * 1024 * 1024
  vinyl_page_size              = 8 * 1024
  vinyl_range_size             = nil
  vinyl_read_threads           = 1
  vinyl_run_count_per_level    = 2
  vinyl_run_size_ratio         = 3.5
  vinyl_timeout                = 60
  vinyl_write_threads          = 2
  wal_dir                      = '.'
  wal_dir_rescan_delay         = 2
  wal_max_size                 = 256 * 1024 * 1024
  wal_mode                     = 'write'
  worker_pool_threads          = 4
  work_dir                     = nil 