��    1      �              ,  5  -  &   c     �     �     �  #   �  �   �     �  �   �  M   w  $   �     �     	  G   !	  v   i	  W   �	  �   8
  F     9   T  6   �  Y   �  A        a  8   }  >   �  ^   �  O   T    �  \   �  =     �   D  !  �  �     e   �       �   7  �   �  A   c     �  P   �  X     G   m  D   �  +   �    &     7  _  �  ,    �  D  5  �  &         D      d      }   #   �   �   �      T!  �   p!  Q   1"  2   �"     �"     �"  K   �"  �   9#  �   $  |  �$  �   &&  �   �&  �   u'    (     #)  L   �)  i   �)  `   Z*  �   �*  t   {+  �  �+  �   }-  T   .  Y  d.  y  �/  E  83  �   ~4  ,   H5  �   u5  8  S6     �7  4   8  �   A8  �   �8  �   �9  �   �:  w   +;  �  �;  �   �>  _  @?  ,  �@   $ cd ~/tarantool_test
$ tarantool my_app.lua
2017-04-06 10:42:15.762 [54085] main/101/my_app.lua C> version 1.7.3-489-gd86e36d5b
2017-04-06 10:42:15.763 [54085] main/101/my_app.lua C> log level 5
2017-04-06 10:42:15.764 [54085] main/101/my_app.lua I> mapping 268435456 bytes for tuple arena...
2017-04-06 10:42:15.774 [54085] iproto/101/main I> binary: bound to [::]:3301
2017-04-06 10:42:15.774 [54085] main/101/my_app.lua I> initializing an empty data directory
2017-04-06 10:42:15.789 [54085] snapshot/101/main I> saving snapshot `./00000000000000000000.snap.inprogress'
2017-04-06 10:42:15.790 [54085] snapshot/101/main I> done
2017-04-06 10:42:15.791 [54085] main/101/my_app.lua I> vinyl checkpoint done
2017-04-06 10:42:15.791 [54085] main/101/my_app.lua I> ready to accept requests
insert 1
insert 2
insert 3
<...> $ less ~/tarantool_test/log/my_app.log $ ls -l ~/tarantool_test/my_app $ mkdir ~/tarantool_test $ rm -R tarantool_test $ systemctl enable tarantool@my_app $ systemctl start tarantool@my_app
$ ps axuf|grep exampl[e]
taranto+  5350  1.3  0.3 1448872 7736 ?        Ssl  20:05   0:28 tarantool my_app.lua <running> $ tarantoolctl check my_app $ tarantoolctl enter my_app
tarantool> box.cfg{}
tarantool> console = require('console')
tarantool> console.connect('localhost:3301')
tarantool> box.space.tester:select({0}, {iterator = 'GE'}) $ tarantoolctl restart my_app
$ # - OR -
$ systemctl restart tarantool@my_app $ tarantoolctl start <instance_name> $ tarantoolctl start my_app $ tarantoolctl stop my_app $ tarantoolctl stop my_app
$ # - OR -
$ systemctl stop tarantool@my_app ... and set default ``tarantoolctl`` configuration in ``$HOME/.config/tarantool/tarantool``. Let the file contents be: ... this actually calls ``tarantoolctl`` like in case of ``tarantoolctl start my_app``. Create a so-called "instance control file". This is a Unix socket with Lua console attached to it. This file is used later by ``tarantoolctl`` to query the instance state, send commands to the instance and so on. Expect to see messages indicating that the instance has started. Then: Expect to see several tuples that ``my_app`` has created. Expect to see the .snap file and the .xlog file. Then: Expect to see the contents of ``my_app``‘s log, including error messages, if any. Then: Finally, use Lua ``dofile`` command to execute the instance file. Finally, we make a cleanup. First, we create a sandbox directory on the user's path: Here is what ``tarantoolctl`` does when you issue the command: If you start an instance using ``systemd`` tools, like this (the instance name is ``my_app``): Let’s verify our instance file by starting it without ``tarantoolctl`` first: Look up the instance file in the instance directory, for example ``/etc/tarantool/instances.enabled``. To build the instance file path, ``tarantoolctl`` takes the instance name, prepends the instance directory and appends ".lua" extension to the instance file. Next, we create the instance file ``~/tarantool_test/my_app.lua``. Let the file contents be: Now we tell ``tarantoolctl`` to start the Tarantool instance: Omit ``username`` parameter. ``tarantoolctl`` normally doesn't have permissions to switch current user when invoked by a local user. The instance will be running under 'admin'. Override :ref:`box.cfg{} <box_introspection-box_cfg>` function to pre-process its parameters and ensure that instance paths are pointing to the paths defined in the ``tarantoolctl`` configuration file. For example, if the configuration file specifies that instance work directory must be in ``/var/tarantool``, then the new implementation of ``box.cfg{}`` ensures that :ref:`work_dir <cfg_basic-work_dir>` parameter in ``box.cfg{}`` is set to ``/var/tarantool/<instance_name>``, regardless of what the path is set to in the instance file itself. Read and parse its own configuration file. This file contains ``tarantoolctl`` defaults, like the path to the directory where instances should be searched for. Read and parse the command line arguments. The last argument, in our case, contains an instance name. Running Tarantool locally Set the TARANTOOLCTL environment variable to 'true'. This allows the user to know that the instance was started by ``tarantoolctl``. Sometimes you may need to run a Tarantool instance locally, e.g. for test purposes. Let's configure a local instance, then start and monitor it with ``tarantoolctl``. Specify a full path to the user's home directory instead of "~/". Starting/stopping an instance Stop now. A polite way to stop ``my_app`` is with ``tarantoolctl``, thus we say: To check the instance file for syntax errors prior to starting ``my_app`` instance, say: To enable ``my_app`` instance for auto-load during system startup, say: To restart (i.e. stop and start) a running ``my_app`` instance, say: To stop a running ``my_app`` instance, say: When ``tarantool`` is invoked by root, it looks for a configuration file in ``/etc/default/tarantool``. When ``tarantool`` is invoked by a local (non-root) user, it looks for a configuration file first in the current directory (``$PWD/.tarantoolctl``), and then in the current user's home directory (``$HOME/.config/tarantool/tarantool``). If no configuration file is found there, or in the ``/usr/local/etc/default/tarantool`` file, then ``tarantoolctl`` falls back to :ref:`built-in defaults <admin-tarantoolctl_config_file>`. While a Lua application is executed by Tarantool, an instance file is executed by ``tarantoolctl`` which is a Tarantool script. box.cfg{listen = 3301}
box.schema.user.passwd('Gx5!')
box.schema.user.grant('guest','read,write,execute','universe')
fiber = require('fiber')
box.schema.space.create('tester')
box.space.tester:create_index('primary',{})
i = 0
while 0 == 0 do
    fiber.sleep(5)
    i = i + 1
    print('insert ' .. i)
    box.space.tester:insert{i, 'my_app tuple'}
end default_cfg = {
    pid_file  = "/home/user/tarantool_test/my_app.pid",
    wal_dir   = "/home/user/tarantool_test",
    snap_dir  = "/home/user/tarantool_test",
    vinyl_dir = "/home/user/tarantool_test",
    log       = "/home/user/tarantool_test/log",
}
instance_dir = "/home/user/tarantool_test" Project-Id-Version: Tarantool 1.10
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
 $ cd ~/tarantool_test
$ tarantool my_app.lua
2017-04-06 10:42:15.762 [54085] main/101/my_app.lua C> version 1.7.3-489-gd86e36d5b
2017-04-06 10:42:15.763 [54085] main/101/my_app.lua C> log level 5
2017-04-06 10:42:15.764 [54085] main/101/my_app.lua I> mapping 268435456 bytes for tuple arena...
2017-04-06 10:42:15.774 [54085] iproto/101/main I> binary: bound to [::]:3301
2017-04-06 10:42:15.774 [54085] main/101/my_app.lua I> initializing an empty data directory
2017-04-06 10:42:15.789 [54085] snapshot/101/main I> saving snapshot `./00000000000000000000.snap.inprogress'
2017-04-06 10:42:15.790 [54085] snapshot/101/main I> done
2017-04-06 10:42:15.791 [54085] main/101/my_app.lua I> vinyl checkpoint done
2017-04-06 10:42:15.791 [54085] main/101/my_app.lua I> ready to accept requests
insert 1
insert 2
insert 3
<...> $ less ~/tarantool_test/log/my_app.log $ ls -l ~/tarantool_test/my_app $ mkdir ~/tarantool_test $ rm -R tarantool_test $ systemctl enable tarantool@my_app $ systemctl start tarantool@my_app
$ ps axuf|grep exampl[e]
taranto+  5350  1.3  0.3 1448872 7736 ?        Ssl  20:05   0:28 tarantool my_app.lua <running> $ tarantoolctl check my_app $ tarantoolctl enter my_app
tarantool> box.cfg{}
tarantool> console = require('console')
tarantool> console.connect('localhost:3301')
tarantool> box.space.tester:select({0}, {iterator = 'GE'}) $ tarantoolctl restart my_app
$ # - ИЛИ -
$ systemctl restart tarantool@my_app $ tarantoolctl start <имя_экземпляра> $ tarantoolctl start my_app $ tarantoolctl stop my_app $ tarantoolctl stop my_app
$ # - ИЛИ -
$ systemctl stop tarantool@my_app ...и поместим конфигурационный файл с параметрами ``tarantoolctl`` по умолчанию в ``$HOME/.config/tarantool/tarantool``. Содержимое файла будет таким: ...на самом деле вызывается ``tarantoolctl`` -- так же, как и в случае ``tarantoolctl start my_app``. Создает так называемый "файл для управления экземпляром". Это Unix-сокет с прикрепленной к нему Lua-консолью. В дальнейшем ``tarantoolctl`` использует этот файл для получения состояния экземпляра,  отправки команд и т.д. В консоли должны появиться сообщения о том, что экземпляр запущен. Затем выполним следующую команду: В консоли должны появиться несколько кортежей, которые создало приложение ``my_app``. В консоли должны появиться .snap-файл и .xlog-файл. Затем выполним следующую команду: В консоли должно отобразиться содержимое файла журнала для приложения ``my_app``, в том числе сообщения об ошибках, если они были. Затем выполним серию команд: Наконец, использует Lua-команду ``dofile`` для выполнения файла экземпляра. Последний шаг -- удаление тестовых данных. Сперва создадим директорию-песочницу по следующему пути: Вот что делает ``tarantoolctl`` при вводе следующей команды: При запуске экземпляра с помощью инструментария ``systemd`` указанным ниже способом (имя экземпляра -- ``my_app``): Проверим наш файл экземпляра, сперва запустив его без ``tarantoolctl``: Ищет файл экземпляра в директории, где располагаются экземпляры, например, в ``/etc/tarantool/instances.enabled``. ``tarantoolctl`` строит путь до файла экземпляра следующим образом: "путь до директории с экземплярами" + "имя экземпляра" + ".lua". Далее создадим файл экземпляра ``~/tarantool_test/my_app.lua``. Содержимое файла будет таким: Запустим экземпляр Tarantool'а с помощью ``tarantoolctl``: Опустите параметр ``username``. Обычно, когда запуск производит локальный  пользователь, у ``tarantoolctl`` нет разрешения на смену текущего пользователя. Экземпляр будет работать с пользователем 'admin'. Переопределяет функцию :ref:`box.cfg{} <box_introspection-box_cfg>`, чтобы предобработать ее параметры и сделать так, чтобы пути к экземплярам  указывали на пути, прописанные в конфигурационном файле ``tarantoolctl``. Например, если в конфигурационном файле указано, что рабочей директорией экземпляра является ``/var/tarantool``, то новая реализация ``box.cfg{}`` сделает так, чтобы параметр :ref:`work_dir <cfg_basic-work_dir>` в ``box.cfg{}`` имел значение ``/var/tarantool/<имя_экземпляра>``, независимо от того, какой путь указан в самом файле экземпляра. Считывает и разбирает собственный конфигурационный файл. Этот файл содержит параметры ``tarantoolctl`` по умолчанию -- такие как путь до директории, в которой располагаются экземпляры. Считывает и разбирает аргументы командной строки. В нашем случае последний аргумент содержит имя экземпляра. Локальный запуск Tarantool'а Задает значение переменной окружения TARANTOOLCTL = 'true'. Это позволит пользователю понять, что экземпляр был запущен ``tarantoolctl``. Иногда бывает необходимо запустить Tarantool локально -- например, для тестирования. Давайте настроим локальный экземпляр, запустим его и будем мониторить с помощью ``tarantoolctl``. Указывайте полный путь к домашней директории пользователя вместо "~/". Запуск/остановка экземпляра Теперь остановим приложение ``my_app``. Корректный способ остановки -- это использовать``tarantoolctl``: Для проверки файла экземпляра на наличие синтаксических ошибок перед запуском экземпляра ``my_app`` используйте команду: Для включения автоматической загрузки экземпляра ``my_app`` при запуске всей системы используйте команду: Для перезапуска (т.е. остановки и запуска) работающего экземпляра ``my_app`` используйте команду: Для остановки работающего экземпляра ``my_app`` используйте команду: Когда ``tarantoolctl`` вызывается с root-правами, он ищет конфигурационный файл в ``/etc/default/tarantool``. Если вызов ``tarantool`` производит локальный пользователь, сначала он ищет конфигурационный файл в текущей директории (``$PWD/.tarantoolctl``), а затем в домашней директории текущего пользователя (``$HOME/.config/tarantool/tarantool``). Если конфигурационный файл не найден, ``tarantoolctl`` принимает :ref:`встроенные параметры по умолчанию <admin-tarantoolctl_config_file>`. Lua-приложение выполняется Tarantool'ом, тогда как файл экземпляра выполняется Tarantool-скриптом ``tarantoolctl``. box.cfg{listen = 3301}
box.schema.user.passwd('Gx5!')
box.schema.user.grant('guest','read,write,execute','universe')
fiber = require('fiber')
box.schema.space.create('tester')
box.space.tester:create_index('primary',{})
i = 0
while 0 == 0 do
    fiber.sleep(5)
    i = i + 1
    print('insert ' .. i)
    box.space.tester:insert{i, 'my_app tuple'}
end default_cfg = {
    pid_file  = "/home/user/tarantool_test/my_app.pid",
    wal_dir   = "/home/user/tarantool_test",
    snap_dir  = "/home/user/tarantool_test",
    vinyl_dir = "/home/user/tarantool_test",
    log       = "/home/user/tarantool_test/log",
}
instance_dir = "/home/user/tarantool_test" 