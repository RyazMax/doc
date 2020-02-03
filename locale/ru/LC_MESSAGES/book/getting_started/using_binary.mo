��    C      4              L  �   M     
  �     4   �     �  �   �  +   �  I   �       D   %  C   j     �  J  �  �  	  =   �
  @   �
  U     <   j    �  S   �     �  %     /   6  >   f  �   �  #   f     �  �   �  ?   o  (   �  @   �  �     x   �  ?   Z  7   �  2   �  �        �  \     3   d  4   �  e   �  (   3  �   \  F   �  *   &     Q     c     z  5   �  r   �     =  *   I  T   t  *   �  
   �  !   �  K   !  0   m    �  S   �  h   �  q   a  �   �  }   �       �    X  �        �   !   4   �      �   �   !  2   �!  �   �!  >   �"  b   �"  _   7#  &   �#  �  �#  �  �%  g   M(  �   �(  �   P)     �)  �  c*  �   Y,  E   �,  g   --  `   �-  �   �-  �  �.  3   -0  0   a0  �  �0  �   -2  j   �2  [   43  �  �3  �   5  �   6  �   �6  ^   &7  �  �7  2   9  �   G9  ~   :  �   �:    ;  c   +<  �   �<  n   W=  A   �=  /   >  :   8>  Z   s>  V   �>  �   %?     !@  1   -@  w   _@  *   �@  
   A  !   A  K   /A  0   {A    �A  S   �D  h   E  q   oE  �   �E  }   �F     G   $ # if you downloaded a binary with apt-get or yum, say this:
$ /usr/bin/tarantool
$ # if you downloaded and untarred a binary tarball to ~/tarantool, say this:
$ ~/tarantool/bin/tarantool $ kill 6851 $ lsof -i :3301
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
tarantool 6851 root   12u  IPv4  40827      0t0  TCP *:3301 (LISTEN) $ mkdir ~/tarantool_sandbox
$ cd ~/tarantool_sandbox $ tarantoolctl connect '3301' $ tarantoolctl connect 3301
/usr/local/bin/tarantoolctl: connected to localhost:3301
localhost:3301> box.space.tester:select{2}
---
- - [2, 'Scorpions', 2015]
... :ref:`tarantoolctl <tarantoolctl>` utility. Check if the default port the database instance will listen to is vacant. Connecting remotely Create the first :ref:`index <index-box_index>` (named ``primary``): Create the first :ref:`space <index-box_space>` (named ``tester``): Creating a database Depending on the release, during installation Tarantool may start a demonstrative global ``example.lua`` instance that listens to the ``3301`` port by default. The ``example.lua`` file showcases basic configuration and can be found in the ``/etc/tarantool/instances.enabled`` or ``/etc/tarantool/instances.available`` directories. For production purposes, we recommend `official binary packages <http://tarantool.org/download.html>`_. You can choose from two Tarantool versions: ``1.10`` (stable) or ``2.2`` (beta). An automatic build system creates, tests and publishes packages for every push into a corresponding branch (``1.10`` or ``2.2``) at `Tarantool's GitHub repository <https://github.com/tarantool/tarantool>`_. Format the created space by specifying field names and types: Here is how to create a simple test database after installation. However, we encourage you to perform the instance startup manually, so you can learn. If it does, kill the corresponding process. In this example: In the request ``box.cfg{listen = 3301}`` that we made earlier, the ``listen`` value can be any form of a :ref:`URI <index-uri>` (uniform resource identifier). In this case, it’s just a local port: port ``3301``. You can send requests to the listen URI via: Insert three :ref:`tuples <index-box_tuple>` (our name for records) into the space: Let’s try (4). Make sure the default port is vacant: Now you can enter requests on the command line. Now, to prepare for the example in the next section, try this: On production machines, Tarantool's interactive mode is for system administration only. But we use it for most examples in this manual, because the interactive mode is convenient for learning. Start the ``tarantoolctl`` utility: Starting Tarantool Switch to another terminal. On Linux, for example, this means starting another instance of a Bash shell. You can switch to any working directory in the new terminal, not necessarily to ``~/tarantool_sandbox``. Tarantool starts in the interactive mode and displays a prompt: The terminal screen now looks like this: This is a primary index based on the ``id`` field of each tuple. This means "send a request to that Tarantool instance, and display the result". The result in this case is one of the tuples that was inserted earlier. Your terminal screen should now look like this: This means "use ``tarantoolctl connect`` to connect to the Tarantool instance that’s listening on ``localhost:3301``". To add a secondary index based on the ``band_name`` field, say: To check if the demonstrative instance is running, say: To destroy the test: ``rm -r ~/tarantool_sandbox`` To download and install the package that’s appropriate for your OS, start a shell (terminal) and enter the command-line instructions provided for your OS at Tarantool's `download page <http://tarantool.org/download.html>`_. To drop the space: ``s:drop()`` To let Tarantool store data in a separate place, create a new directory dedicated for tests: To select a tuple using the ``primary`` index, say: To select tuples using the ``secondary`` index, say: To start Tarantool's database module and make the instance accept TCP requests on port ``3301``, say: To start a Tarantool instance, say this: To stop Tarantool (an alternative): the standard Lua function `os.exit() <http://www.lua.org/manual/5.1/manual.html#pdf-os.exit>`_ To stop Tarantool (from another terminal): ``sudo pkill -f tarantool`` To stop ``tarantoolctl``: Ctrl+C or Ctrl+D Try this request: Using a binary package When the testing is over: You can delete the directory when the tests are over. You can repeat ``box.space...:insert{}`` and ``box.space...:select{}`` indefinitely, on either Tarantool instance. ``telnet``, a :ref:`connector <index-box_connectors>`, another instance of Tarantool (using the :ref:`console <console-module>` module), or localhost:3301> box.space.tester:select{2} tarantool> tarantool> box.cfg{listen = 3301} tarantool> box.schema.user.grant('guest', 'read,write,execute', 'universe') tarantool> s = box.schema.space.create('tester') tarantool> s = box.schema.space.create('tester')
---
...
tarantool> s:format({
         > {name = 'id', type = 'unsigned'},
         > {name = 'band_name', type = 'string'},
         > {name = 'year', type = 'unsigned'}
         > })
---
...
tarantool> s:create_index('primary', {
         > type = 'hash',
         > parts = {'id'}
         > })
---
- unique: true
  parts:
  - type: unsigned
    is_nullable: false
    fieldno: 1
  id: 0
  space_id: 512
  name: primary
  type: HASH
...
tarantool> s:insert{1, 'Roxette', 1986}
---
- [1, 'Roxette', 1986]
...
tarantool> s:insert{2, 'Scorpions', 2015}
---
- [2, 'Scorpions', 2015]
...
tarantool> s:insert{3, 'Ace of Base', 1993}
---
- [3, 'Ace of Base', 1993]
...
tarantool> s:select{3}
---
- - [3, 'Ace of Base', 1993]
... tarantool> s.index.secondary:select{'Scorpions'}
---
- - [2, 'Scorpions', 2015]
... tarantool> s:create_index('primary', {
         > type = 'hash',
         > parts = {'id'}
         > }) tarantool> s:create_index('secondary', {
         > type = 'hash',
         > parts = {'band_name'}
         > }) tarantool> s:format({
         > {name = 'id', type = 'unsigned'},
         > {name = 'band_name', type = 'string'},
         > {name = 'year', type = 'unsigned'}
         > }) tarantool> s:insert{1, 'Roxette', 1986}
tarantool> s:insert{2, 'Scorpions', 2015}
tarantool> s:insert{3, 'Ace of Base', 1993} tarantool> s:select{3} Project-Id-Version: Tarantool 1.10
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
 $ # если вы скачали бинарный пакет с помощью apt-get или yum, введите:
$ /usr/bin/tarantool
$ # если вы скачали бинарный пакет в формате TAR
$ # и разархивировали его в директорию ~/tarantool, введите:
$ ~/tarantool/bin/tarantool $ kill 6851 $ lsof -i :3301
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
tarantool 6851 root   12u  IPv4  40827      0t0  TCP *:3301 (LISTEN) $ mkdir ~/tarantool_sandbox
$ cd ~/tarantool_sandbox $ tarantoolctl connect '3301' $ tarantoolctl connect 3301
/usr/local/bin/tarantoolctl: connected to localhost:3301
localhost:3301> box.space.tester:select{2}
---
- - [2, 'Scorpions', 2015]
... утилиту :ref:`tarantoolctl <tarantoolctl>`. Проверьте доступность порта, используемого по умолчанию для прослушивания на экземпляре базы данных. Установка удаленного подключения Создайте первый :ref:`индекс <index-box_index>` (с именем ``primary``): Создайте первый :ref:`спейс <index-box_space>` (с именем ``tester``): Создание базы данных В зависимости от версии, Tarantool может во время установки запустить экземпляр ``example.lua``, который настроен на прослушивание по порту ``3301`` по умолчанию. В файле ``example.lua`` показана базовая конфигурация; его можно найти в директории ``/etc/tarantool/instances.enabled`` или ``/etc/tarantool/instances.available``. Для промышленной разработки мы рекомендуем использовать `официальные бинарные пакеты <http://tarantool.org/download.html>`_. Можно выбрать одну из двух версий Tarantool’а: ``1.10`` (стабильная) или ``2.2`` (бета). Автоматическая система сборки создает, тестирует и публикует пакеты после  каждого коммита в соответствующую ветку (``1.10`` или ``2.2``) `репозитория Tarantool’а на GitHub <https://github.com/tarantool/tarantool>`_. Форматируйте созданный спейс, указав имена и типы полей: Далее объясняется, как создать простую тестовую базу данных после установки Tarantool'а. Тем не менее, мы предлагаем провести установку самостоятельно с целью обучения. Если он запущен, отключите соответствующий процесс. В данном примере: В запросе ``box.cfg{listen = 3301}``, который мы отправили ранее, параметр ``listen`` может принимать в качестве значения :ref:`URI <index-uri>` (унифицированный идентификатор ресурса) любой формы. В нашем случае это просто локальный порт ``3301``. Вы можете отправлять запросы на указанный  URI, используя: Вставьте в созданный спейс три :ref:`кортежа <index-box_tuple>` (наш термин для записей): Давайте попробуем вариант с ``tarantoolctl``. Убедитесь, что свободен порт, используемый по умолчанию: Теперь вы можете вводить запросы в командной строке. Теперь, чтобы подготовиться к примеру в следующем разделе, попробуйте следующее: На боевых серверах интерактивный режим Tarantool’а предназначен только для системных администраторов. Мы же используем его в большинстве примеров в данном руководстве, потому что интерактивный режим хорошо подходит для обучения. Запустите утилиту ``tarantoolctl``: Запуск экземпляра Tarantool’а Переключитесь на другой терминал. Например, в Linux-системе для этого нужно запустить еще один экземпляр Bash. В новом терминале можно сменить текущую рабочую директорию на любую другую, необязательно использовать ``~/tarantool_sandbox``. Tarantool запускается в интерактивном режиме и показывает приглашение командной строки: Теперь вывод в окне терминала выглядит следующим образом: Это первичный индекс по полю ``id`` в каждом кортеже. Это означает "послать запрос тому Tarantool-серверу и вывести результат на экран". Результатом в данном случае будет один из кортежей, что вы вставляли ранее. В окне терминала теперь должно отображаться примерно следующее: Данная команда означает «использовать утилиту ``tarantoolctl`` для подключения к Tarantool-серверу, который слушает по адресу ``localhost:3301``». Для добавления вторичного индекса по полю ``band_name`` используйте эту команду: Чтобы проверить статус работы демонстрационного экземпляра, выполните команду: Для удаления директории-песочницы: ``rm -r ~/tarantool_sandbox`` Чтобы скачать и установить бинарный пакет для вашей операционной системы, откройте командную строку и введите инструкции, которые даны для вашей операционной системы на `странице для скачивания <http://tarantool.org/download.html>`_. Для удаления спейса: ``s:drop()`` Чтобы Tarantool хранил данные в определенном месте, создайте предназначенную специально для тестов директорию: Для выборки кортежей по первичному индексу ``primary`` выполните команду: Для выборки кортежей по вторичному индексу ``secondary`` выполните команду: Чтобы запустить модуль Tarantool’а для работы с базой данных и сделать так, чтобы запущенный экземпляр принимал TCP-запросы на порту ``3301``, выполните эту команду: Для запуска экземпляра Tarantool’а выполните эту команду: Для остановки Tarantool’а (альтернативный вариант): стандартная Lua-функция `os.exit() <http://www.lua.org/manual/5.1/manual.html#pdf- os.exit>`_ Для остановки Tarantool’а (из другого терминала): ``sudo pkill -f tarantool`` Для остановки ``tarantoolctl``:  ctrl+C или ctrl+D Введите следующий запрос: Использование бинарного пакета Закончив тестирование, выполните следующие шаги: Ее можно удалить после окончания тестирования. Вы можете посылать запросы ``box.space...:insert{}`` и ``box.space...:select{}`` неограниченное количество раз на любом из двух запущенных экземпляров Tarantool’а. ``telnet``, :ref:`коннектор <index-box_connectors>`, другой экземпляр Tarantool'а (с помощью модуля :ref:`console <console-module>`), либо localhost:3301> box.space.tester:select{2} tarantool> tarantool> box.cfg{listen = 3301} tarantool> box.schema.user.grant('guest', 'read,write,execute', 'universe') tarantool> s = box.schema.space.create('tester') tarantool> s = box.schema.space.create('tester')
---
...
tarantool> s:format({
         > {name = 'id', type = 'unsigned'},
         > {name = 'band_name', type = 'string'},
         > {name = 'year', type = 'unsigned'}
         > })
---
...
tarantool> s:create_index('primary', {
         > type = 'hash',
         > parts = {'id'}
         > })
---
- unique: true
  parts:
  - type: unsigned
    is_nullable: false
    fieldno: 1
  id: 0
  space_id: 512
  name: primary
  type: HASH
...
tarantool> s:insert{1, 'Roxette', 1986}
---
- [1, 'Roxette', 1986]
...
tarantool> s:insert{2, 'Scorpions', 2015}
---
- [2, 'Scorpions', 2015]
...
tarantool> s:insert{3, 'Ace of Base', 1993}
---
- [3, 'Ace of Base', 1993]
...
tarantool> s:select{3}
---
- - [3, 'Ace of Base', 1993]
... tarantool> s.index.secondary:select{'Scorpions'}
---
- - [2, 'Scorpions', 2015]
... tarantool> s:create_index('primary', {
         > type = 'hash',
         > parts = {'id'}
         > }) tarantool> s:create_index('secondary', {
         > type = 'hash',
         > parts = {'band_name'}
         > }) tarantool> s:format({
         > {name = 'id', type = 'unsigned'},
         > {name = 'band_name', type = 'string'},
         > {name = 'year', type = 'unsigned'}
         > }) tarantool> s:insert{1, 'Roxette', 1986}
tarantool> s:insert{2, 'Scorpions', 2015}
tarantool> s:insert{3, 'Ace of Base', 1993} tarantool> s:select{3} 