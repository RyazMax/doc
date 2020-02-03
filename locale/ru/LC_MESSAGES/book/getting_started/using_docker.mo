��    -      �              �  '   �  }        �  f   �       D   +     p  J   �  `  �  =   0  �   n  �     S   �  Q   
     \  /   r  �   �     c	    x	     |  �   �  �     (     �   9       @     y  V  ?   �  ;     3   L  4   �  U   �       6      J   W     �  5   �  K  �  X   4  |   �  �   
  �   �  �   Z     �  �    '   �  }   �     L  �   f  =   8  b   v  &   �  n      ~  o  g   �    V  �   Z   �   =!  �   �!  !   f"  `   �"  �  �"  '   �$  <  �$  V   �(  �   G)  �  %*  j   �+  :  D,     -  [   �-  �  �-  �   0  �   	1  ~   �1  �   '2  �   �2  .   q3  �   �3  �   G4     �4  5   �4  K  5  X   ^8  |   �8  �   49  �   �9  �   �:     ;   $ docker exec -i -t mytarantool console $ docker run \
  --name mytarantool \
  -d -p 3301:3301 \
  -v /data/dir/on/host:/var/lib/tarantool \
  tarantool/tarantool:1 $ docker stop mytarantool Attaches to the Tarantool server inside the container under ``admin`` user via a standard Unix socket. Attaching to Tarantool Create the first :ref:`index <index-box_index>` (named ``primary``): Creating a database First, create the first :ref:`space <index-box_space>` (named ``tester``): For trial and test purposes, we recommend using `official Tarantool images for Docker <https://github.com/tarantool/docker>`_. An official image contains a particular Tarantool version and all popular external modules for Tarantool. Everything is already installed and configured in Linux. These images are the easiest way to install and use Tarantool. Format the created space by specifying field names and types: If you don't have Docker installed, please follow the official `installation guide <https://docs.docker.com/engine/getstarted/step_one/#/step-1-get-docker>`_ for your OS. If you're new to Docker, we recommend going over `this tutorial <https://docs.docker.com/engine/getstarted/step_one/>`_ before proceeding with this chapter. Insert three :ref:`tuples <index-box_tuple>` (our name for records) into the space: Instructs Tarantool to open an interactive console port for incoming connections. Launching a container Now you can enter requests on the command line. On production machines, Tarantool's interactive mode is for system administration only. But we use it for most examples in this manual, because the interactive mode is convenient for learning. Stopping a container Tarantool :ref:`persists data <index-box_persistence>` inside the container. To make your test data available after you stop the container, this command also mounts the host's directory ``/data/dir/on/host`` (you need to specify here an absolute path to an existing local directory) in the container's directory ``/var/lib/tarantool`` (by convention, Tarantool in a container uses this directory to persist data). So, all changes made in the mounted directory on the container's side are applied to the host's disk. Tarantool displays a prompt: Tarantool will be accepting incoming connections on ``localhost:3301``. You may start using it as a key-value storage right away. Tarantool's database module in the container is already :ref:`configured <box_introspection-box_cfg>` and started. You needn't do it manually, unless you use Tarantool as an :ref:`application server <app_server>` and run it with an application. The terminal screen now looks like this: This command runs a new container named ``mytarantool``. Docker starts it from an official image named ``tarantool/tarantool:1``, with Tarantool version ``1.10`` and all external modules already installed. This command: This is a primary index based on the ``id`` field of each tuple. This was a temporary container, and its disk/memory data were flushed when you stopped it. But since you mounted a data directory from the host in the container, Tarantool's data files were persisted to the host's disk. Now if you start a new container and mount that data directory in it, Tarantool will recover all data from disk and continue working with the persisted data. To add a secondary index based on the ``band_name`` field, say: To attach to Tarantool that runs inside the container, say: To select a tuple using the ``primary`` index, say: To select tuples using the ``secondary`` index, say: To start a fully functional Tarantool instance, run a container with minimal options: Using a Docker image When the testing is over, stop the container politely: While you're attached to the console, let's create a simple test database. tarantool.sock> tarantool.sock> s = box.schema.space.create('tester') tarantool.sock> s = box.schema.space.create('tester')
---
...
tarantool.sock> s:format({
              > {name = 'id', type = 'unsigned'},
              > {name = 'band_name', type = 'string'},
              > {name = 'year', type = 'unsigned'}
              > })
---
...
tarantool.sock> s:create_index('primary', {
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
tarantool.sock> s:insert{1, 'Roxette', 1986}
---
- [1, 'Roxette', 1986]
...
tarantool.sock> s:insert{2, 'Scorpions', 2015}
---
- [2, 'Scorpions', 2015]
...
tarantool.sock> s:insert{3, 'Ace of Base', 1993}
---
- [3, 'Ace of Base', 1993]
...
tarantool.sock> s:select{3}
---
- - [3, 'Ace of Base', 1993]
... tarantool.sock> s.index.secondary:select{'Scorpions'}
---
- - [2, 'Scorpions', 2015]
... tarantool.sock> s:create_index('primary', {
              > type = 'hash',
              > parts = {'id'}
              > }) tarantool.sock> s:create_index('secondary', {
              > type = 'hash',
              > parts = {'band_name'}
              > }) tarantool.sock> s:format({
              > {name = 'id', type = 'unsigned'},
              > {name = 'band_name', type = 'string'},
              > {name = 'year', type = 'unsigned'}
              > }) tarantool.sock> s:insert{1, 'Roxette', 1986}
tarantool.sock> s:insert{2, 'Scorpions', 2015}
tarantool.sock> s:insert{3, 'Ace of Base', 1993} tarantool.sock> s:select{3} Project-Id-Version: Tarantool 1.10
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
 $ docker exec -i -t mytarantool console $ docker run \
  --name mytarantool \
  -d -p 3301:3301 \
  -v /data/dir/on/host:/var/lib/tarantool \
  tarantool/tarantool:1 $ docker stop mytarantool Подключается через стандартный Unix-сокет к Tarantool-серверу, запущенному внутри контейнера, из-под пользователя ``admin``. Подключение к экземпляру Tarantool’а Создайте первый :ref:`индекс <index-box_index>` (с именем ``primary``): Создание базы данных Сначала создайте первый :ref:`спейс <index-box_space>` (с именем ``tester``): Для практики и тестирования мы рекомендуем использовать `официальные образы Tarantool’а для Docker <https://github.com/tarantool/docker>`_. Официальный образ содержит определенную версию Tarantool’а и все популярные внешние модули для Tarantool’а. Все необходимое уже установлено и настроено на платформе Linux. Данные образы - это самый простой способ установить и запустить Tarantool. Форматируйте созданный спейс, указав имена и типы полей: Если Docker не установлен на вашей машине, следуйте официальным `инструкциям по установке <https://docs.docker.com/engine/getstarted/step_one/#/step-1-get- docker>`_ для вашей ОС. Если вы никогда раньше не работали с Docker, рекомендуем сперва прочитать `эту обучающую статью <https://docs.docker.com/engine/getstarted/step_one/>`_. Вставьте в созданный спейс три :ref:`кортежа <index-box_tuple>` (наш термин для записей): Требует от Tarantool’а открыть порт с интерактивной консолью для входящих  подключений. Запуск контейнера Теперь вы можете вводить запросы в командной строке. На боевых серверах интерактивный режим Tarantool’а предназначен только для системных администраторов. Мы же используем его в большинстве примеров в данном руководстве, потому что интерактивный режим хорошо подходит для обучения. Остановка контейнера Tarantool :ref:`сохраняет данные <index-box_persistence>` внутри контейнера. Чтобы ваше тестовые данные остались доступны после остановки контейнера, эта команда также монтирует директорию ``/data/dir/on/host`` (здесь необходимо указать абсолютный путь до существующей локальной директории), расположенную на машине, в директорию ``/var/lib/tarantool``  (Tarantool традиционно использует эту директорию в контейнере для сохранения данных), расположенную в контейнере. Таким образом все изменения в смонтированной директории, внесенные на стороне контейнера, также отражаются в расположенной на пользовательском диске директории. Tarantool показывает приглашение командной строки: Tarantool будет принимать входящие подключения по адресу ``localhost:3301``. Можно сразу начать его использовать как key-value хранилище. Модуль Tarantool’а для работы с базой данных уже :ref:`настроен <box_introspection-box_cfg>` и запущен в контейнере. Ручная настройка не требуется, если только вы не используете Tarantool как :ref:`сервер приложений <app_server>` и не запускаете его вместе с приложением. Теперь вывод в окне терминала выглядит следующим образом: Эта команда запускает новый контейнер с именем 'mytarantool'. Docker запускает его из официального образа 'tarantool/tarantool:1' с предустановленным Tarantool’ом ``1.10`` и всеми внешними модулями. Эта команда: Это первичный индекс по полю ``id`` в каждом кортеже. Это был временный контейнер, поэтому после остановки содержимое его диска/памяти обнулилось. Но так как вы монтировали локальную директорию в  контейнер, все данные Tarantool’а сохранились на диске вашей машины. Если вы запустите новый контейнер и смонтируете в него ту же директорию с  данными, Tarantool восстановит все данные с диска и продолжит с ними работать. Для добавления вторичного индекса по полю ``band_name`` используйте эту команду: Для подключения к запущенному в контейнере экземпляру Tarantool’а, выполните эту команду: Для выборки кортежей по первичному индексу ``primary`` выполните команду: Для выборки кортежей по вторичному индексу ``secondary`` выполните команду: Для использования полнофункционального экземпляра Tarantool’а запустите контейнер с минимальными настройками: Использование Docker-образа После завершения тестирования для корректной остановки контейнера выполните эту команду: Подключившись к консоли, давайте создадим простую тестовую базу данных. tarantool.sock> tarantool.sock> s = box.schema.space.create('tester') tarantool.sock> s = box.schema.space.create('tester')
---
...
tarantool.sock> s:format({
              > {name = 'id', type = 'unsigned'},
              > {name = 'band_name', type = 'string'},
              > {name = 'year', type = 'unsigned'}
              > })
---
...
tarantool.sock> s:create_index('primary', {
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
tarantool.sock> s:insert{1, 'Roxette', 1986}
---
- [1, 'Roxette', 1986]
...
tarantool.sock> s:insert{2, 'Scorpions', 2015}
---
- [2, 'Scorpions', 2015]
...
tarantool.sock> s:insert{3, 'Ace of Base', 1993}
---
- [3, 'Ace of Base', 1993]
...
tarantool.sock> s:select{3}
---
- - [3, 'Ace of Base', 1993]
... tarantool.sock> s.index.secondary:select{'Scorpions'}
---
- - [2, 'Scorpions', 2015]
... tarantool.sock> s:create_index('primary', {
              > type = 'hash',
              > parts = {'id'}
              > }) tarantool.sock> s:create_index('secondary', {
              > type = 'hash',
              > parts = {'band_name'}
              > }) tarantool.sock> s:format({
              > {name = 'id', type = 'unsigned'},
              > {name = 'band_name', type = 'string'},
              > {name = 'year', type = 'unsigned'}
              > }) tarantool.sock> s:insert{1, 'Roxette', 1986}
tarantool.sock> s:insert{2, 'Scorpions', 2015}
tarantool.sock> s:insert{3, 'Ace of Base', 1993} tarantool.sock> s:select{3} 