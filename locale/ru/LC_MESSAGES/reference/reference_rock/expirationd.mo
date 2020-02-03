��          �               �  �  �  �   `  1  C  �  u     T  Z  l  g   �  *  /	     Z
    o
  /   �    �  �   �  �   m  �  Y  6  =  �   t  y   m  o   �  �   W  �  �  �   p  !    T  %  R   z  �   �  �  p  �    4  �  �     D  �!  5   B%  W  x%  �   �'  �  �(     �*  �  �*  J   �,  �  �,  �   �.  p  �/  �  �0  l  �3  �  G7  �   �8  �   �9  �   �:  �  k;    >>  !  A?  T  cA  R   �B  �   C   -- default process_expired_tuple function
local function default_tuple_drop(space_id, args, tuple)
    box.space[space_id]:delete(construct_key(space_id, tuple))
end
    /* construct_key() contains:
    local function construct_key(space_id, tuple)
        return fun.map(
            function(x) return tuple[x.fieldno] end,
           box.space[space_id].index[0].parts
        ):totable()
    end */ After :ref:`sleeping <fiber-sleep>` for two seconds, when the task has had time to do its iterations through the spaces, ``expd.task_stats()`` will print out a report showing how many tuples have expired -- "expired_count: 0". After sleeping for two more seconds, ``expd.task_stats()`` will print out a report showing how many tuples have expired -- "expired_count: 1". This shows that the ``is_tuple_expired()`` function eventually returned "true" for one of the tuples, because its timestamp field was more than three seconds old. At this point, if the above explanation is worthwhile, it is clear that ``expirationd.lua`` starts a background routine (fiber) which iterates through all the tuples in a space, sleeps cooperatively so that other fibers can operate at the same time, and -- whenever it finds a tuple that has expired -- deletes it from this space. Now the "``expirationd_run_task()``" function can be used in a test which creates sample data, lets the daemon run for a while, and prints results. Execute these requests: For a commercial-grade example of a Lua rock that works with Tarantool, let us look at the source code of ``expirationd``, which Tarantool supplies on GitHub_ with an Artistic license. The ``expirationd.lua`` program is lengthy (about 500 lines), so here we will only highlight the matters that will be enhanced by studying the full source later. For those who like to see things run, here are the exact steps to get ``expirationd`` through the test. Get ``expirationd.lua``. There are standard ways -- it is after all part of a `standard rock <https://luarocks.org/modules/rtsisyk/expirationd>`_ -- but for this purpose just copy the contents of ``expirationd.lua`` to a directory on the Lua path (type ``print(package.path)`` to see the Lua path). Module `expirationd` Of course, ``expirationd`` can be customized to do different things by passing different parameters, which will be evident after looking in more detail at the source code. Particularly important are ``{options}`` which can be added as a final parameter in ``expirationd.run_task``: Start the Tarantool server as described before. The "for" instruction can be translated as "iterate through the index of the space that is being scanned", and within it, if the tuple is "expired" (for example, if the tuple has a timestamp field which is less than the current time), process the tuple as an expired tuple. The database-specific requests (``cfg``, :ref:`space.create <box_schema-space_create>`, :ref:`create_index <box_space-create_index>`) should already be familiar. The function which will be supplied to ``expirationd`` is :codenormal:`is_tuple_expired`, which is saying "if the second field of the tuple is less than the :ref:`current time <fiber-time>`  , then return true, otherwise return false". The key for getting the rock rolling is ``expd = require('expirationd')``. The require_ function is what reads in the program; it will appear in many later examples in this manual, when it's necessary to get a module that's not part of the Tarantool kernel, but is on the Lua path (``package.path``) or the C path (``package.cpath``). After the Lua variable expd has been assigned the value of the ``expirationd`` module, it's possible to invoke the module's ``run_task()`` function. Ultimately the tuple-expiry process leads to ``default_tuple_drop()`` which does a "delete" of a tuple from its original space. First the fun :ref:`fun <fun-module>` module is used, specifically fun.map_. Remembering that :codenormal:`index[0]` is always the space's primary key, and :codenormal:`index[0].parts[`:codeitalic:`N`:codenormal:`].fieldno` is always the field number for key part :codeitalic:`N`, fun.map() is creating a table from the primary-key values of the tuple. The result of fun.map() is passed to :ref:`space_object:delete() <box_space-delete>`. Whenever one hears "daemon" in Tarantool, one should suspect it's being done with a :doc:`fiber<../reference_lua/fiber>`. The program is making a fiber and turning control over to it so it runs occasionally, goes to sleep, then comes back for more. ``force`` (boolean) -- run task even on replica. Default: ``force=false`` so ordinarily ``expirationd`` ignores replicas. ``full_scan_time`` (number) -- number of seconds required for full index scan Default: ``full_scan_time=3600``. ``tuples_per_iteration`` (integer) -- number of tuples that will be checked by one iteration Default: ``tuples_per_iteration=1024``. ``vinyl_assumed_space_len_factor`` (integer) -- factor for recalculation of size of vinyl space. Default: ``vinyl_assumed_space_len_factor=2``. (The size of a vinyl space cannot be easily calculated, so on the first iteration it will be the "assumed" size, on the second iteration it will be "assumed" times "factor", on the third iteration it will be "assumed" times "factor" times factor", and so on.) ``vinyl_assumed_space_len`` (integer) -- assumed size of vinyl space, for the first iteration only. Default: ``vinyl_assumed_space_len=10000000``. fiber = require('fiber')
expd = require('expirationd')
box.cfg{}
e = box.schema.space.create('expirationd_test')
e:create_index('primary', {type = 'hash', parts = {1, 'unsigned'}})
e:replace{1, fiber.time() + 3}
e:replace{2, fiber.time() + 30}
function is_tuple_expired(args, tuple)
  if (tuple[2] < fiber.time()) then return true end
  return false
  end
expd.run_task('expirationd_test', e.id, is_tuple_expired)
retval = {}
fiber.sleep(2)
expd.task_stats()
fiber.sleep(2)
expd.task_stats()
expd.kill_task('expirationd_test')
e:drop()
os.exit() for _, tuple in scan_space.index[0]:pairs(nil, {iterator = box.index.ALL}) do
...
    expiration_process(task, tuple)
...
    /* expiration_process() contains:
    if task.is_tuple_expired(task.args, tuple) then
    task.expired_tuples_count = task.expired_tuples_count + 1
    task.process_expired_tuple(task.space_id, task.args, tuple) */ local function expirationd_run_task(name, space_id, is_tuple_expired, options)
... task.worker_fiber = fiber.create(worker_loop, task)
log.info("expiration: task %q restarted", task.name)
...
fiber.sleep(expirationd.constants.check_interval)
... Project-Id-Version: Tarantool 1.10
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
 -- функция обработки неактуального кортежа по умолчанию
local function default_tuple_drop(space_id, args, tuple)
    box.space[space_id]:delete(construct_key(space_id, tuple))
end
    /* construct_key() contains:
    local function construct_key(space_id, tuple)
        return fun.map(
            function(x) return tuple[x.fieldno] end,
           box.space[space_id].index[0].parts
        ):totable()
    end */ После ухода :ref:`в режим ожидания <fiber-sleep>` на две секунды, когда проводится итерация по спейсам, ``expd.task_stats()`` выведет отчет о количестве неактуальных кортежей -- "expired_count: 0". После ожидания в течение еще двух секунд ``expd.task_stats()`` выведет отчет о количестве неактуальных кортежей -- "expired_count: 1". Это показывает, что функция ``is_tuple_expired()`` с течением времени вернула "true" для одного из кортежей, поскольку поле метки времени было дольше трех секунд. На этом этапе ясно, что ``expirationd.lua`` запускает фоновый процесс (файбер), который выполняет итерацию по всем кортежам в спейсе, в рамках кооперативной многозадачности уходит в режим ожидания, чтобы другие файберы могли работать одновременно с ним, а когда находит неактуальный кортеж, удаляет его из спейса. Теперь функцию "``expirationd_run_task()``" можно использовать в тестировании, где создаются образцы данных, некоторое время работает демон, и выводятся результаты. Выполните следующие запросы: Рассмотрим исходный код ``expirationd`` -- пример Lua-модуля для промышленной эксплуатации, который работает с Tarantool'ом -- Tarantool предоставляет его с лицензией Artistic на GitHub_. Программа ``expirationd.lua`` довольно объемная (около 500 строк), поэтому здесь мы остановимся на пунктах, знания о которых можно расширить, позднее изучив программу полностью. Если вы хотите увидеть, как все работает, обратите внимание на нижеприведенные шаги по включению ``expirationd`` в тестирование. Найдите ``expirationd.lua``. Можно воспользоваться стандартным способом, поскольку модуль включен в общий список `модулей <https://luarocks.org/modules/rtsisyk/expirationd>`_, но для этой цели просто скопируйте содержимое ``expirationd.lua`` в директорию в Lua-пути (введите ``print(package.path)``, чтобы увидеть Lua-путь). Модуль `expirationd` Конечно, ``expirationd`` можно настроить на выполнение различных задач с помощью разных параметров, что будет очевидно после более детального изучения исходного кода. В частности, важны опции ``{options}``, которые можно добавить в качестве последнего параметра в ``expirationd.run_task``: Запустите Tarantool-сервер, как описано выше. Команду "for" можно перевести как "выполнить итерацию по индексу сканируемого спейса", а внутри -- если кортеж "неактуален" (например, если в кортеже есть поле метки времени, которое меньше текущего времени), то обработать кортеж как неактуальный кортеж. Запросы в работе с базой данных (``cfg``, :ref:`space.create <box_schema-space_create>`, :ref:`create_index <box_space-create_index>`) уже должны быть вам знакомы. В ``expirationd`` передается функция :codenormal:`is_tuple_expired`, которая задает следующее условие: если второе поле кортежа меньше :ref:`текущего времени <fiber-time>`  , вернуть true (правда), в противном случае, вернуть false (ложь). Ключ к запуску модуля -- ``expd = require('expirationd')``. Функция require_ -- это именно то, что выполняет чтение в программе. Она появится и в дальнейших примерах в данном руководстве, когда будет необходимо запустить модуль, который не входит в ядро Tarantool'а, но находится в Lua-пути (``package.path``) или же C-пути (``package.cpath``). После того, как Lua-переменной expd присваивается значение модуля ``expirationd``, можно вызвать функцию модуля ``run_task()``. В конечном итоге, обработка неактуального кортежа приводит к ``default_tuple_drop()``, что приводит к удалению кортежа из первоначального спейса. Сначала используется модуль :ref:`fun <fun-module>`, в частности fun.map_. Учитывая, что :codenormal:`index[0]` всегда является первичным ключом спейса, а :codenormal:`index[0].parts[`:codeitalic:`N`:codenormal:`].fieldno` всегда является номером поля для компонента ключа :codeitalic:`N`, функция fun.map() создает таблицу из первичных значений кортежа. Результат fun.map() передается в :ref:`space_object:delete() <box_space-delete>`. Если в Tarantool'е упоминается "демон", то речь идет об использовании :doc:`файбера <../reference_lua/fiber>`. Программа создает файбер и передает управление так, что он периодически запускается, уходит в режим ожидания, а затем повторяет эти действия. ``force`` (логическое значение) -- выполнение задачи даже на реплике. По умолчанию: ``force=false``, поэтому, как правило, ``expirationd`` не учитывает реплики. ``full_scan_time`` (число) -- число секунд на полное сканирование диска. По умолчанию: ``full_scan_time=3600``. ``tuples_per_iteration`` (целое число) -- количество кортежей, которые проверяются за одну итерацию. По умолчанию: ``tuples_per_iteration=1024``. ``vinyl_assumed_space_len_factor`` (целое число) -- коэффициент перерасчета размера спейса vinyl'а. По умолчанию: ``vinyl_assumed_space_len_factor=2``. (Размер спейса vinyl'а не так легко рассчитать, поэтому для первой итерации используется "предполагаемый" размер, на второй итерации -- "предполагаемый" размер, помноженный на "коэффициент", на третьей итерации -- "предполагаемый" размер, дважды помноженный на "коэффициент" и так далее.) ``vinyl_assumed_space_len`` (целое число) -- предполагаемый размер спейса vinyl'а, используется только для первой итерации. По умолчанию: ``vinyl_assumed_space_len=10000000``. fiber = require('fiber')
expd = require('expirationd')
box.cfg{}
e = box.schema.space.create('expirationd_test')
e:create_index('primary', {type = 'hash', parts = {1, 'unsigned'}})
e:replace{1, fiber.time() + 3}
e:replace{2, fiber.time() + 30}
function is_tuple_expired(args, tuple)
  if (tuple[2] < fiber.time()) then return true end
  return false
  end
expd.run_task('expirationd_test', e.id, is_tuple_expired)
retval = {}
fiber.sleep(2)
expd.task_stats()
fiber.sleep(2)
expd.task_stats()
expd.kill_task('expirationd_test')
e:drop()
os.exit() for _, tuple in scan_space.index[0]:pairs(nil, {iterator = box.index.ALL}) do
...
    expiration_process(task, tuple)
...
    /* expiration_process() contains:
    if task.is_tuple_expired(task.args, tuple) then
    task.expired_tuples_count = task.expired_tuples_count + 1
    task.process_expired_tuple(task.space_id, task.args, tuple) */ local function expirationd_run_task(name, space_id, is_tuple_expired, options)
... task.worker_fiber = fiber.create(worker_loop, task)
log.info("expiration: task %q restarted", task.name)
...
fiber.sleep(expirationd.constants.check_interval)
... 