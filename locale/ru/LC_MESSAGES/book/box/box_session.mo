��    {      �              �  n   �  �   <  �   �  �   }	  �   
     �
     �
     �
     �
     �
  �  �
  �  �  �   �  9     �   G  ,   �  0     (   N  2   w  8   �  >   �  ,   "  ,   O  0   |  (   �  ,   �  ,     *   0  ,   [  @   �    �  �   �  =   |  n   �     )     A     [     t  <  �  S   �  F  !      h   a   �   �   �   �  �!  *   u#  #   �#     �#     �#     �#  ,   $     D$  D   b$  e   �$  Z   %  S   h%  p   �%  M   -&  g   {&     �&     �&  �   �&     �'  
   �'  9   �'     �'     (  �   7(  �  �(  �  �*  �   �,     W-  ,   o-  �   �-    e.  �   t/  C   O0  �  �0  �  ;2  w   �3  _   [4  I  �4     6  �  !6  �   �7  �   Z8  �   �8  �   a9  >   :  u   P:  :   �:  T   ;  �  V;     �<  �   �<  �   �=  �   v>  D   F?  �   �?  �  e@  /   �A  �   !B     �B     �B     �B     C     C     C  �  C  �   �D  `   �E  c   .F  f   �F  �   �F  H   �G  :   H  *   YH  j   �H  >   �H  �   .I     J     J  �  +J  �   �K  	  �L  �   �M  �   �N  �   wO     tP     �P     �P     �P     �P  I  �P    !]  �   %`  C   �`  �   +a  ,   �a  0   b  (   2b  2   [b  8   �b  >   �b  ,   c  ,   3c  0   `c  (   �c  ,   �c  ,   �c  *   d  ,   ?d  r   ld  �  �d    �f  v   �g  �   (h  <   �h  ,   i  E   .i  C   ti    �i  �   �k  (  Vl  K   n  �   �n  R  |o  E  �p  X   t  r   nt  K   �t  Y   -u  G   �u  \   �u  E   ,v  w   rv  �   �v  �   �w  |   Rx  �   �x  �   Uy  �   �y     �z     �z  B  �z     |     |  V   2|  =   �|  <   �|  �   }    �}  j  �  R  {�  -   ΅  J   ��  ;  G�  �  ��  �  �  �   ˊ  n  R�  �  ��  �   g�  �   O�    �  S    �  j  T�  �   ��  �   ��  �   i�  �   e�  b   Q�    ��  ]   ̛  u   *�  �  ��     p�  �   ��  p  X�  s  ɡ  g   =�  �   ��  �  �  ;   �  &  G�  .   n�  ,   ��  
   ʧ     է  2   �     !�  �  7�  �   ��  `   �  c   P�  f   ��  �   �  Z   ��  N   R�  B   ��  �   �  K   ��  P  ��     G�      g�   'applier' if the action is due to :ref:`replication <replication>`, regardless of how the connection was done; 'background' if the action is in a :ref:`background fiber <fiber-module>`, regardless of whether the Tarantool server was :ref:`started in the background <cfg_basic-background>`. 'binary' if the connection was done via the binary protocol, for example to a target made with :ref:`box.cfg{listen=...} <cfg_basic-listen>`; 'console' if the connection was done via the administrative console, for example to a target made with :ref:`console.listen <console-listen>`; 'repl' if the connection was done directly, for example when :ref:`using Tarantool as a client <admin-using_tarantool_as_a_client>`; **Example #1** **Example #2** **Example 1** **Example 2** **Example** -- Make two shells. On Shell#1 set up a "server", and
-- in it have a function that includes box.session.push:
box.cfg{listen=3301}
box.schema.user.grant('guest','read,write,execute','universe')
x = 0
fiber = require('fiber')
function server_function() x=x+1; fiber.sleep(1); box.session.push(x); end

-- On Shell#2 connect to this server as a "client" that
-- can handle Lua (such as another Tarantool server operating
-- as a client), and initialize a table where we'll get messages:
net_box = require('net.box')
conn = net_box.connect(3301)
messages_from_server = {}

-- On Shell#2 remotely call the server function and receive
-- a SYNCHRONOUS out-of-band message:
conn:call('server_function', {},
          {is_async = false,
           on_push = table.insert,
           on_push_ctx = messages_from_server})
messages_from_server
-- After a 1-second pause that is caused by the fiber.sleep()
-- request inside server_function, the result in the
--  messages_from_server table will be: 1. Like this:
-- tarantool> messages_from_server
-- ---
-- - - 1
-- ...
-- Good. That shows that box.session.push(x) worked,
-- because we know that x was 1.

-- On Shell#2 remotely call the same server function and
-- get an ASYNCHRONOUS out-of-band message. For this we cannot
-- use on_push and on_push_ctx options, but we can use pairs():
future = conn:call('server_function', {}, {is_async = true})
messages = {}
keys = {}
for i, message in future:pairs() do
    table.insert(messages, message) table.insert(keys, i) end
messages
future:wait_result(1000)
for i, message in future:pairs() do
    table.insert(messages, message) table.insert(keys, i) end
messages
-- There is no pause because conn:call does not wait for
-- server_function to finish. The first time that we go through
-- the pairs() loop, we see the messages table is empty. Like this:
-- tarantool> messages
-- ---
-- - - 2
--   - []
-- ...
-- That is okay because the server hasn't yet called
-- box.session.push(). The second time that we go through
-- the pairs() loop, we see the value of x at the time of
-- the second call to box.session.push(). Like this:
-- tarantool> messages
-- ---
-- - - 2
--   - &0 []
--   - 2
--   - *0
-- ...
-- Good. That shows that the message was asynchronous, and
-- that box.session.push() did its job. -- On the first server instance, which listens on port 3301
box.cfg{listen=3301}
function function1()
  print('function 1, box.session.user()='..box.session.user())
  end
function function2(user_name)
  print('function 2, box.session.user()='..box.session.user())
  print('function 2, user_name='..user_name)
  end
function function3(user_name, status)
  print('function 3, box.session.user()='..box.session.user())
  print('function 3, user_name='..user_name)
  if status == true then
    print('function 3, status = true, authorization succeeded')
    end
  end
box.session.on_auth(function1)
box.session.on_auth(function2)
box.session.on_auth(function3)
box.schema.user.passwd('admin') -- On the second server instance, that connects to port 3301
console = require('console')
console.connect('admin:admin@localhost:3301') 1 if the session exists, 0 if the session does not exist. 2014-12-15 13:21:34.444 [11360] main/103/iproto I>
    Connection. user=guest id=3
2014-12-15 13:22:19.289 [11360] main/103/iproto I>
    Disconnection. user=guest id=3 :ref:`box.session.euid() <box_session-euid>` :ref:`box.session.exists() <box_session-exists>` :ref:`box.session.id() <box_session-id>` :ref:`box.session.on_auth() <box_session-on_auth>` :ref:`box.session.on_connect() <box_session-on_connect>` :ref:`box.session.on_disconnect() <box_session-on_disconnect>` :ref:`box.session.peer() <box_session-peer>` :ref:`box.session.push() <box_session-push>` :ref:`box.session.storage <box_session-storage>` :ref:`box.session.su() <box_session-su>` :ref:`box.session.sync() <box_session-sync>` :ref:`box.session.type() <box_session-type>` :ref:`box.session.uid() <box_session-uid>` :ref:`box.session.user() <box_session-user>` A *session* is an object associated with each client connection. A Lua table that can hold arbitrary unordered session-specific names and values, which will last until the session ends. For example, this table could be useful to store current tasks when working with a `Tarantool queue manager <https://github.com/tarantool/queue>`_. After the following series of requests, a Tarantool instance will write a message using the :ref:`log <log-module>` module whenever any user connects or disconnects. Below is a list of all ``box.session`` functions and members. Change Tarantool's :ref:`current user <authentication-users>` -- this is analogous to the Unix command ``su``. Change the current user Check if a session exists Define a connect trigger Define a disconnect trigger Define a trigger for execution after a client has disconnected. If the trigger function causes an error, the error is logged but otherwise is ignored. The trigger is invoked while the session associated with the client still exists and can access session properties, such as :ref:`box.session.id() <box_session-id>`. Define a trigger for execution during :ref:`authentication <authentication-users>`. Define a trigger for execution when a new session is created due to an event such as :ref:`console.connect <console-connect>`. The trigger function will be the first thing executed after a new session is created. If the trigger execution fails and raises an error, the error is sent to the client and the connection is closed. Define an authentication trigger Details about trigger characteristics are in the :ref:`triggers <triggers-box_triggers>` section. Every user has a unique name (seen with :ref:`box.session.user() <box_session-user>`) and a unique ID (seen with ``box.session.uid()``). The values are stored together in the ``_user`` space. Generate an out-of-band message. By "out-of-band" we mean an extra message which supplements what is passed in a network via the usual channels. Although ``box.session.push()`` can be called at any time, in practice it is used with networks that are set up with :ref:`module net.box <net_box-module>`, and it is invoked by the server (on the "remote database system" to use our terminology for net.box), and the client has options for getting such messages. Get the connection type or cause of action Get the current effective user's ID Get the current session's ID Get the current user's ID Get the current user's name Get the session peer's host address and port Get the sync integer constant Here is what might appear in the log file in a typical installation: If a trigger always results in an error, it may become impossible to connect to a server to reset it. If both parameters are omitted, then the response is a list of existing trigger functions. If the parameters are (nil, old-trigger-function), then the old trigger is deleted. If the result is an error, then the first part of the return is ``nil`` and the second part is the error object. If the result is not an error, then the return is the boolean value ``true``. If the trigger fails by raising an error, the error is sent to the client and the connection is closed. Index Name Or, if function-to-execute is specified, change Tarantool's :ref:`current user <authentication-users>` temporarily while executing the function -- this is analogous to the Unix command ``sudo``. Overview Parameters Possible errors: 'session.peer(): session does not exist' Possible return values are: Send an out-of-band message Since version 1.10, the trigger function is invoked immediately after the disconnect, even if requests that were made during the session have not finished. Situation 1: when the client calls synchronously with the default ``{async=false}`` option. There are two optional additional options: :samp:`on_push={function-name}`, and :samp:`on_push_ctx={function-argument}`. When the client receives an out-of-band message for the session, it invokes "function-name(function-argument)". For example, with options ``{on_push=table.insert, on_push_ctx=messages}``, the client will insert whatever it receives into a table named 'messages'. Situation 2 complication: ``pairs()`` is subject to timeout. So there is an optional argument = timeout per iteration. If timeout occurs before there is a new message or a final response, there is an error return. To check for an error one can use the first loop parameter (if the loop starts with "for i, message in future:pairs()" then the first loop parameter is i). If it is ``box.NULL`` then the second parameter (in our example, "message") is the error object. Situation 2: when the client calls asynchronously with the non-default ``{async=true}`` option. Here ``on_push`` and ``on_push_ctx`` are not allowed, but the messages can be seen by calling ``pairs()`` in a loop. Submodule `box.session` Table with session-specific names and values The :ref:`binary protocol <admin-security>` has a separate :ref:`authentication packet <box_protocol-authentication>`. For this case, connection and authentication are considered to be separate steps. The :ref:`console.connect <console-connect>` function includes an authentication check for all users except 'guest'. For this case, the ``on_auth`` trigger function is invoked after the ``on_connect`` trigger function, if and only if the connection has succeeded so far. The ``box.session`` submodule allows querying the session state, writing to a session-specific temporary Lua table, or sending out-of-band messages, or setting up triggers which will fire when a session starts or ends. The ``on_auth`` trigger function is invoked in these circumstances: The client's job is to check for such messages after it sends something to the server. The major client methods -- :ref:`conn:call <net_box-call>`, :ref:`conn:eval <net_box-eval>`, :ref:`conn:select <conn-select>`, :ref:`conn:insert <conn-insert>`, :ref:`conn:replace <conn-replace>`, :ref:`conn:update <conn-update>`, :ref:`conn:upsert <conn-upsert>`, :ref:`delete <conn-delete>` -- may cause the server to send a message. The first case: if the call to ``box.session.euid()`` is within a function invoked by :ref:`box.session.su(user-name, function-to-execute) <box_session-su>` -- in that case, ``box.session.euid()`` returns the ID of the changed user (the user who is specified by the ``user-name`` parameter of the ``su`` function)  but ``box.session.uid()`` returns the ID of the original user (the user who is calling the ``su`` function). The first server instance listens on port 3301; its default user name is 'admin'. There are three ``on_auth`` triggers: The first trigger has a function with no arguments, it can only look at ``box.session.user()``. The host address and port of the session peer, for example "127.0.0.1:55457". If the session exists but there is no connection to a separate instance, the return is null. The command is executed on the server instance, so the "local name" is the server instance's host and port, and the "peer name" is the client's host and port. The result looks like this: The second case: if the call to ``box.session.euid()`` is within a function specified with :ref:`box.schema.func.create(function-name, {setuid= true}) <box_schema-func_create>` and the binary protocol is in use -- in that case, ``box.session.euid()`` returns the ID of the user who created "function-name" but ``box.session.uid()`` returns the ID of the the user who is calling "function-name". The second server instance will connect with :ref:`console.connect <console-connect>`, and then will cause a display of the variables that were set by the trigger functions. The second trigger has a function with a ``user_name`` argument, it can look at both of: ``box.session.user()`` and ``user_name``. The server's sole job is to call ``box.session.push()``, there is no automatic mechanism for showing that the message was received. The third trigger has a function with a ``user_name`` argument and a ``status`` argument, it can look at all three of: ``box.session.user()`` and ``user_name`` and ``status``. This function returns an error if the session is disconnected. This function works only if there is a peer, that is, if a connection has been made to a separate Tarantool instance. This is a more complex example, with two server instances. This is the same as :ref:`box.session.uid() <box_session-uid>`, except in two cases: Unlike other trigger types, ``on_auth`` trigger functions are invoked **before** the event. Therefore a trigger function like :code:`function auth_function () v = box.session.user(); end` will set :code:`v` to "guest", the user name before the authentication is done. To get the user name **after** the authentication is done, use the special syntax: :code:`function auth_function (user_name) v = user_name; end` Use When the return is ``true``, the message has gone to the network buffer as a :ref:`packet <box_protocol-iproto_protocol>` with the code IPROTO_CHUNK (0x80). ``box.session.type()`` is useful for an :ref:`on_replace() <box_space-on_replace>` trigger on a replica -- the value will be 'applier' if and only if the trigger was activated because of a request that was done on the master. an optional argument to indicate what the session is, as taken from an earlier call to :ref:`box_session:sync() <box_session-sync>`. If it is omitted, the default is the current ``box.session.sync()`` value. existing trigger function which will be replaced by trigger-function function 3, box.session.user()=guest
function 3, user_name=admin
function 3, status = true, authorization succeeded
function 2, box.session.user()=guest
function 2, user_name=admin
function 1, box.session.user()=guest function log_connect ()
  local log = require('log')
  local m = 'Connection. user=' .. box.session.user() .. ' id=' .. box.session.id()
  log.info(m)
end

function log_disconnect ()
  local log = require('log')
  local m = 'Disconnection. user=' .. box.session.user() .. ' id=' .. box.session.id()
  log.info(m)
end

box.session.on_connect(log_connect)
box.session.on_disconnect(log_disconnect) function which will become the trigger function name of a function, or definition of a function. Additional parameters may be passed to ``box.session.su``, they will be interpreted as parameters of function-to-execute. name of a target user nil or function pointer number return rtype string tarantool> box.session.peer(box.session.id())
---
- 127.0.0.1:45129
...
tarantool> box.session.storage.random_memorandum = "Don't forget the eggs"
---
...
tarantool> box.session.storage.radius_of_mars = 3396
---
...
tarantool> m = ''
---
...
tarantool> for k, v in pairs(box.session.storage) do
         >   m = m .. k .. '='.. v .. ' '
         > end
---
...
tarantool> m
---
- 'radius_of_mars=3396 random_memorandum=Don''t forget the eggs. '
... tarantool> box.session.su('admin')
---
...
tarantool> box.session.uid(), box.session.euid()
---
- 1
- 1
...
tarantool> function f() return {box.session.uid(),box.session.euid()} end
---
...
tarantool> box.session.su('guest', f)
---
- - 1
  - 0
... tarantool> function f ()
         >   x = x + 1
         > end
tarantool> box.session.on_auth(f) tarantool> function f ()
         >   x = x + 1
         > end
tarantool> box.session.on_connect(f) tarantool> function f ()
         >   x = x + 1
         > end
tarantool> box.session.on_disconnect(f) tarantool> function f(a) return box.session.user() .. a end
---
...

tarantool> box.session.su('guest', f, '-xxx')
---
- guest-xxx
...

tarantool> box.session.su('guest',function(...) return ... end,1,2)
---
- 1
- 2
... the effective user ID of the :ref:`current user <authentication-users>`. the name of the :ref:`current user <authentication-users>` the type of connection or cause of action. the unique identifier (ID) for the current session. The result can be 0 or -1 meaning there is no session. the user ID of the :ref:`current user <authentication-users>`. the value of the :code:`sync` integer constant used in the `binary protocol <https://github.com/tarantool/tarantool/blob/1.10/src/box/iproto_constants.h>`_. This value becomes invalid when the session is disconnected. what to send {nil, error} or true: Project-Id-Version: Tarantool 1.10
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
 'applier' (наложение), если действие происходит по причине :ref:`репликации <replication>`, независимо от типа подключения; 'background' (в фоне), если действие происходит в :ref:`фоновом файбере <fiber-module>`, независимо от того, был ли Tarantool :ref:`запущен в фоновом режиме <cfg_basic-background>`. 'binary' (бинарное), если подключение было выполнено по бинарному протоколу, например, к объекту с помощью :ref:`box.cfg{listen=...} <cfg_basic-listen>`; 'console' (консоль), если подключение было выполнено по административной консоли, например, к объекту с помощью :ref:`console.listen <console-listen>`; 'repl' (репликация), если подключение было выполнено напрямую, например, при :ref:`использовании Tarantool'а в качестве клиента <admin-using_tarantool_as_a_client>`; **Пример №1** **Пример №2** **Пример 1** **Пример 2** **Пример** -- Создайте две оболочки. В оболочке №1 настройте сервер, а
-- в нем функцию, которая содержит box.session.push:
box.cfg{listen=3301}
box.schema.user.grant('guest','read,write,execute','universe')
x = 0
fiber = require('fiber')
function server_function() x=x+1; fiber.sleep(1); box.session.push(x); end

-- В оболочке №2 подключитесь к серверу в качестве клиента, который
-- поддерживает Lua (как второй Tarantool-сервер, работающий
-- в качестве клиента), и создайте таблицу, в которую мы будем получать сообщения:
net_box = require('net.box')
conn = net_box.connect(3301)
messages_from_server = {}

-- В оболочке №2 удаленно вызовите функцию и получите
-- СИНХРОННОЕ внеполосное сообщение:
conn:call('server_function', {},
          {is_async = false,
           on_push = table.insert,
           on_push_ctx = messages_from_server})
messages_from_server
-- Через секунду, во время которой происходит запрос fiber.sleep()
-- в server_function, результат в таблице
--  messages_from_server будет следующим: 1. Проверим:
-- tarantool> messages_from_server
-- ---
-- - - 1
-- ...
-- Хорошо. Это означает, что box.session.push(x) сработала,
-- поскольку мы знаем, что x был 1.

-- В оболочке №2 удаленно вызовите ту же самую функцию
-- для получения АСИНХРОННОГО внеполосного сообщения. При этом мы не можем
-- использовать параметры on_push и on_push_ctx, но можем использовать pairs():
future = conn:call('server_function', {}, {is_async = true})
messages = {}
keys = {}
for i, message in future:pairs() do
    table.insert(messages, message) table.insert(keys, i) end
messages
future:wait_result(1000)
for i, message in future:pairs() do
    table.insert(messages, message) table.insert(keys, i) end
messages
-- Задержки нет, поскольку conn:call не ждет
-- окончания вызова функции server_function. После первой итерации
-- цикла pairs(), видим, что таблица пуста. Это выглядит так:
-- tarantool> messages
-- ---
-- - - 2
--   - []
-- ...
-- Это нормально, поскольку сервер еще не вызвал
-- box.session.push(). При второй итерации
-- цикла pairs(), видим значение x во время
-- второго вызова box.session.push(). Так:
-- tarantool> messages
-- ---
-- - - 2
--   - &0 []
--   - 2
--   - *0
-- ...
-- Хорошо. Это означает, что сообщение было асинхронным, и
-- box.session.push() выполнила свою задачу. -- На первом экземпляре сервера, прослушивание на котором настроено на порт 3301
box.cfg{listen=3301}
function function1()
  print('function 1, box.session.user()='..box.session.user())
  end
function function2(user_name)
  print('function 2, box.session.user()='..box.session.user())
  print('function 2, user_name='..user_name)
  end
function function3(user_name, status)
  print('function 3, box.session.user()='..box.session.user())
  print('function 3, user_name='..user_name)
  if status == true then
    print('function 3, status = true, authorization succeeded')
    end
  end
box.session.on_auth(function1)
box.session.on_auth(function2)
box.session.on_auth(function3)
box.schema.user.passwd('admin') -- На втором экземпляре сервера, который подключается по порту 3301
console = require('console')
console.connect('admin:admin@localhost:3301') 1, если сессия есть; 0, если сессии нет. 2014-12-15 13:21:34.444 [11360] main/103/iproto I>
    Connection. user=guest id=3
2014-12-15 13:22:19.289 [11360] main/103/iproto I>
    Disconnection. user=guest id=3 :ref:`box.session.euid() <box_session-euid>` :ref:`box.session.exists() <box_session-exists>` :ref:`box.session.id() <box_session-id>` :ref:`box.session.on_auth() <box_session-on_auth>` :ref:`box.session.on_connect() <box_session-on_connect>` :ref:`box.session.on_disconnect() <box_session-on_disconnect>` :ref:`box.session.peer() <box_session-peer>` :ref:`box.session.push() <box_session-push>` :ref:`box.session.storage <box_session-storage>` :ref:`box.session.su() <box_session-su>` :ref:`box.session.sync() <box_session-sync>` :ref:`box.session.type() <box_session-type>` :ref:`box.session.uid() <box_session-uid>` :ref:`box.session.user() <box_session-user>` *Сессия* -- это объект, связанный с каждым подключением клиента. Lua-таблица с произвольными неупорядоченными именами и значениями по сессии, которая хранится до конца сессии. Например, эту таблицу можно использовать для хранения текущих задач при работе с `очередями сообщений в Tarantool'е <https://github.com/tarantool/queue>`_. После следующей серии запросов экземпляр Tarantool'а запишет сообщение с помощью модуля :ref:`log <log-module>` при подключении или отключении любого пользователя. Ниже приведен перечень всех функций и элементов модуля ``box.session``. Изменение :ref:`текущего пользователя <authentication-users>` Tarantool'а -- аналогично Unix-команде ``su``. Изменение текущего пользователя Проверка наличия сессии Определение триггера для подключения Определение триггера для отключения Определение исполняемого триггера после отключения клиента. Если функция с триггером вызывает ошибку, то ошибка записывается в журнал, в противном случае записей не будет. Триггер вызывается во время сессии клиента и может получить доступ к свойствам сессии, как :ref:`box.session.id() <box_session-id>`. Определение триггера, используемого во время :ref:`аутентификации <authentication-users>`. Определение исполняемого триггера во время создания новой сессии при подключению по консоли :ref:`console.connect <console-connect>`. Функция с триггером будет первой исполняемой функцией после создания сессии. Если триггер не выполняется и выдает ошибку, эта ошибка отправляется на клиент, и подключение разрывается. Определение триггера для аутентификации Подробная информация о характеристиках триггера находится в разделе :ref:`Триггеры <triggers-box_triggers>`. У каждого пользователя есть уникальное имя (узнать с помощью :ref:`box.session.user() <box_session-user>`) и уникальный идентификатор (узнать с помощью ``box.session.uid()``). Значения хранятся вместе в спейсе ``_user``. Создание внеполосного сообщения. Под внеполосным мы понимаем дополнительное сообщение, которое дополняет то, что отправляется в сети по обычным каналам. Хотя ``box.session. push()`` можно вызвать в любое время, на практике эта функция используется в сетях, настроенных с помощью :ref:`модуля net.box <net_box-module>`, и вызывается сервером (на "удаленной системе с базой данных", если использовать нашу терминологию для net.box), а у клиента есть возможность принимать такие сообщения. Получение типа соединения или повода к действию Получение идентификатора текущего действующего пользователя Получение идентификатора текущей сессии Получение идентификатора текущего пользователя Получение имени текущего пользователя Получение адреса хоста и порта подключенного узла Получение целочисленной константы sync Вот что может быть записано в файл журнала при обычной установке: Если триггер всегда приводит к ошибке, подключение к серверу для его переустановки может стать невозможным. Если не указан ни один параметр, ответом будет список существующих функций с триггером. Если указаны параметры (nil, old-trigger-function), старый триггер будет удален. Если результатом будет ошибка, то вернется ``nil`` вместе с объектом ошибки. Если результатом будет не ошибка, то вернется логическое значение ``true`` (правда). Если триггер не выполняется и выдает ошибку, эта ошибка отправляется на клиент, и подключение разрывается. Индекс Имя Или, если указана выполняемая функция (function-to-execute), временное изменение :ref:`текущего пользователя <authentication-users>` Tarantool'а во время выполнения функции – аналогично Unix-команде ``sudo``. Общие сведения Параметры Возможные ошибки: 'session.peer(): сессия отсутствует' Возможные возвращаемые значения: Отправка внеполосного сообщения Начиная с версии 1.10, функция с триггером вызывается сразу же после прерывания сессии, даже если сделанные запросы не были выполнены. Ситуация 1: когда клиент делает синхронный вызов со значением параметра ``{async=false}`` по умолчанию. Есть два необязательных дополнительных параметра: :samp:`on_push={function-name}` и :samp:`on_push_ctx={function-argument}`. Когда клиент получает внеполосное сообщение в сессии, он вызывает "имя-функции(аргумент-функции)". Например, с такими значениями параметров: ``{on_push=table.insert, on_push_ctx=messages}`` -- клиент произведет вставку полученных данных в таблицу под названием 'messages'. Осложненная ситуация 2: ``pairs()`` зависит от времени ожидания. Таким образом, есть необязательный аргумент -- время ожидания для итерации. Если время ожидания истечет до получения нового сообщения или окончательного ответа, вернется ошибка. Чтобы проверить наличие ошибки, можно использовать первый параметр в цикле (если цикл начинается с "for i, message in future:pairs()", то первым параметром в цикле будет i). Если это будет ``box.NULL``, то второй параметр (в нашем примере "message") -- это объект ошибки. Ситуация 2: когда клиент делает асинхронный вызов с измененным значением параметра ``{async=true}``. Здесь не разрешены ``on_push`` и ``on_push_ctx``, но сообщения можно увидеть путем вызова ``pairs()`` в цикле. Вложенный модуль `box.session` Таблица с именами и значениями по сессии В :ref:`бинарном протоколе <admin-security>` есть отдельный :ref:`пакет для аутентификации <box_protocol-authentication>`. В этом случае подключение и аутентификация считаются отдельными действиям. Функция :ref:`console.connect <console-connect>` включает в себя проверку аутентификации всех пользователей, кроме 'guest'. Вызов функции ``on_auth`` с триггером происходит после триггера ``on_connect`` только в том случае, если подключение было успешным. Вложенный модуль ``box.session`` позволяет делать запросы состояния сессии, вносить записи во временную Lua-таблицу по отдельной сессии, отправлять экстренные сообщения и настраивать триггеры, которые сработают в начале или окончании сессии. Вызов функции ``on_auth`` с триггером происходит в следующих обстоятельствах: Задача клиента заключается в том, чтобы проверять наличие таких сообщений после отправки чего-либо на сервер. Основные клиентские методы -- :ref:`conn:call <net_box-call>`, :ref:`conn:eval <net_box-eval>`, :ref:`conn:select <conn-select>`, :ref:`conn:insert <conn-insert>`, :ref:`conn:replace <conn-replace>`, :ref:`conn:update <conn-update>`, :ref:`conn:upsert <conn-upsert>`, :ref:`delete <conn-delete>` -- могут привести к отправке такого сообщения сервером. Первый случай: если вызов ``box.session.euid()`` выполняется в рамках функции, вызываемой по :ref:`box.session.su(user-name, function-to-execute) <box_session-su>` -- в таком случае ``box.session.euid()`` вернет измененный идентификатор пользователя (пользователь, который указан в параметре ``user-name`` функции ``su``), но ``box.session.uid()`` вернет идентификатор оригинального пользователя (пользователя, который вызывает функцию ``su``). Первый экземпляр сервера настроен на прослушивание по порту 3301; имя пользователя по умолчанию -- 'admin'. Есть три триггера ``on_auth``: В первом триггере есть функция без аргументов, которая только смотрит на ``box.session.user()``. Адрес хоста и порт подключенного узла, например "127.0.0.1:55457". Если существует сессия, но отсутствует подключение к отдельному экземпляру, вернется null. Команда выполняется на экземпляре сервера,  поэтому "локальное имя" -- это хост и порт экземпляра сервера, а "имя узла" -- это хост и порт клиента. Теперь результат выглядит следующим образом: Второй случай: если вызов ``box.session.euid()`` выполняется в рамках функции по :ref:`box.schema.func.create(function-name, {setuid= true}) <box_schema-func_create>`, и используется бинарный протокол -- в таком случае ``box.session.euid()`` вернет идентификатор пользователя, который создал функцию "function-name", а ``box.session.uid()`` вернет идентификатор пользователя, который вызывает эту функцию "function-name". Второй экземпляр сервера подключится по :ref:`console.connect <console-connect>`, а затем отобразит переменные, определенные функциями с триггером. Во втором триггере есть функция с аргументом ``user_name``, которая может смотреть на ``box.session.user()`` и ``user_name``. Единственная задача сервера -- вызвать ``box.session.push()``, поскольку нет автоматического механизма, который показал бы, что сообщение получено. В третьем триггере есть функция с аргументом ``user_name`` и аргументом ``status``, которая может смотреть на ``box.session.user()`` и ``user_name``, и``status``. Функция возвращает ошибку, если сессия была прервана. Данная функция сработает только в том случае, если есть подключенная программа, то есть если было выполнено подключение к отдельному экземпляру Tarantool'а. Более сложный пример с двумя экземплярами сервера. Аналогично :ref:`box.session.uid() <box_session-uid>`, за исключением двух случаев: В отличие от других типов триггеров, вызов функций с триггером ``on_auth`` происходит **до** события. Таким образом, функция с таким триггером, как :code:`function auth_function () v = box.session.user(); end`, определит :code:`v` как "guest", то есть имя пользователя до проведения аутентификации. Чтобы получить имя пользователя **после** проведения аутентификации, используйте специальный синтаксис: :code:`function auth_function (user_name) v = user_name; end` Использование Если возвращается ``true``, сообщение отправлено в буфер сети в виде :ref:`пакета <box_protocol-iproto_protocol>` с кодом IPROTO_CHUNK (0x80). ``box.session.type()`` используется для триггера при замене :ref:`on_replace() <box_space-on_replace>` на реплике -- значение будет 'applier' только в том случае, если триггер был активирован по причине запроса, выполненного на мастере. необязательный аргумент, который показывает информацию о сессии, полученную из предшествующего вызова :ref:`box_session:sync() <box_session-sync>`. Если не указать, по умолчанию используется текущее значение ``box.session.sync()``. существующая функция с триггером, которую заменит новая function 3, box.session.user()=guest
function 3, user_name=admin
function 3, status = true, authorization succeeded
function 2, box.session.user()=guest
function 2, user_name=admin
function 1, box.session.user()=guest function log_connect ()
  local log = require('log')
  local m = 'Connection. user=' .. box.session.user() .. ' id=' .. box.session.id()
  log.info(m)
end

function log_disconnect ()
  local log = require('log')
  local m = 'Disconnection. user=' .. box.session.user() .. ' id=' .. box.session.id()
  log.info(m)
end

box.session.on_connect(log_connect)
box.session.on_disconnect(log_disconnect) функция, в которой будет триггер имя функции или определение функции. Дополнительные параметры могут передаваться в ``box.session.su``, они будут интерпретироваться как параметры выполняемой функции. целевое имя пользователя nil или указатель функции число возвращается тип возвращаемого значения string (строка) tarantool> box.session.peer(box.session.id())
---
- 127.0.0.1:45129
...
tarantool> box.session.storage.random_memorandum = "Don't forget the eggs"
---
...
tarantool> box.session.storage.radius_of_mars = 3396
---
...
tarantool> m = ''
---
...
tarantool> for k, v in pairs(box.session.storage) do
         >   m = m .. k .. '='.. v .. ' '
         > end
---
...
tarantool> m
---
- 'radius_of_mars=3396 random_memorandum=Don''t forget the eggs. '
... tarantool> box.session.su('admin')
---
...
tarantool> box.session.uid(), box.session.euid()
---
- 1
- 1
...
tarantool> function f() return {box.session.uid(),box.session.euid()} end
---
...
tarantool> box.session.su('guest', f)
---
- - 1
  - 0
... tarantool> function f ()
         >   x = x + 1
         > end
tarantool> box.session.on_auth(f) tarantool> function f ()
         >   x = x + 1
         > end
tarantool> box.session.on_connect(f) tarantool> function f ()
         >   x = x + 1
         > end
tarantool> box.session.on_disconnect(f) tarantool> function f(a) return box.session.user() .. a end
---
...

tarantool> box.session.su('guest', f, '-xxx')
---
- guest-xxx
...

tarantool> box.session.su('guest',function(...) return ... end,1,2)
---
- 1
- 2
... рабочий ID :ref:`текущего пользователя <authentication-users>`. имя :ref:`текущего пользователя <authentication-users>` тип соединения или повод к действию. уникальный идентификатор (ID) для текущей сессии. Результатом может быть 0 или -1, что означает, что сессии нет. ID :ref:`текущего пользователя <authentication-users>`. значение целочисленной константы :code:`sync`, используемой в `бинарном протоколе <https://github.com/tarantool/tarantool/blob/1.10/src/box/iproto_constants.h>`_. Это значение будет недействительным после отключения сессии. что отправляется {nil, ошибка} или true: 