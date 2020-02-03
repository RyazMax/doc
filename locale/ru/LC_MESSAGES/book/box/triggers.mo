��          �               �     �  n   �  W     5   p  }   �  W   $  m   |  }   �  Z   h  0   �  D   �  �  9  .     �   G     �  X   �  �   +    �  �   �	  �   �
  �  a  �     =  �  �  �     �    �  _   �  9   %  �   _  �   �  u   v  �   �  �   �  R   �  �   �    s  B   �    �     �  ~   �  >  x  �  �    k  �  �   �   "  8  �$  =  "&   **Example** **Triggers**, also known as **callbacks**, are functions which the server executes when certain events happen. :ref:`box.on_commit() <box-on_commit>` or :ref:`box.on_rollback() <box-on_rollback>` or :ref:`box.session.on_auth() <box_session-on_auth>` or :ref:`box.session.on_connect() <box_session-on_connect>` or :ref:`box.session.on_disconnect() <box_session-on_disconnect>` or :ref:`connection triggers <net_box-on_connect>`, which are for ``net.box`` connections, :ref:`net.box.on_connect() <net_box-on_connect>` or :ref:`net.box.on_disconnect() <net_box-on_disconnect>` or :ref:`session triggers <box_session-on_connect>`, which are executed when a session begins or ends and during authentication, :ref:`transaction triggers <box-on_commit>`, which are executed during commit or rollback. All triggers have the following characteristics: Here we log connect and disconnect events into Tarantool server log. The "on_event()" functions all have parameters which are function pointers, and they all return function pointers. Remember that a Lua function definition such as "function f() x = x + 1 end" is the same as "f = function () x = x + 1 end" -- in both cases ``f`` gets a function pointer. And "trigger = box.session.on_connect(f)" is the same as "trigger = box.session.on_connect(function () x = x + 1 end)" -- in both cases ``trigger`` gets the function pointer which was passed. There are four types of triggers in Tarantool: There can be multiple triggers for one event. In this case, triggers are executed in the reverse order that they were defined in. Triggers Triggers are defined only by the :ref:`'admin' user <authentication-owners_privileges>`. Triggers are replaceable. The request to "redefine a trigger" implies passing a new trigger function and an old trigger function to one of the "on_event()" functions. Triggers are stored in the Tarantool instance's memory, not in the database. Therefore triggers disappear when the instance is shut down. To make them permanent, put function definitions and trigger settings into Tarantool's :ref:`initialization script <index-init_label>`. Triggers associate a function with an event. The request to "define a trigger" implies passing the trigger’s function to one of the "on_event()" functions: Triggers have low overhead. If a trigger is not defined, then the overhead is minimal: merely a pointer dereference and check. If a trigger is defined, then its overhead is equivalent to the overhead of calling a function. Triggers must work within the event context. However, effects are undefined if a function contains requests which normally could not occur immediately after the event, but only before the return from the event. For example, putting `os.exit() <http://www.lua.org/manual/5.1/manual.html#pdf-os.exit>`_ or :ref:`box.rollback() <box-rollback>` in a trigger function would be bringing in requests outside the event context. You can call any "on_event()" function with no arguments to get a list of its triggers. For example, use ``box.session.on_connect()`` to return a table of all connect-trigger functions. log = require('log')

function on_connect_impl()
  log.info("connected "..box.session.peer()..", sid "..box.session.id())
end

function on_disconnect_impl()
  log.info("disconnected, sid "..box.session.id())
end

function on_auth_impl(user)
  log.info("authenticated sid "..box.session.id().." as "..user)
end

function on_connect() pcall(on_connect_impl) end
function on_disconnect() pcall(on_disconnect_impl) end
function on_auth(user) pcall(on_auth_impl, user) end

box.session.on_connect(on_connect)
box.session.on_disconnect(on_disconnect)
box.session.on_auth(on_auth) Project-Id-Version: Tarantool 1.10
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
 **Пример** **Триггеры**, которые также называют **обратными вызовами**, представляют собой функции, которые выполняет сервер при наступлении определенных событий. :ref:`box.on_commit() <box-on_commit>` или :ref:`box.on_rollback() <box-on_rollback>` или :ref:`box.session.on_auth() <box_session-on_auth>` или :ref:`box.session.on_connect() <box_session-on_connect>` или :ref:`box.session.on_disconnect() <box_session-on_disconnect>` или :ref:`connection-триггеры <box_session-on_connect>`, которые относятся к соединениям через ``net.box``, :ref:`net.box.on_connect() <net_box-on_connect>` или :ref:`net.box.on_disconnect() <net_box-on_disconnect>` или :ref:`session-триггеры <box_session-on_connect>`, которые выполняются, когда начинается или заканчивается сессия, а также во время аутентификации, :ref:`триггеры для обработки транзакций <box-on_commit>`, которые выполняются во время коммита или отката. У всех триггеров есть следующие особенности: Здесь мы записываем события подключения и отключения в журнал на сервере Tarantool'а. Во всех функциях обработки событий "on_event()" есть параметры, которые представляют собой указатели функции, и все они возвращают указатели функции. Следует запомнить, что определение Lua-функции, например, "function f() x = x + 1 end" совпадает с "f = function () x = x + 1 end" -- в обоих случаях ``f`` получит указатель функции. А "trigger = box.session.on_connect(f)" -- это то же самое, что "trigger = box.session.on_connect(function () x = x + 1 end)" -- в обоих случаях ``trigger`` получит переданный указатель функции. В Tarantool'е есть четыре типа триггеров: Для одного события можно определить несколько триггеров. В таком случае триггеры выполняются в обратном порядке относительно того, как их определили. Триггеры Только :ref:`пользователь 'admin' <authentication-owners_privileges>` определяет триггеры. Триггеры можно заменять. Запрос на "замену триггера" подразумевает передачу новой триггерной функции и старой триггерной функции в одну из функций обработки событий "on_event()". Триггеры хранятся в памяти экземпляра Tarantool'а, а не в базе данных. Поэтому триггеры пропадают, когда экземпляр отключают. Чтобы сохранить их, поместите определения функции и настройки триггера в :ref:`скрипт инициализации <index-init_label>` Tarantool'а. Триггеры связывают функцию с событием. Запрос "определить триггер" подразумевает передачу функции с триггером в одну из функций обработки событий "on_event()": Триггеры не приводят к высокой затрате ресурсов. Если триггер не определен, то затрата ресурсов минимальна: только разыменование указателя и проверка. Если триггер определен, то затрата ресурсов аналогична вызову функции. Триггеры должны работать в контексте события. Однако результат не определен, если функция содержит запросы, которые при нормальных условиях не могут быть выполнены непосредственно после события, а только после возврата из события. Например, если указать `os.exit() <http://www.lua.org/manual/5.1/manual.html#pdf-os.exit>`_ или :ref:`box.rollback() <box-rollback>` в триггерной функции, запросы не будут выполняться в контексте события. Если вызвать любую из "on_event()" функций без аргументов, то она вернет список соответствующих триггеров. Например, ``box.session.on_connect()`` вернет таблицу со всеми connect-trigger функциями. log = require('log')

function on_connect_impl()
  log.info("connected "..box.session.peer()..", sid "..box.session.id())
end

function on_disconnect_impl()
  log.info("disconnected, sid "..box.session.id())
end

function on_auth_impl(user)
  log.info("authenticated sid "..box.session.id().." as "..user)
end

function on_connect() pcall(on_connect_impl) end
function on_disconnect() pcall(on_disconnect_impl) end
function on_auth(user) pcall(on_auth_impl, user) end

box.session.on_connect(on_connect)
box.session.on_disconnect(on_disconnect)
box.session.on_auth(on_auth) 