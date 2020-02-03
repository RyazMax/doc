��          �               <  �  =  F   3  �   z  =   :  :   x  $   �  P   �  �   )  %   �                +  T   E  6   �     �  F   �  �  5  �  '
  �  �  F   �  =  �  B   
  C   M  6   �  �   �  $  �  H   �  %   �  -     .   F  {   u  L   �  1   >  �   p  �  
   #!/usr/bin/env tarantool
--
-- hot code reload example
--

box.cfg({listen = 3302})

-- ATTENTION: unload it all properly!
local app = package.loaded['app']
if app ~= nil then
  -- stop the old application version
  app.stop()
  -- unload the application
  package.loaded['app'] = nil
  -- unload all dependencies
  package.loaded['somedep'] = nil
end

-- load the application
log.info('require app')
app = require('app')

-- start the application
app.start({some app options controlled by sysadmins}) $ tarantoolctl eval my_app /etc/tarantool/instances.enabled/my_app.lua After you compiled a new version of a C module (``*.so`` shared library), call :ref:`box.schema.func.reload('module-name') <box_schema-func_reload>` from your Lua script to reload the module. For example, ``/etc/tarantool/instances.enabled/my_app.lua``: For example, a module in ``/usr/share/tarantool/app.lua``: For example, using ``tarantoolctl``: Here's an example that illustrates the most typical case -- "update and reload". In this example, we use recommended :ref:`administration practices <admin>` based on :ref:`instance files <admin-instance_file>` and :ref:`tarantoolctl <tarantoolctl>` utility. Manually reload the application file. Reloading a module Reloading a module in C Reloading a module in Lua The important thing here is to properly unload the application and its dependencies. Update the :ref:`instance file <admin-instance_file>`. Update the application file. You can reload any Tarantool application or module with zero downtime. local function start()
  -- initial version
  box.once("myapp:v1.0", function()
    box.schema.space.create("somedata")
    box.space.somedata:create_index("primary")
    ...
  end)

  -- migration code from 1.0 to 1.1
  box.once("myapp:v1.1", function()
    box.space.somedata.index.primary:alter(...)
    ...
  end)

  -- migration code from 1.1 to 1.2
  box.once("myapp:v1.2", function()
    box.space.somedata.index.primary:alter(...)
    box.space.somedata:insert(...)
    ...
  end)
end

-- start some background fibers if you need

local function stop()
  -- stop all background fibers and clean up resources
end

local function api_for_call(xxx)
  -- do some business
end

return {
  start = start,
  stop = stop,
  api_for_call = api_for_call
} Project-Id-Version: Tarantool 1.10
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
 #!/usr/bin/env tarantool
--
-- пример горячей перезагрузки кода
--

box.cfg({listen = 3302})

-- ВНИМАНИЕ: правильно выполните разгрузку!
local app = package.loaded['app']
if app ~= nil then
  -- остановите старую версию приложения
  app.stop()
  -- разгрузите приложение
  package.loaded['app'] = nil
  -- разгрузите все зависимости
  package.loaded['somedep'] = nil
end

-- загрузите приложение
log.info('require app')
app = require('app')

-- запустите приложение
app.start({some app options controlled by sysadmins}) $ tarantoolctl eval my_app /etc/tarantool/instances.enabled/my_app.lua После компиляции новой версии модуля на C (библиотека общего пользования ``*.so``),  вызовите функцию :ref:`box.schema.func.reload('module-name') <box_schema-func_reload>` из Lua-скрипта для перезагрузки модуля. Например, ``/etc/tarantool/instances.enabled/my_app.lua``: Например, модуль в ``/usr/share/tarantool/app.lua``: Например, используя ``tarantoolctl``: Ниже представлен пример, который иллюстрирует наиболее типичный случай -- "обновление и перезагрузка". В этом примере используются рекомендованные :ref:`методики администрирования <admin>` на основании :ref:`файлов экземпляров <admin-instance_file>` и утилиты :ref:`tarantoolctl <tarantoolctl>`. Вручную перезагрузите файл приложения. Перезагрузка модуля Перезагрузка модуля на С Перезагрузка модуля на Lua Самое главное -- правильно разгрузить приложение и его зависимости. Обновить :ref:`файл экземпляра <admin-instance_file>`. Обновите файлы приложения. Любое приложение или модуль Tarantool'а можно перезагрузить с нулевым временем простоя. local function start()
  -- начальная версия
  box.once("myapp:v1.0", function()
    box.schema.space.create("somedata")
    box.space.somedata:create_index("primary")
    ...
  end)

  -- код миграции с 1.0 на 1.1
  box.once("myapp:v1.1", function()
    box.space.somedata.index.primary:alter(...)
    ...
  end)

  -- код миграции с 1.1 на 1.2
  box.once("myapp:v1.2", function()
    box.space.somedata.index.primary:alter(...)
    box.space.somedata:insert(...)
    ...
  end)
end

-- запустить файберы в фоновом режиме, если необходимо

local function stop()
  -- остановить все файберы, работающие в фоновом режиме, и очистить ресурсы
end

local function api_for_call(xxx)
  -- сделать что-то
end

return {
  start = start,
  stop = stop,
  api_for_call = api_for_call
} 