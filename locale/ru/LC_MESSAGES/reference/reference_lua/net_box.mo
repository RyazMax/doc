��    �      \              �     �     �  �   �  >   �	  8   �	  >   "
  @   a
  >   �
  >   �
  >      !   _      �  !   �  .   �     �  $     2   7  *   j  �   �  �     �   �  �   '  �   �  �   K  �   �  W  [  ~  �  �  2  �   �     �  -   �     �  )   �     (     ;  H  O     �  1  �     �  ]  �  /   K     {     �     �  ,   �  �   �  �   �     [     a     p  �   �     a  L   r     �     �     �  
   �     �     �     
     $  ,   2  L  _    �   C   �!  �   "  "  �"  8   �#  0   �#  >   $  Q   ]$  �   �$    1%  �  E&     �'     �'  ,   �'     (  +   0(  #   \(  &   �(  �   �(  �   <)     *  +   5*  Y   a*  �   �*  e   I+  Y   �+  k   	,  d   u,  �   �,  J   �-  �   �-  �   �.  �   \/  �   �/  b  �0  \   3  M  z3  H  �5    8     -9  �   59  �   :     �:  1   �:     ;  5   +;  '   a;  1   �;     �;  :   �;  
   <     <  "   *<     M<  c   k<     �<     �<  �  �<  W  o>     �?  �  �@     rI  ;   �I  B   �I  8   �I  1   8J  n   jJ  $   �J     �J  K   K  &   jK     �K  �  �K     =M     OM  [  cM  >   �N  8   �N  >   7O  @   vO  >   �O  >   �O  >   5P  !   tP      �P  !   �P  .   �P     Q  $   'Q  2   LQ  *   Q  �   �Q  �   vR  �   <S  �   T  �   �T  �   �U  �   �V  G  LW  �  �Y  ^  ~^  +  �a  ,   	c  \   6c  .   �c  T   �c  '   d  (   ?d  :  hd  '   �f  3  �f     �h  M  i  G   mk     �k  L   �k  M   l  g   ]l  �  �l  "  �n     �o     �o  1   �o  2  
p     =q  �   Tq     r  !   r     7r     Sr     fr     �r  D   �r  2   �r  U   s  l  ms  �  �u  �   �w  �   �x  "  �y  �   �{  W   1|  x   �|  �   }  �   �}     �~  �  ��  #   J�     n�  T   ��  2   ؃  U   �  :   a�  >   ��  !  ۄ  d  ��  +   b�  <   ��  t   ˇ  %  @�  �   f�  �   �  �   ��  �   ��  [  8�  U   ��  	  �  �   �  �   ֏  U  ��  ,  ב  �   �  �  ��  f  l�  /  ӟ     �  �   "�  �    �  #   ��  1   �     �  5   0�  '   f�  1   ��     ��  :   ͤ     �     �  "   8�     [�  �   y�     0�  2   E�  �  x�  �  b�     �  �  �  )   ��  <   ��  Q   ��  y   K�  H   Ŵ  �   �  f   ֵ  _   =�  �   ��  f   J�  -   ��   **Example:** **Examples:** -- wait infinitely for 'active' state:
conn:wait_state('active')

-- wait for 1.5 secs at most:
conn:wait_state('active', 1.5)

-- wait infinitely for either `active` or `fetch_schema` state:
conn:wait_state({active=true, fetch_schema=true}) :ref:`conn.space.space-name:delete{field-value} <conn-delete>` :ref:`conn.space.space-name:get{field-value} <conn-get>` :ref:`conn.space.space-name:insert{field-value} <conn-insert>` :ref:`conn.space.space-name:replace{field-value} <conn-replace>` :ref:`conn.space.space-name:select{field-value} <conn-select>` :ref:`conn.space.space-name:update{field-value} <conn-update>` :ref:`conn.space.space-name:upsert{field-value} <conn-upsert>` :ref:`conn:call() <net_box-call>` :ref:`conn:close() <conn-close>` :ref:`conn:eval() <net_box-eval>` :ref:`conn:is_connected() <conn-is_connected>` :ref:`conn:ping() <conn-ping>` :ref:`conn:timeout() <conn-timeout>` :ref:`conn:wait_connected() <conn-wait_connected>` :ref:`conn:wait_state() <conn-wait_state>` :samp:`conn.space.{space-name}:delete(...)` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:delete(...)`. :samp:`conn.space.{space-name}:get(...)` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:get(...)`. :samp:`conn.space.{space-name}:insert(...)` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:insert(...)`. :samp:`conn.space.{space-name}:replace(...)` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:replace(...)`. :samp:`conn.space.{space-name}:select`:code:`({...})` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:select`:code:`{...}`. :samp:`conn.space.{space-name}:update(...)` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:update(...)`. :samp:`conn.space.{space-name}:upsert(...)` is the remote-call equivalent of the local call :samp:`box.space.{space-name}:upsert(...)`. :samp:`conn:eval({Lua-string})` evaluates and executes the expression in Lua-string, which may be any statement or series of statements. An :ref:`execute privilege <authentication-owners_privileges>` is required; if the user does not have it, an administrator may grant it with :samp:`box.schema.user.grant({username}, 'execute', 'universe')`. All ``net.box`` methods are fiber-safe, that is, it is safe to share and use the same connection object across multiple concurrent fibers. In fact that is perhaps the best programming practice with Tarantool. When multiple fibers use the same connection, all requests are pipelined through the same network socket, but each fiber gets back a correct response. Reducing the number of active sockets lowers the overhead of system calls and increases the overall server performance. However for some cases a single connection is not enough —- for example, when it is necessary to prioritize requests or to use different authentication IDs. Although ``timeout(...)`` is deprecated, all remote calls support its use. Using a wrapper object makes the remote connection API compatible with the local one, removing the need for a separate ``timeout`` argument, which the local version would ignore. Once a request is sent, it cannot be revoked from the remote server even if a timeout expires: the timeout expiration only aborts the wait for the remote server response, not the request itself. Although the final result of an async request is the same as the result of a sync request, it is structured differently: as a table, instead of as the unpacked values. And here starts the example: Below is a list of all ``net.box`` functions. Call a stored procedure Check if a connection is active or closed Close a connection Close a connection. Connection objects are destroyed by the Lua garbage collector, just like any other objects in Lua, so an explicit destruction is not mandatory. However, since close() is a system call, it is good programming practice to close a connection explicitly when it is no longer needed, to avoid lengthy stalls of the garbage collector. Create a connection Create a new connection. The connection is established on demand, at the time of the first request. It can be re-established automatically after a disconnect (see ``reconnect_after`` option below). The returned ``conn`` object supports methods for making remote requests, such as select, update or delete. Delete a tuple Due to :ref:`the implicit yield rules <atomic-implicit-yields>` a local :samp:`box.space.{space-name}:select`:code:`{...}` does not yield, but a remote :samp:`conn.space.{space-name}:select`:code:`{...}` call does yield, so global variables or database tuples data may change when a remote :samp:`conn.space.{space-name}:select`:code:`{...}` occurs. Evaluate and execute the expression in a string Example Execute a PING command Execute a PING command. Here are commands for a quick sandbox setup: If authentication and schema upload are required, it's possible later on to re-enter the 'fetch_schema' state from 'active' if a request fails due to a schema version mismatch error, so schema reload is triggered. In the presence of ``reconnect_after``, ``wait_connected`` ignores transient failures. The wait completes once the connection is established or is closed explicitly. Index Insert a tuple Insert or replace a tuple Limitation: the called function cannot return a function, for example if ``func2`` is defined as ``function func2 () return func end`` then ``conn:call(func2)`` will return "error: unsupported Lua type 'function'". Module `net.box` Most ``net.box`` methods allow a final ``{options}`` argument, which can be: Name On this diagram: Overview Parameters Possible options: Select a tuple Select one or more tuples Set a timeout Show whether connection is active or closed. The ``net.box`` module contains connectors to remote database systems. One variant, to be discussed later, is for connecting to MySQL or MariaDB or PostgreSQL (see :ref:`SQL DBMS modules <dbms_modules>` reference). The other variant, which is discussed in this section, is for connecting to Tarantool server instances via a network. The default is ``is_async=false``, meaning requests are synchronous for the fiber. The fiber is blocked, waiting until there is a reply to the request or until timeout expires. Before Tarantool version 1.10, the only way to make asynchronous requests was to put them in separate fibers. The diagram below shows possible connection states and transitions: The names ``connect()`` and ``new()`` are synonyms: ``connect()`` is preferred; ``new()`` is retained for backward compatibility. The non-default is ``is_async=true``, meaning requests are asynchronous for the fiber. The request causes a yield but there is no waiting. The immediate return is not the result of the request, instead it is an object that the calling program can use later to get the result of the request. The sandbox configuration for this example assumes that: The state machine starts in the 'initial' state. This example shows the use of most of the ``net.box`` methods. This immediately-returned object, which we'll call "future", has its own methods: To ensure that the return from ``conn:eval`` is whatever the Lua expression returns, begin the Lua-string with the word "return". Typically ``{is_async=true}`` is used only if the load is large (more than 100,000 requests per second) and latency is large (more than 1 second), or when it is necessary to send multiple requests in parallel then collect responses (sometimes called a "map-reduce" scenario). Typically a user would say ``future=request-name(...{is_async=true})``, then either loop checking ``future:is_ready()`` until it is true and then say ``request_result=future:result()``, or say ``request_result=future:wait_result(...)``. Alternatively the client could check for "out-of-band" messages from the server by calling ``pairs()`` in a loop -- see :ref:`box.session.push() <box_session-push>`. Update a tuple Use Wait for a connection to be active or closed Wait for a target state Wait for connection to be active or closed. You can call the following methods: [since 1.7.2] Wait for a target state. ``conn.close()`` method sets the state to 'closed' and kills the worker. If the transport is already in the 'error' state, ``close()`` does nothing. ``conn:call('func', {'1', '2', '3'})`` is the remote-call equivalent of ``func('1', '2', '3')``. That is, ``conn:call`` is a remote stored-procedure call. The return from ``conn:call`` is whatever the function returns. ``conn:close`` to disconnect. ``future:discard()`` to abandon the object. ``future:is_ready()`` which will return true when the result of the request is available, ``future:result()`` to get the result of the request (returns the response or **nil** in case it's not ready yet or there has been an error), ``future:wait_result(timeout)`` to wait until the result of the request is available and then get it, ``net_box.connect()`` method changes the state to 'connecting' and spawns a worker fiber. ``net_box.connect()`` to connect and get a connection object (named ``conn`` for examples in this section), ``require('net.box')`` to get a ``net.box`` object (named ``net_box`` for examples in this section), ``timeout(...)`` is a wrapper which sets a timeout for the request that follows it. Since version 1.7.4 this method is deprecated -- it is better to pass a timeout value for a method's ``{options}`` parameter. ``{buffer=...}``. For an example see :ref:`buffer module <buffer-module>`. ``{is_async=...}``. For example, a method whose final argument is ``{is_async=true}`` will not wait for the result of a request. See the :ref:`is_async <net_box-is_async>` description. ``{is_async=true|false}`` is an option which is applicable for all ``net_box`` requests including ``conn:call``, ``conn:eval``, and the ``conn.space.space-name`` requests. ``{on_push=... on_push_ctx=...}``. For receiving out-of-band messages. See the :ref:`box.session.push <box_session-push>` description. ``{timeout=...}``. For example, a method whose final argument is ``{timeout=1.5}`` will stop after 1.5 seconds on the local node, although this does not guarantee that execution will stop on the remote server node. `call_16`: [since 1.7.2] by default, ``net.box`` connections comply with a new binary protocol command for CALL, which is not backward compatible with previous versions. The new CALL no longer restricts a function to returning an array of tuples and allows returning an arbitrary MsgPack/JSON result, including scalars, nil and void (nothing). The old CALL is left intact for backward compatibility. It will be removed in the next major release. All programming language drivers will be gradually changed to use the new CALL. To connect to a Tarantool instance that uses the old CALL, specify ``call_16=true``. `connect_timeout`: number of seconds to wait before returning "error: Connection timed out". `console`: depending on the option's value, the connection supports different methods (as if instances of different classes were returned). With ``console = true``, you can use ``conn`` methods ``close()``, ``is_connected()``, ``wait_state()``, ``eval()`` (in this case, both binary and Lua console network protocols are supported). With ``console = false`` (default), you can also use ``conn`` database methods (in this case, only the binary protocol is supported). Deprecation notice: ``console = true`` is deprecated, users should use :ref:`console.connect() <console-connect>` instead. `reconnect_after`: a ``net.box`` instance automatically reconnects any time the connection is broken or if a connection attempt fails. This makes transient network failures become transparent to the application. Reconnect happens automatically in the background, so queries/requests that suffered due to connectivity loss are transparently retried. The number of retries is unlimited, connection attempts are done over the specified timeout (e.g. ``reconnect_after=5`` for 5 secs). Once a connection is explicitly closed, or once the Lua garbage collector removes it, reconnects stop. `wait_connected`: by default, connection creation is blocked until the connection is established, but passing ``wait_connected=false`` makes it return immediately. Also, passing a timeout makes it wait before returning (e.g. ``wait_connected=1.5`` makes it wait at most 1.5 seconds). boolean box.cfg{listen = 3301}
s = box.schema.space.create('tester')
s:create_index('primary', {type = 'hash', parts = {1, 'unsigned'}})
t = s:insert({800, 'TEST'})
box.schema.user.grant('guest', 'read,write,execute', 'universe') conn = net_box.connect('localhost:3301')
conn = net_box.connect('127.0.0.1:3302', {wait_connected = false})
conn = net_box.connect('127.0.0.1:3303', {reconnect_after = 5, call_16 = true}) conn object conn.space.Q:update({1},{{'=',2,5}}, {timeout=0}) conn.space.testspace:get({1}) conn.space.testspace:insert({2,3,4,5}, {timeout=1.1}) conn.space.testspace:replace({5,6,7,8}) conn.space.testspace:select({1,'B'}, {timeout=1}) conn:close() conn:timeout(0.5).space.tester:update({1}, {{'=', 2, 15}}) in seconds net_box.self:is_connected() net_box.self:ping({timeout = 0.5}) net_box.self:wait_connected() other ``net.box()`` routines, passing ``conn:``, to execute requests on the remote database system, return rtype tarantool> -- create 2 functions with conn:eval()
tarantool> conn:eval('function f1() return 5+5 end;')
tarantool> conn:eval('function f2(x,y) return x,y end;')
tarantool> -- call first function with no parameters and no options
tarantool> conn:call('f1')
---
- 10
...
tarantool> -- call second function with two parameters and one option
tarantool> conn:call('f2',{1,'B'},{timeout=99})
---
- 1
- B
... tarantool> --Lua-string
tarantool> conn:eval('function f5() return 5+5 end; return f5();')
---
- 10
...
tarantool> --Lua-string, {arguments}
tarantool> conn:eval('return ...', {1,2,{3,'x'}})
---
- 1
- 2
- [3, 'x']
...
tarantool> --Lua-string, {arguments}, {options}
tarantool> conn:eval('return {nil,5}', {}, {timeout=0.1})
---
- [null, 5]
... tarantool> future = conn.space.tester:insert({900},{is_async=true})
---
...
tarantool> future
---
- method: insert
  response: [900]
  cond: cond
  on_push_ctx: []
  on_push: 'function: builtin#91'
...
tarantool> future:is_ready()
---
- true
...
tarantool> future:result()
---
- [900]
... tarantool> net_box = require('net.box')
---
...
tarantool> function example()
         >   local conn, wtuple
         >   if net_box.self:ping() then
         >     table.insert(ta, 'self:ping() succeeded')
         >     table.insert(ta, '  (no surprise -- self connection is pre-established)')
         >   end
         >   if box.cfg.listen == '3301' then
         >     table.insert(ta,'The local server listen address = 3301')
         >   else
         >     table.insert(ta, 'The local server listen address is not 3301')
         >     table.insert(ta, '(  (maybe box.cfg{...listen="3301"...} was not stated)')
         >     table.insert(ta, '(  (so connect will fail)')
         >   end
         >   conn = net_box.connect('127.0.0.1:3301')
         >   conn.space.tester:delete({800})
         >   table.insert(ta, 'conn delete done on tester.')
         >   conn.space.tester:insert({800, 'data'})
         >   table.insert(ta, 'conn insert done on tester, index 0')
         >   table.insert(ta, '  primary key value = 800.')
         >   wtuple = conn.space.tester:select({800})
         >   table.insert(ta, 'conn select done on tester, index 0')
         >   table.insert(ta, '  number of fields = ' .. #wtuple)
         >   conn.space.tester:delete({800})
         >   table.insert(ta, 'conn delete done on tester')
         >   conn.space.tester:replace({800, 'New data', 'Extra data'})
         >   table.insert(ta, 'conn:replace done on tester')
         >   conn.space.tester:update({800}, {{'=', 2, 'Fld#1'}})
         >   table.insert(ta, 'conn update done on tester')
         >   conn:close()
         >   table.insert(ta, 'conn close done')
         > end
---
...
tarantool> ta = {}
---
...
tarantool> example()
---
...
tarantool> ta
---
- - self:ping() succeeded
  - '  (no surprise -- self connection is pre-established)'
  - The local server listen address = 3301
  - conn delete done on tester.
  - conn insert done on tester, index 0
  - '  primary key value = 800.'
  - conn select done on tester, index 0
  - '  number of fields = 1'
  - conn delete done on tester
  - conn:replace done on tester
  - conn update done on tester
  - conn close done
... target states the :ref:`URI <index-uri>` of the target for the connection the Tarantool instance is running on ``localhost 127.0.0.1:3301``, the current user has read, write and execute privileges. the supported option is :samp:`timeout={seconds}` there is a space named ``tester`` with a numeric primary key and with a tuple that contains a key value = 800, true if connected, false on failure. true on success, false on error true when a target state is reached, false on timeout or connection closure true when connected, false on failure. userdata Project-Id-Version: Tarantool 1.10
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
 **Пример:** **Примеры:** -- бесконечное ожидание состояния 'active':
conn:wait_state('active')

-- ожидание в течение максимум 1,5 секунд:
conn:wait_state('active', 1.5)

-- бесконечное ожидание состояния `active` или `fetch_schema`:
conn:wait_state({active=true, fetch_schema=true}) :ref:`conn.space.space-name:delete{field-value} <conn-delete>` :ref:`conn.space.space-name:get{field-value} <conn-get>` :ref:`conn.space.space-name:insert{field-value} <conn-insert>` :ref:`conn.space.space-name:replace{field-value} <conn-replace>` :ref:`conn.space.space-name:select{field-value} <conn-select>` :ref:`conn.space.space-name:update{field-value} <conn-update>` :ref:`conn.space.space-name:upsert{field-value} <conn-upsert>` :ref:`conn:call() <net_box-call>` :ref:`conn:close() <conn-close>` :ref:`conn:eval() <net_box-eval>` :ref:`conn:is_connected() <conn-is_connected>` :ref:`conn:ping() <conn-ping>` :ref:`conn:timeout() <conn-timeout>` :ref:`conn:wait_connected() <conn-wait_connected>` :ref:`conn:wait_state() <conn-wait_state>` :samp:`conn.space.{имя-спейса}:delete(...)` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:delete(...)`. :samp:`conn.space.{имя-спейса}:get(...)` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:get(...)`. :samp:`conn.space.{имя-спейса}:insert(...)` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:insert(...)`. :samp:`conn.space.{имя-спейса}:replace(...)` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:replace(...)`. :samp:`conn.space.{имя-спейса}:select`:code:`({...})` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:select`:code:`{...}`. :samp:`conn.space.{имя-спейса}:update(...)` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:update(...)`. :samp:`conn.space.{имя-спейса}:upsert(...)` -- это удаленный вызов, аналогичный локальному вызову :samp:`box.space.{имя-спейса}:upsert(...)`. :samp:`conn:eval({Lua-строка})` оценивает и выполняет выражение в Lua-строке, которое может представлять собой любое выражение или несколько выражений. Требуются :ref:`права на выполнение <authentication-owners_privileges>`; если у пользователя таких прав нет, администратор может их выдать с помощью :samp:`box.schema.user.grant({имя-пользователя}, 'execute', 'universe')`. Все методы ``net.box`` безопасны для файберов, то есть можно безопасно обмениваться и использовать один и тот же объект подключения в нескольких файберах одновременно. Фактически так лучше всего работать в Tarantool'е. Когда несколько файберов используют одно соединение, все запросы передаются по одному сетевому сокету, но каждый файбер получает правильный ответ. Уменьшение количества активных сокетов снижает затрату ресурсов на системные вызовы и увеличивает общую производительность сервера. Однако, в некоторых случаях отдельного соединения недостаточно -- например, когда необходимо отдавать приоритет разным запросам или использовать различные идентификаторы при аутентификации. Хотя ``timeout(...)`` объявлен устаревшим, все удаленные вызовы поддерживают его. Использование надстройки обеспечивает совместимость API удаленного соединения с локальным, поэтому отпадает необходимость в отдельном аргументе ``timeout``, который проигнорирует локальная версия. После отправки запроса его нельзя отменить с удаленного сервера даже по истечении времени задержки: окончание времени задержки прерывает только ожидание ответа от удаленного сервера, а не сам запрос. Хотя окончательный результат асинхронного запроса не отличается от результата синхронного запроса, у него другая структура: таблица, а не неупакованные значения. А здесь приведен пример: Ниже приведен перечень всех функций модуля ``net.box``. Вызов хранимой процедуры Проверка активности или закрытия подключения Закрытие подключения Закрытие подключения. Объекты подключения удаляются сборщиком мусора в Lua, как и любой другой Lua-объект, поэтому удалять их явным образом необязательно. Однако, поскольку close() представляет собой системный вызов, лучше всего закрыть соединение явным образом, когда оно больше не используется, с целью ускорения работы сборщика мусора. Создание подключения Создание нового подключения. Подключение устанавливается по требованию во время первого запроса. Можно повторно установить подключение автоматически после отключения (см. ниже опцию ``reconnect_after``). Возвращается объект ``conn``, который поддерживает методы создание удаленных запросов, таких как select, update или delete. Удаление кортежа Исходя из :ref:`правил неявной передачи управления <atomic-implicit-yields>`, локальный запрос :samp:`box.space.{имя-спейса}:select`:code:`{...}` не передает управление, а удаленный :samp:`conn.space.{имя-спейса}:select`:code:`{...}` передаст, поэтому глобальные переменные или кортежи в базе данных могут измениться во время удаленного :samp:`conn.space.{имя-спейса}:select`:code:`{...}`. Оценка и выполнение выражения в строке Пример Выполнение команды проверки состояния PING Выполнение команды проверки состояния PING. Ниже приведены команды для быстрой настройки песочницы: Если требуются аутентификация и загрузка схемы, можно позднее повторно войти в состояние загрузки схемы 'fetch_schema' из активного 'active', если запрос не будет выполнен из-за ошибки несовпадения версий схемы, то есть будет вызвана перезагрузка схемы. Если присутствует ``reconnect_after``, ``wait_connected`` проигнорирует неустойчивые отказы. Ожидание заканчивается, когда подключение установлено или явным образом закрыто. Указатель Вставка кортежа Вставка или замена кортежа Ограничение: вызванная функция не может вернуть функцию, например, если ``func2`` определяется как ``function func2 () return func end``, то ``conn:call(func2)`` вернет ошибку "error: unsupported Lua type 'function'". Модуль `net.box` В большинстве методов ``net.box`` можно использовать заключительный аргумент ``{options}``, который может быть: Имя На этой диаграмме: Общие сведения Параметры Возможные опции: Выбор кортежа Выбор одного или нескольких кортежей Установка времени ожидания Проверка активности или закрытия подключения. Модуль ``net.box`` включает в себя коннекторы для удаленных систем с базами данных. Одним из вариантов, который рассматривается позднее, является подключение к MySQL, MariaDB или PostgreSQL (см. справочник по :ref:`Модулям  СУБД SQL <dbms_modules>`). Другим вариантом, который рассматривается в данном разделе, является подключение к экземплярам Tarantool-сервера по сети. По умолчанию, ``is_async=false``, что означает, что запросы будут синхронными для файбера. Файбер блокируется в ожидании ответа на запрос или до истечения времени ожидания. До версии Tarantool'а 1.10 единственным способом выполнения асинхронных запросов было использование отдельных файберов. На диаграмме ниже представлены возможные состояния и варианты перехода из одного состояния в другое: Имена ``connect()`` и ``new()`` являются синонимами: предпочтительным будет ``connect()``, а ``new()`` обеспечивает поддержку обратной совместимости. ``is_async=true`` означает, что запросы будут асинхронными для файбера. Запрос вызывает передачу управления, но файбер не входит в режим ожидания. Сразу же возвращается результат, но это будет не результат запроса, а объект, который может использовать вызывающая программа для получения результат запроса. Данный пример сработает на конфигурации из песочницы, предполагается, что: Работа начинается с начального состояния 'initial'. Ниже приводится пример использования большинства методов ``net.box``. У такого сразу же возвращаемого объекта, который мы называем "future" (будущий), есть собственные методы: Чтобы гарантировать, что ``conn:eval`` вернет то, что возвращает выражение на Lua, начните Lua-строку со слова "return" (вернуть). Как правило, ``{is_async=true}`` используется только при большой загрузке (более 100 000 запросов в секунду) и большой задержке чтения (более 1 секунды), или же при необходимости отправки нескольких одновременных запросов, которые собирают ответы (что иногда называется "отображение-свертка"). В обычной ситуации пользователь введет команду ``future=имя-запроса(...{is_async=true})``, а затем либо цикл с проверкой ``future:is_ready()`` до тех пор, пока он не вернет true, и получением результата с помощью  ``request_result=future:result()``, либо же команду ``request_result=future:wait_result(...)``. Возможен вариант, когда клиент проверяет наличие внеполосных сообщений от сервера, вызывая в цикле ``pairs()`` -- см. :ref:`box.session.push() <box_session-push>`. Обновление кортежа Назначение Ожидание активности или закрытия подключения Ожидание нужного состояния Ожидание активности или закрытия подключения. Можно вызвать следующие методы: [с 1.7.2] Ожидание нужного состояния. Метод ``conn.close()`` изменяет состояние на закрытое 'closed' и отключает рабочий процесс. Если транспорт уже находится в состоянии ошибки 'error', ``close()`` не делает ничего. ``conn:call('func', {'1', '2', '3'})`` -- это удаленный вызов, аналогичный ``func('1', '2', '3')``. Таким образом, ``conn:call`` представляет собой удаленный вызов хранимой процедуры. ``conn:call`` возвращает то, что возвращает функция. ``conn:close`` для отключения. ``future:discard()`` откажется от объекта. ``future:is_ready()`` вернет true (правда), если доступен результат запроса, ``future:result()`` используется для получения результата запроса (возвращает ответ на запрос или **nil** в случае, если ответ еще не готов или произошла какая-либо ошибка), ``future:wait_result(timeout)`` будет ждать, когда результат запроса будет доступен, а затем получит его. Выполнение метода ``net_box.connect()`` переводит состояние в 'connecting', создается рабочий файбер. ``net_box.connect()`` для подключения и получения объекта подключения (который называется ``conn`` для примеров в данном разделе), ``require('net.box')`` для получения объекта ``net.box`` (который называется ``net_box`` для примеров в данном разделе), ``timeout(...)`` -- это надстройка, которая определяет время ожидания для запроса. С версии 1.7.4 этот метод объявлен устаревшим -- лучше передать значение времени ожидания с помощью параметра ``{options}``. ``{buffer=...}``. Например, см. :ref:`модуль buffer <buffer-module>`. ``{is_async=...}``. Например, метод с заключительным аргументом ``{is_async=true}`` не будет ждать результата выполнения запроса. См. описание :ref:`is_async <net_box-is_async>`. ``{is_async=true|false}`` -- это опция, которую можно применить во всех запросах ``net_box``, включая ``conn:call``, ``conn:eval`` и запросы ``conn.space.space-name``. ``{on_push=... on_push_ctx=...}``. Для получения внеполосных сообщений. См. описание :ref:`box.session.push <box_session-push>`. ``{timeout=...}``. Например, метод с заключительным аргументом ``{timeout=1.5}`` остановится через 1,5 секунды на локальном узле, хотя это не гарантирует, что выполнение остановится на удаленном сервере. `call_16`: [с 1.7.2] по умолчанию, подключения ``net.box`` соответствуют команде CALL нового бинарного протокола, который не поддерживает обратную совместимость с предыдущими версиями. Команда нового бинарного протокола для вызова CALL больше не ограничивает функцию в возврате массива кортежей и позволяет возвращать произвольный результат в формате MsgPack/JSON, включая scalar (скалярные значения), nil (нулевые значения) и void (пусто). Старый метод CALL оставлен нетронутым для обратной совместимости. В следующей основной версии он будет удален. Все драйверы для языков программирования будут постепенно переведены на использование нового метода CALL. Для подключения к экземпляру Tarantool'а, в котором используется старый метод CALL, укажите ``call_16=true``. `connect_timeout`: количество секунд ожидания до возврата ошибки "error: Connection timed out". `console`: в зависимости от значения параметра поддерживаются различные методы (как если бы возвращались экземпляры разных классов). Если ``console = true``, можно использовать методы ``conn``: ``close()``, ``is_connected()``, ``wait_state()``, ``eval()`` (в этом случае поддерживаются и бинарный сетевой протокол, и протокол Lua-консоли). Если ``console = false`` (по умолчанию), также можно использовать методы ``conn`` для работы с базой данных (в этом случае поддерживается только бинарный протокол). Устарел: ``console = true`` объявлен устаревшим, вместо него следует использовать :ref:`console.connect() <console-connect>`. `reconnect_after`: ``net.box`` автоматически подключается повторно в случае разрыва соединения или провала попытки подключения. В таком случае неустойчивые сетевые отказы становятся очевидными. Повторное подключение выполняется автоматически в фоновом режиме, поэтому запросы/обращения, не выполненные по причине потери соединения, явным образом выполняются повторно. Количество повторов не ограничено, попытки подключения выполняются в течение указанного времени ожидания (например, ``reconnect_after=5`` -- 5 секунд). После явного закрытия подключения или удаления сборщиком мусора в Lua попытки соединения повторно не выполняются. `wait_connected`: по умолчанию, создание подключения блокируется до тех пор, пока подключение не будет установлено, но передача ``wait_connected=false`` заставит метод сразу же вернуться. Передача времени ожидания заставит метод ждать до возвращения (например, ``wait_connected=1.5`` заставит ожидать подключения максимум 1,5 секунды). boolean (логический) box.cfg{listen = 3301}
s = box.schema.space.create('tester')
s:create_index('primary', {type = 'hash', parts = {1, 'unsigned'}})
t = s:insert({800, 'TEST'})
box.schema.user.grant('guest', 'read,write,execute', 'universe') conn = net_box.connect('localhost:3301')
conn = net_box.connect('127.0.0.1:3302', {wait_connected = false})
conn = net_box.connect('127.0.0.1:3303', {reconnect_after = 5, call_16 = true}) объект подключения conn.space.Q:update({1},{{'=',2,5}}, {timeout=0}) conn.space.testspace:get({1}) conn.space.testspace:insert({2,3,4,5}, {timeout=1.1}) conn.space.testspace:replace({5,6,7,8}) conn.space.testspace:select({1,'B'}, {timeout=1}) conn:close() conn:timeout(0.5).space.tester:update({1}, {{'=', 2, 15}}) в секундах net_box.self:is_connected() net_box.self:ping({timeout = 0.5}) net_box.self:wait_connected() другие процедуры ``net.box()``, передающие ``conn:`` для выполнения запросов в удаленной системе базы данных, возвращает тип возвращаемого значения tarantool> -- создание 2 функций с conn:eval()
tarantool> conn:eval('function f1() return 5+5 end;')
tarantool> conn:eval('function f2(x,y) return x,y end;')
tarantool> -- вызов первой функции без параметров и опций
tarantool> conn:call('f1')
---
- 10
...
tarantool> -- вызов второй функции с двумя параметрами и одной опцией
tarantool> conn:call('f2',{1,'B'},{timeout=99})
---
- 1
- B
... tarantool> --Lua-строка
tarantool> conn:eval('function f5() return 5+5 end; return f5();')
---
- 10
...
tarantool> --Lua-строка, {аргументы}
tarantool> conn:eval('return ...', {1,2,{3,'x'}})
---
- 1
- 2
- [3, 'x']
...
tarantool> --Lua-строка, {аргументы}, {парметры}
tarantool> conn:eval('return {nil,5}', {}, {timeout=0.1})
---
- [null, 5]
... tarantool> future = conn.space.tester:insert({900},{is_async=true})
---
...
tarantool> future
---
- method: insert
  response: [900]
  cond: cond
  on_push_ctx: []
  on_push: 'function: builtin#91'
...
tarantool> future:is_ready()
---
- true
...
tarantool> future:result()
---
- [900]
... tarantool> net_box = require('net.box')
---
...
tarantool> function example()
         >   local conn, wtuple
         >   if net_box.self:ping() then
         >     table.insert(ta, 'self:ping() succeeded')
         >     table.insert(ta, '  (no surprise -- self connection is pre-established)')
         >   end
         >   if box.cfg.listen == '3301' then
         >     table.insert(ta,'The local server listen address = 3301')
         >   else
         >     table.insert(ta, 'The local server listen address is not 3301')
         >     table.insert(ta, '(  (maybe box.cfg{...listen="3301"...} was not stated)')
         >     table.insert(ta, '(  (so connect will fail)')
         >   end
         >   conn = net_box.connect('127.0.0.1:3301')
         >   conn.space.tester:delete({800})
         >   table.insert(ta, 'conn delete done on tester.')
         >   conn.space.tester:insert({800, 'data'})
         >   table.insert(ta, 'conn insert done on tester, index 0')
         >   table.insert(ta, '  primary key value = 800.')
         >   wtuple = conn.space.tester:select({800})
         >   table.insert(ta, 'conn select done on tester, index 0')
         >   table.insert(ta, '  number of fields = ' .. #wtuple)
         >   conn.space.tester:delete({800})
         >   table.insert(ta, 'conn delete done on tester')
         >   conn.space.tester:replace({800, 'New data', 'Extra data'})
         >   table.insert(ta, 'conn:replace done on tester')
         >   conn.space.tester:update({800}, {{'=', 2, 'Fld#1'}})
         >   table.insert(ta, 'conn update done on tester')
         >   conn:close()
         >   table.insert(ta, 'conn close done')
         > end
---
...
tarantool> ta = {}
---
...
tarantool> example()
---
...
tarantool> ta
---
- - self:ping() succeeded
  - '  (no surprise -- self connection is pre-established)'
  - The local server listen address = 3301
  - conn delete done on tester.
  - conn insert done on tester, index 0
  - '  primary key value = 800.'
  - conn select done on tester, index 0
  - '  number of fields = 1'
  - conn delete done on tester
  - conn:replace done on tester
  - conn update done on tester
  - conn close done
... необходимое состояние :ref:`URI <index-uri>` объекта подключения экземпляр Tarantool'а запущен на ``localhost 127.0.0.1:3301``, у текущего пользователя есть права на чтение, запись и выполнение. поддерживается опция :samp:`timeout={секунды}` создан спейс под названием ``tester`` с первичным числовым ключом и кортежем, в котором есть ключ со значением= 800, true (правда) при подключении, false (ложь), если не выполнено. true (правда), если выполнено, false (ложь) в случае ошибки true (правда) при подключении, false (ложь) при окончании времени ожидания или закрытии подключения true (правда) при подключении, false (ложь), если не выполнено. пользовательские данные 