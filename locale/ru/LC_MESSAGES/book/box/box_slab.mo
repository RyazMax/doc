��    .      �              �     �  ,   
  &   7  (   ^  D   �  .   �  ,   �     (     .     3    <  6   ?  :   v  *   �  9   �       �   +  |       �     �  z   �  7   &	  �   ^	  -   �	  ,   
  �   ?
  z   �
  �   ;  6   �  G   �  ;   >  L   z  �   �  7   �  Y   �  0   E  1   v  0   �     �     �     �  �   �  *  �  �  �  �   �  �  ;     �  ,   �  &     (   D  �   m  ]   �  [   S     �     �     �    �  �   �  �   s  �   	  �   �  *       F  �   [  �  .     +   �   F   7   /!  �   g!  R   a"  R   �"    #  �   $  "  �$  j   &     l&  z   �&  �   g'  �  (  7   �)  u   �)  M   F*  S   �*  _   �*     H+  2   a+     �+  �   �+  *  >,  �  i-  �   g/   **Example:** :ref:`box.runtime.info() <box_runtime_info>` :ref:`box.slab.info() <box_slab_info>` :ref:`box.slab.stats() <box_slab_stats>` A complete report would show memory usage statistics for all groups: Below is a list of all ``box.slab`` functions. Here is a sample report for the first group: Index Name Overview Show a detailed memory usage report (in bytes) for the slab allocator. The report is broken down into groups by *data item size* as well as by *slab size* (64-byte, 136-byte, etc). The report includes the memory allocated for storing both tuples and indexes. Show a detailed memory usage report for slab allocator Show a memory usage report (in bytes) for the Lua runtime. Show a memory usage report for Lua runtime Show an aggregated memory usage report for slab allocator Submodule `box.slab` The ``box.slab`` submodule provides access to slab allocator statistics. The slab allocator is the main allocator used to store :ref:`tuples <index-box_tuple>`. This can be used to monitor the total memory usage and memory fragmentation. The total ``mem_used`` for all groups in this report equals ``arena_used`` in :ref:`box.slab.info() <box_slab_info>` report. This report is saying that there are 2 data items (``item_count`` = 2) stored in one (``slab_count`` = 1) 24-byte slab (``item_size`` = 24), so ``mem_used`` = 2 * 24 = 48 bytes. Also, ``slab_size`` is 16384 bytes, of which 16384 - 48 = 16232 bytes are free (``mem_free``). Use ``arena_size`` is the *total* memory used for tuples and indexes together (including allocated, but currently free slabs); ``arena_used_ratio`` = ``arena_used`` / ``arena_size``; ``arena_used`` is the *efficient* memory used for storing tuples and indexes together (omitting allocated, but currently free slabs). ``item_count`` is the number of stored items; ``item_size`` is the size of each data item; ``items_size`` is the *total* amount of memory (including allocated, but currently free slabs) used only for tuples, no indexes; ``items_used_ratio`` = ``items_used`` / ``slab_count`` * ``slab_size`` (these are slabs used only for tuples, no indexes); ``items_used`` is the *efficient* amount of memory (omitting allocated, but currently free slabs) used only for tuples, no indexes; ``lua`` is the heap size of the Lua garbage collector; ``maxalloc`` is the maximal memory quota that can be allocated for Lua; ``mem_free`` is the allocated, but currently unused memory; ``mem_used`` is the memory used for storing data items (tuples and indexes); ``quota_size`` is the maximum amount of memory that the slab allocator can use for both tuples and indexes (as configured in the :ref:`memtx_memory <cfg_storage-memtx_memory>` parameter, the default is 2^28 bytes =  268,435,456 bytes); ``quota_used_ratio`` = ``quota_used`` / ``quota_size``; ``quota_used`` is the amount of memory that is already distributed to the slab allocator; ``slab_count`` is the number of slabs allocated; ``slab_size`` is the size of each allocated slab. ``used`` is the current memory size used by Lua. return rtype table tarantool> box.runtime.info()
---
- lua: 913710
  maxalloc: 4398046510080
  used: 12582912
...
tarantool> box.runtime.info().used
---
- used: 12582912
... tarantool> box.slab.info()
---
- items_size: 228128
  items_used_ratio: 1.8%
  quota_size: 1073741824
  quota_used_ratio: 0.8%
  arena_used_ratio: 43.2%
  items_used: 4208
  quota_used: 8388608
  arena_size: 2325176
  arena_used: 1003632
...

tarantool> box.slab.info().arena_used
---
- 1003632
... tarantool> box.slab.stats()
---
- - mem_free: 16232
    mem_used: 48
    item_count: 2
    item_size: 24
    slab_count: 1
    slab_size: 16384
  - mem_free: 15720
    mem_used: 560
    item_count: 14
    item_size: 40
    slab_count: 1
    slab_size: 16384
  <...>
  - mem_free: 32472
    mem_used: 192
    item_count: 1
    item_size: 192
    slab_count: 1
    slab_size: 32768
  - mem_free: 1097624
    mem_used: 999424
    item_count: 61
    item_size: 16384
    slab_count: 1
    slab_size: 2097152
  ... tarantool> box.slab.stats()[1]
---
- mem_free: 16232
  mem_used: 48
  item_count: 2
  item_size: 24
  slab_count: 1
  slab_size: 16384
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
 **Пример:** :ref:`box.runtime.info() <box_runtime_info>` :ref:`box.slab.info() <box_slab_info>` :ref:`box.slab.stats() <box_slab_stats>` В полном отчете будет статистика по использованию памяти во всех группах: Ниже приведен перечень всех функций модуля ``box.slab``. Ниже представлен пример отчета для первой группы: Индекс Имя Общие сведения Отображение подробного отчета об использовании памяти (в байтах) для распределения slab. Отчет разбивается на группы по *размеру элементов данных*, а также по *размеру slab'а* (64 байта, 136 байтов и т.д.). Отчет включает в себя информацию о памяти, выделенной на хранение и кортежей, и индексов. Отображение подробного отчета по использованию памяти для распределения slab Отображение отчета по использованию памяти (в байтах) во время исполнения Lua-кода. Отображение отчета по использованию памяти во время исполнения Lua-кода Отображение обобщенного отчета по использованию памяти для распределения slab Вложенный модуль `box.slab` Вложенный модуль ``box.slab`` предоставляет доступ к статистике распределения slab. Механизм распределения slab представляет собой основной тип распределения для хранения :ref:`кортежей <index-box_tuple>`. Такое распределение можно использовать для отслеживания использования памяти и фрагментации памяти. Общий объем используемой памяти ``mem_used`` для всех групп в данном отчете равен ``arena_used`` в отчете :ref:`box.slab.info() <box_slab_info>`. В отчете показано, что есть два элемента данных (``item_count`` = 2), которые хранятся в одном (``slab_count`` = 1) 24-байтовом slab'е (``item_size`` = 24), поэтому объем используемой памяти ``mem_used`` = 2 * 24 = 48 байтов. Кроме того, размер slab'а ``slab_size`` составляет 16384 байта, из которых 16384 - 48 = 16232 байта свободны (``mem_free``). Использование ``arena_size`` -- это *общий* объем памяти, используемый для кортежей и индексов (включая выделенные, но в данный момент свободные slab'ы); ``arena_used_ratio`` = ``arena_used`` / ``arena_size``; ``arena_used`` -- это *эффективный* объем памяти, используемый для кортежей и индексов (не включая выделенные, но в данный момент свободные slab'ы). ``item_count`` -- это количество хранимых элементов; ``item_size`` -- это размер каждого элемента данных; ``items_size`` -- это *общий* объем памяти (включая выделенные, но в данный момент свободные slab'ы), который используется только для кортежей, а не для индексов; ``items_used_ratio`` = ``items_used`` / ``slab_count`` * ``slab_size`` (это slab'ы, которые используются только для кортежей, не для индексов); ``items_used`` -- это *эффективный* объем памяти (не включая выделенные, но в данный момент свободные slab'ы), который используется только для кортежей, а не для индексов; ``lua`` -- это размер динамической памяти сборщика мусора в Lua; ``maxalloc`` -- это максимальная квота памяти, которую можно выделить для Lua; ``mem_free`` -- это выделенная, но не используемая в данный момент память; ``mem_used`` -- это память, используемая для хранения элементов данных (кортежей и индексов); ``quota_size`` -- максимальный объем памяти, который механизм распределения slab может использовать как для кортежей, так и для индексов (как настроено в параметре :ref:`memtx_memory <cfg_storage-memtx_memory>`, по умолчанию 2^28 байтов =  268 435 456 байтов); ``quota_used_ratio`` = ``quota_used`` / ``quota_size``; ``quota_used`` -- это объем памяти, уже выделенный для распределения slab; ``slab_count`` -- это количество выделенных slab'ов; ``slab_size`` -- это размер каждого выделенного slab'а. ``used`` -- объем памяти, используемый Lua в данный момент. возвращается тип возвращаемого значения таблица tarantool> box.runtime.info()
---
- lua: 913710
  maxalloc: 4398046510080
  used: 12582912
...
tarantool> box.runtime.info().used
---
- used: 12582912
... tarantool> box.slab.info()
---
- items_size: 228128
  items_used_ratio: 1.8%
  quota_size: 1073741824
  quota_used_ratio: 0.8%
  arena_used_ratio: 43.2%
  items_used: 4208
  quota_used: 8388608
  arena_size: 2325176
  arena_used: 1003632
...

tarantool> box.slab.info().arena_used
---
- 1003632
... tarantool> box.slab.stats()
---
- - mem_free: 16232
    mem_used: 48
    item_count: 2
    item_size: 24
    slab_count: 1
    slab_size: 16384
  - mem_free: 15720
    mem_used: 560
    item_count: 14
    item_size: 40
    slab_count: 1
    slab_size: 16384
  <...>
  - mem_free: 32472
    mem_used: 192
    item_count: 1
    item_size: 192
    slab_count: 1
    slab_size: 32768
  - mem_free: 1097624
    mem_used: 999424
    item_count: 61
    item_size: 16384
    slab_count: 1
    slab_size: 2097152
  ... tarantool> box.slab.stats()[1]
---
- mem_free: 16232
  mem_used: 48
  item_count: 2
  item_size: 24
  slab_count: 1
  slab_size: 16384
... 