��    ^                    �  �
  �  �  �  �   �  z     :   �  A   �        $   5     Z     g  ;   �     �  7   �  4     =   C  @   �  [   �  >      ;   ]   ;   �   >   �   P   !  �   e!  �   $"  z   �"  t   [#    �#     �$  v   �$  s   q%  
   �%    �%  #  '     2(  G   :(  4   �(     �(  )   �(  .   �(     &)  }   3)  z   �)  �   ,*  Q   �*  N   -+     |+  R  �+     �,  �   �,  �   �-     �.  H   �.  M   (/  	   v/  �   �/  �   !0     �0     �0  �   �0  �  u1  B   4  �   ^4  �   �4  �   �5  ?   �6  �  17  �  �8    :  �   �;  C   �<  @   �<  7   =  ;   @=     |=     �=  �   �=  s   |>  ~   �>     o?     �?     @  ?  @  D   [A  >   �A     �A  �   �A  �   �B  %   SC  "  yC  >  �E  L  �F  �   (I  �   �I  �  J  �  "L  �  �Z  �   �j  z   k  :   �k  A   �k      �k  $   l     Dl  %   Vl  V   |l  $   �l  \   �l  Y   Um  a   �m  j   n  |   |n  W   �n  e   Qo  e   �o  p   p  �   �p  Z  Gq    �r  �   �s  �   ]t  �  
u  %   �v  �   �v  �   ww     4x    Kx  ,  hz     �|  �   �|  w   2}  '   �}  C   �}  H   ~     _~  �   m~  �   X    @�  �   N�  �   ց  $   [�  S  ��     Ԅ  �  �  �  �     ��  �   ֈ  �   ��      M�    n�  !  ��     ��     Ȍ  �   �  �  ��  t   @�  	  ��  <  ��  >  ��  t   ;�  �  ��    ^�  �  f�    C�  �   ß  �   h�  �   
�  �   ��     �     �  �   *�  s   �  ~   ��  �   �     ��     ��  f  ¤  D   )�  >   n�     ��  �   ͦ  �   ��  %   !�  "  G�  >  j�  L  ��  %  ��    �   $ # Check that the include subdirectory exists
$ # by looking for /usr/include/postgresql/libpq-fe-h.
$ [ -f /usr/include/postgresql/libpq-fe.h ] && echo "OK" || echo "Error"
OK

$ # Check that the library subdirectory exists and has the necessary .so file.
$ [ -f /usr/lib/x86_64-linux-gnu/libpq.so ] && echo "OK" || echo "Error"
OK

$ # Check that the psql client can connect using some factory defaults:
$ # port = 5432, user = 'postgres', user password = 'postgres',
$ # database = 'postgres'. These can be changed, provided one changes
$ # them in all places. Insert a row in database postgres, and quit.
$ psql -h 127.0.0.1 -p 5432 -U postgres -d postgres
Password for user postgres:
psql (9.3.10)
SSL connection (cipher: DHE-RSA-AES256-SHA, bits: 256)
Type "help" for help.

postgres=# CREATE TABLE test (s1 INT, s2 VARCHAR(50));
CREATE TABLE
postgres=# INSERT INTO test VALUES (1,'PostgreSQL row');
INSERT 0 1
postgres=# \q
$

$ # Install luarocks
$ sudo apt-get -y install luarocks | grep -E "Setting up|already"
Setting up luarocks (2.0.8-2) ...

$ # Set up the Tarantool rock list in ~/.luarocks,
$ # following instructions at rocks.tarantool.org
$ mkdir ~/.luarocks
$ echo "rocks_servers = {[[http://rocks.tarantool.org/]]}" >> \
        ~/.luarocks/config.lua

$ # Ensure that the next "install" will get files from Tarantool master
$ # repository. The resultant display is normal for Ubuntu 12.04 precise
$ cat /etc/apt/sources.list.d/tarantool.list
deb http://tarantool.org/dist/1.7/ubuntu/ precise main
deb-src http://tarantool.org/dist/1.7/ubuntu/ precise main

$ # Install tarantool-dev. The displayed line should show version = 1.7
$ sudo apt-get -y install tarantool-dev | grep -E "Setting up|already"
Setting up tarantool-dev (1.7.0.222.g48b98bb~precise-1) ...
$

$ # Use luarocks to install locally, that is, relative to $HOME
$ luarocks install pg POSTGRESQL_LIBDIR=/usr/lib/x86_64-linux-gnu --local
Installing http://rocks.tarantool.org/pg-scm-1.rockspec...
... (more info about building the Tarantool/PostgreSQL driver appears here)
pg scm-1 is now built and installed in ~/.luarocks/

$ # Ensure driver.so now has been created in a place
$ # tarantool will look at
$ find ~/.luarocks -name "driver.so"
~/.luarocks/lib/lua/5.1/pg/driver.so

$ # Change directory to a directory which can be used for
$ # temporary tests. For this example we assume that the
$ # name of this directory is $HOME/tarantool_sandbox.
$ # (Change "$HOME" to whatever is the user's actual
$ # home directory for the machine that's used for this test.)
cd $HOME/tarantool_sandbox

$ # Start the Tarantool server instance. Do not use a Lua initialization file.

$ tarantool
tarantool: version 1.7.0-412-g803b15c
type 'help' for interactive help
tarantool> $ export TMDIR=~/mysql-5.5
$ # Check that the include subdirectory exists by looking
$ # for .../include/mysql.h. (If this fails, there's a chance
$ # that it's in .../include/mysql/mysql.h instead.)
$ [ -f $TMDIR/include/mysql.h ] && echo "OK" || echo "Error"
OK

$ # Check that the library subdirectory exists and has the
$ # necessary .so file.
$ [ -f $TMDIR/lib/libmysqlclient.so ] && echo "OK" || echo "Error"
OK

$ # Check that the mysql client can connect using some factory
$ # defaults: port = 3306, user = 'root', user password = '',
$ # database = 'test'. These can be changed, provided one uses
$ # the changed values in all places.
$ $TMDIR/bin/mysql --port=3306 -h 127.0.0.1 --user=root \
    --password= --database=test
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 5.5.35 MySQL Community Server (GPL)
...
Type 'help;' or '\h' for help. Type '\c' to clear ...

$ # Insert a row in database test, and quit.
mysql> CREATE TABLE IF NOT EXISTS test (s1 INT, s2 VARCHAR(50));
Query OK, 0 rows affected (0.13 sec)
mysql> INSERT INTO test.test VALUES (1,'MySQL row');
Query OK, 1 row affected (0.02 sec)
mysql> QUIT
Bye

$ # Install luarocks
$ sudo apt-get -y install luarocks | grep -E "Setting up|already"
Setting up luarocks (2.0.8-2) ...

$ # Set up the Tarantool rock list in ~/.luarocks,
$ # following instructions at rocks.tarantool.org
$ mkdir ~/.luarocks
$ echo "rocks_servers = {[[http://rocks.tarantool.org/]]}" >> \
    ~/.luarocks/config.lua

$ # Ensure that the next "install" will get files from Tarantool
$ # master repository. The resultant display is normal for Ubuntu
$ # 12.04 precise
$ cat /etc/apt/sources.list.d/tarantool.list
deb http://tarantool.org/dist/1.7/ubuntu/ precise main
deb-src http://tarantool.org/dist/1.7/ubuntu/ precise main

$ # Install tarantool-dev. The displayed line should show version = 1.6
$ sudo apt-get -y install tarantool-dev | grep -E "Setting up|already"
Setting up tarantool-dev (1.6.6.222.g48b98bb~precise-1) ...
$

$ # Use luarocks to install locally, that is, relative to $HOME
$ luarocks install mysql MYSQL_LIBDIR=/usr/local/mysql/lib --local
Installing http://rocks.tarantool.org/mysql-scm-1.rockspec...
... (more info about building the Tarantool/MySQL driver appears here)
mysql scm-1 is now built and installed in ~/.luarocks/

$ # Ensure driver.so now has been created in a place
$ # tarantool will look at
$ find ~/.luarocks -name "driver.so"
~/.luarocks/lib/lua/5.1/mysql/driver.so

$ # Change directory to a directory which can be used for
$ # temporary tests. For this example we assume that the name
$ # of this directory is /home/pgulutzan/tarantool_sandbox.
$ # (Change "/home/pgulutzan" to whatever is the user's actual
$ # home directory for the machine that's used for this test.)
$ cd /home/pgulutzan/tarantool_sandbox

$ # Start the Tarantool server instance. Do not use a Lua initialization file.

$ tarantool
tarantool: version 1.7.0-222-g48b98bb
type 'help' for interactive help
tarantool> $ git clone https://github.com/tarantool/mysql.git
$ cd mysql && cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
$ make
$ make install $ git clone https://github.com/tarantool/pg.git
$ cd pg && cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
$ make
$ make install $ luarocks install mysql MYSQL_LIBDIR=/usr/local/mysql/lib $ luarocks install pg POSTGRESQL_LIBDIR=/usr/local/postgresql/lib $ sudo apt-get install libpq-dev $ sudo apt-get install tarantool-dev **Example:** *connection-name*:close() *connection-name*:execute(*sql-statement* [, *parameters*]) *connection-name*:ping() *connection_name* = mysql.connect(*connection options*) *connection_name* = pg.connect(*connection options*) :samp:`db = {database-name}` - string, default value is blank :samp:`host = {host-name}` - string, default value = 'localhost' :samp:`pass = {password}` or :samp:`password = {password}` - string, default value is blank :samp:`password = {password}` - string, default value is blank :samp:`port = {port-number}` - number, default value = 3306 :samp:`port = {port-number}` - number, default value = 5432 :samp:`raise = {true|false}` - boolean, default value is false :samp:`user = {user-name}` - string, default value is operating-system user name At this point it is a good idea to check that the installation produced a file named ``driver.so``, and to check that this file is on a directory that is searched by the ``require`` request. Begin by installing luarocks and making sure that tarantool is among the upstream servers, as in the instructions on `rocks.tarantool.org`_, the Tarantool luarocks page. Now execute this: Begin by making a ``require`` request for the mysql driver. We will assume that the name is ``mysql`` in further examples. Begin by making a ``require`` request for the pg driver. We will assume that the name is ``pg`` in further examples. Check the instructions for `downloading and installing a binary package <http://tarantool.org/download.html>`_ that apply for the environment where Tarantool was installed. In addition to installing ``tarantool``, install ``tarantool-dev``. For example, on Ubuntu, add the line: Closing connection Configure tarantool and load mysql module. Make sure that tarantool doesn't reply "error" for the call to "require()". Configure tarantool and load pg module. Make sure that tarantool doesn't reply "error" for the call to "require()". Connecting Create a Lua function that will connect to a PostgreSQL server, (using some factory default values for the port and user and password), retrieve one row, and display the row. For explanations of the statement types used here, read the Lua tutorial earlier in the Tarantool user manual. Create a Lua function that will connect to the MySQL server instance, (using some factory default values for the port and user and password), retrieve one row, and display the row. For explanations of the statement types used here, read the Lua tutorial earlier in the Tarantool user manual. Example Example, creating a function which sets each option in a separate line: Example, using a table literal enclosed in {braces}: Executing a statement For all MySQL statements, the request is: For all PostgreSQL statements, the request is: For example: For further information, including examples of rarely-used requests, see the README.md file at `github.com/tarantool/mysql`_. For further information, including examples of rarely-used requests, see the README.md file at `github.com/tarantool/pg`_. From a user's point of view the MySQL and PostgreSQL rocks are very similar, so the following sections -- "MySQL Example" and "PostgreSQL Example" -- contain some redundancy. Go the site `github.com/tarantool/mysql`_. Follow the instructions there, saying: Go the site `github.com/tarantool/pg`_. Follow the instructions there, saying: How to ping However, because not all platforms are alike, for this example the assumption is that the user must check that the appropriate PostgreSQL files are present and must explicitly state where they are when building the Tarantool/PostgreSQL driver. One can use ``find`` or ``whereis`` to see what directories PostgreSQL files are installed in. Installation It will be necessary to install Tarantool's MySQL driver shared library, load it, and use it to connect to a MySQL server instance. After that, one can pass any MySQL statement to the server instance and receive results, including multiple result sets. It will be necessary to install Tarantool's PostgreSQL driver shared library, load it, and use it to connect to a PostgreSQL server instance. After that, one can pass any PostgreSQL statement to the server instance and receive results. MySQL Example Now, for the MySQL driver shared library, there are two ways to install: Now, for the PostgreSQL driver shared library, there are two ways to install: Now, say: Observe the result. It contains "MySQL row". So this is the row that was inserted into the MySQL database. And now it's been selected with the Tarantool client. Observe the result. It contains "PostgreSQL row". So this is the row that was inserted into the PostgreSQL database. And now it's been selected with the Tarantool client. PostgreSQL Example SQL DBMS Modules Tarantool supplies DBMS connector modules with the module manager for Lua, LuaRocks. So the connector modules may be called "rocks". The Tarantool rocks allow for connecting to SQL servers and executing SQL statements the same way that a MySQL or PostgreSQL client does. The SQL statements are visible as Lua methods. Thus Tarantool can serve as a "MySQL Lua Connector" or "PostgreSQL Lua Connector", which would be useful even if that was all Tarantool could do. But of course Tarantool is also a DBMS, so the module also is useful for any operations, such as database copying and accelerating, which work best when the application can work on both SQL and Tarantool inside the same Lua routine. The methods for connect/select/insert/etc. are similar to the ones in the :ref:`net.box <net_box-module>` module. The connection-options parameter is a table. Possible options are: The discussion here in the reference is about incorporating and using two modules that have already been created: the "SQL DBMS rocks" for MySQL and PostgreSQL. The example was run on an Ubuntu 12.04 ("precise") machine where tarantool had been installed in a /usr subdirectory, and a copy of MySQL had been installed on ~/mysql-5.5. The mysqld server instance is already running on the local host 127.0.0.1. The example was run on an Ubuntu 12.04 ("precise") machine where tarantool had been installed in a /usr subdirectory, and a copy of PostgreSQL had been installed on /usr. The PostgreSQL server instance is already running on the local host 127.0.0.1. The names are similar to the names that PostgreSQL itself uses. The option names, except for `raise`, are similar to the names that MySQL's mysql client uses, for details see the MySQL manual at `dev.mysql.com/doc/refman/5.6/en/connecting.html`_. The `raise` option should be set to :codenormal:`true` if errors should be raised when encountered. To connect with a Unix socket rather than with TCP, specify ``host = 'unix/'`` and :samp:`port = {socket-name}`. This example assumes that MySQL 5.5 or MySQL 5.6 or MySQL 5.7 has been installed. Recent MariaDB versions will also work, the MariaDB C connector is used. The package that matters most is the MySQL client developer package, typically named something like libmysqlclient-dev. The file that matters most from this package is libmysqlclient.so or a similar name. One can use ``find`` or ``whereis`` to see what directories these files are installed in. This example assumes that PostgreSQL 8 or PostgreSQL 9 has been installed. More recent versions should also work. The package that matters most is the PostgreSQL developer package, typically named something like libpq-dev. On Ubuntu this can be installed with: To call another DBMS from Tarantool, the essential requirements are: another DBMS, and Tarantool. The module which connects Tarantool to another DBMS may be called a "connector". Within the module there is a shared library which may be called a "driver". To end a session that began with ``mysql.connect``, the request is: To end a session that began with ``pg.connect``, the request is: To ensure that a connection is working, the request is: We will assume that the name is 'conn' in further examples. With GitHub With LuaRocks conn = mysql.connect({
    host = '127.0.0.1',
    port = 3306,
    user = 'p',
    password = 'p',
    db = 'test',
    raise = true
})
-- OR
conn = mysql.connect({
    host = 'unix/',
    port = '/var/run/mysqld/mysqld.sock'
}) conn = pg.connect({
    host = '127.0.0.1',
    port = 5432,
    user = 'p',
    password = 'p',
    db = 'test'
}) luarocks install mysql [MYSQL_LIBDIR = *path*]
                       [MYSQL_INCDIR = *path*]
                       [--local] luarocks install pg [POSTGRESQL_LIBDIR = *path*]
                    [POSTGRESQL_INCDIR = *path*]
                    [--local] mysql = require('mysql') pg = require('pg') tarantool> -- Connection function. Usage: conn = mysql_connect()
tarantool> function mysql_connection()
         >   local p = {}
         >   p.host = 'widgets.com'
         >   p.db = 'test'
         >   conn = mysql.connect(p)
         >   return conn
         > end
---
...
tarantool> conn = mysql_connect()
---
... tarantool> box.cfg{}
...
tarantool> mysql = require('mysql')
---
... tarantool> box.cfg{}
...
tarantool> pg = require('pg')
---
... tarantool> conn:close()
---
... tarantool> conn:execute('select table_name from information_schema.tables')
---
- - table_name: ALL_PLUGINS
  - table_name: APPLICABLE_ROLES
  - table_name: CHARACTER_SETS
  <...>
- 78
... tarantool> conn:execute('select tablename from pg_tables')
---
- - tablename: pg_statistic
  - tablename: pg_type
  - tablename: pg_authid
  <...>
... tarantool> conn:ping()
---
- true
... tarantool> function mysql_select ()
         >   local conn = mysql.connect({
         >     host = '127.0.0.1',
         >     port = 3306,
         >     user = 'root',
         >     db = 'test'
         >   })
         >   local test = conn:execute('SELECT * FROM test WHERE s1 = 1')
         >   local row = ''
         >   for i, card in pairs(test) do
         >       row = row .. card.s2 .. ' '
         >       end
         >   conn:close()
         >   return row
         > end
---
...
tarantool> mysql_select()
---
- 'MySQL row '
... tarantool> function pg_connect()
         >   local p = {}
         >   p.host = 'widgets.com'
         >   p.db = 'test'
         >   p.user = 'postgres'
         >   p.password = 'postgres'
         >   local conn = pg.connect(p)
         >   return conn
         > end
---
...
tarantool> conn = pg_connect()
---
... tarantool> function pg_select ()
         >   local conn = pg.connect({
         >     host = '127.0.0.1',
         >     port = 5432,
         >     user = 'postgres',
         >     password = 'postgres',
         >     db = 'postgres'
         >   })
         >   local test = conn:execute('SELECT * FROM test WHERE s1 = 1')
         >   local row = ''
         >   for i, card in pairs(test) do
         >       row = row .. card.s2 .. ' '
         >       end
         >   conn:close()
         >   return row
         > end
---
...
tarantool> pg_select()
---
- 'PostgreSQL row '
... where ``sql-statement`` is a string, and the optional ``parameters`` are extra values that can be plugged in to replace any placeholders ($1 $2 $3 etc.) in the SQL statement. where ``sql-statement`` is a string, and the optional ``parameters`` are extra values that can be plugged in to replace any question marks ("?"s) in the SQL statement. Project-Id-Version: Tarantool 1.10
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
 $ # Проверьте, что создана поддиректория include, путем поиска
$ # /usr/include/postgresql/libpq-fe-h.
$ [ -f /usr/include/postgresql/libpq-fe.h ] && echo "OK" || echo "Error"
OK

$ # Проверьте, что создана поддиректория library, а в ней необходимый файл .so.
$ [ -f /usr/lib/x86_64-linux-gnu/libpq.so ] && echo "OK" || echo "Error"
OK

$ # Проверьте, что psql-клиент может подключиться, с помощью настроек по умолчанию:
$ # порт = 5432, пользователь = 'postgres', пароль пользователя = 'postgres',
$ # база данных = 'postgres'. Эти настройки можно изменить, используя
$ # измененные значения. Вставьте строку в базу данных postgres и завершите работу.
$ psql -h 127.0.0.1 -p 5432 -U postgres -d postgres
Password for user postgres:
psql (9.3.10)
SSL connection (cipher: DHE-RSA-AES256-SHA, bits: 256)
Type "help" for help.

postgres=# CREATE TABLE test (s1 INT, s2 VARCHAR(50));
CREATE TABLE
postgres=# INSERT INTO test VALUES (1,'PostgreSQL row');
INSERT 0 1
postgres=# \q
$

$ # Установите luarocks
$ sudo apt-get -y install luarocks | grep -E "Setting up|already"
Setting up luarocks (2.0.8-2) ...

$ # Настройте список сторонних модулей Tarantool'а в ~/.luarocks,
$ # следуя инструкциям по ссылке rocks.tarantool.org
$ mkdir ~/.luarocks
$ echo "rocks_servers = {[[http://rocks.tarantool.org/]]}" >> \
        ~/.luarocks/config.lua

$ # Убедитесь, что при следующей установке будут использованы файлы из главного
$ # хранилища Tarantool'а. Получаем результат, нормальный для Ubuntu 12.04 Precise Pangolin
$ cat /etc/apt/sources.list.d/tarantool.list
deb http://tarantool.org/dist/1.7/ubuntu/ precise main
deb-src http://tarantool.org/dist/1.7/ubuntu/ precise main

$ # Установите tarantool-dev. Строка на экране должна показать версию 1.7
$ sudo apt-get -y install tarantool-dev | grep -E "Setting up|already"
Setting up tarantool-dev (1.7.0.222.g48b98bb~precise-1) ...
$

$ # Используйте luarocks для локальной установки, то есть в $HOME
$ luarocks install pg POSTGRESQL_LIBDIR=/usr/lib/x86_64-linux-gnu --local
Installing http://rocks.tarantool.org/pg-scm-1.rockspec...
... (здесь будет еще информация о сборке драйвера Tarantool/PostgreSQL)
pg scm-1 is now built and installed in ~/.luarocks/

$ # Убедитесь, что driver.so создан в месте,
$ # где Tarantool будет искать его
$ find ~/.luarocks -name "driver.so"
~/.luarocks/lib/lua/5.1/pg/driver.so

$ # Измените директорию на директорию, которую можно использовать для
$ # временного тестирования. В данном примере предполагаем, что имя
$ # name этой директории будет $HOME/tarantool_sandbox.
$ # (Измените "$HOME" на фактическую корневую директорию
$ # машины, используемой для тестирования.)
cd $HOME/tarantool_sandbox

$ # Запустите экземпляр Tarantool-сервера. Не используйте файл инициализации Lua.

$ tarantool
tarantool: version 1.7.0-412-g803b15c
type 'help' for interactive help
tarantool> $ export TMDIR=~/mysql-5.5
$ # Проверьте, что создана поддиректория include, путем поиска
$ # .../include/mysql.h. (Если нет, то можно проверить
$ # .../include/mysql/mysql.h.)
$ [ -f $TMDIR/include/mysql.h ] && echo "OK" || echo "Error"
OK

$ # Проверьте, что создана поддиректория library, а в ней
$ # необходимый файл .so.
$ [ -f $TMDIR/lib/libmysqlclient.so ] && echo "OK" || echo "Error"
OK

$ # Проверьте, что mysql-клиент может подключиться, с помощью настроек
$ # по умолчанию: порт = 3306, пользователь = 'root', пароль пользователя = '',
$ # база данных = 'test'. Эти настройки можно изменить, используя
$ # измененные значения.
$ $TMDIR/bin/mysql --port=3306 -h 127.0.0.1 --user=root \
    --password= --database=test
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 5.5.35 MySQL Community Server (GPL)
...
Type 'help;' or '\h' for help. Type '\c' to clear ...

$ # Вставьте строку в базу данных test и завершите работу.
mysql> CREATE TABLE IF NOT EXISTS test (s1 INT, s2 VARCHAR(50));
Query OK, 0 rows affected (0.13 sec)
mysql> INSERT INTO test.test VALUES (1,'MySQL row');
Query OK, 1 row affected (0.02 sec)
mysql> QUIT
Bye

$ # Установите luarocks
$ sudo apt-get -y install luarocks | grep -E "Setting up|already"
Setting up luarocks (2.0.8-2) ...

$ # Настройте список сторонних модулей Tarantool'а в ~/.luarocks,
$ # следуя инструкциям по ссылке rocks.tarantool.org
$ mkdir ~/.luarocks
$ echo "rocks_servers = {[[http://rocks.tarantool.org/]]}" >> \
    ~/.luarocks/config.lua

$ # Убедитесь, что при следующей установке будут использованы файлы из главного
$ # хранилища Tarantool'а. Получаем результат, нормальный для Ubuntu
$ # 12.04 Precise Pangolin
$ cat /etc/apt/sources.list.d/tarantool.list
deb http://tarantool.org/dist/1.7/ubuntu/ precise main
deb-src http://tarantool.org/dist/1.7/ubuntu/ precise main

$ # Установите tarantool-dev. Строка на экране должна показать версию 1.6
$ sudo apt-get -y install tarantool-dev | grep -E "Setting up|already"
Setting up tarantool-dev (1.6.6.222.g48b98bb~precise-1) ...
$

$ # Используйте luarocks для локальной установки, то есть в $HOME
$ luarocks install mysql MYSQL_LIBDIR=/usr/local/mysql/lib --local
Installing http://rocks.tarantool.org/mysql-scm-1.rockspec...
... (здесь будет еще информация о сборке драйвера Tarantool/MySQL)
mysql scm-1 is now built and installed in ~/.luarocks/

$ # Убедитесь, что driver.so создан в месте,
$ # где Tarantool будет искать его
$ find ~/.luarocks -name "driver.so"
~/.luarocks/lib/lua/5.1/mysql/driver.so

$ # Измените директорию на директорию, которую можно использовать для
$ # временного тестирования. В данном примере предполагаем, что имя
$ # этой директории будет /home/pgulutzan/tarantool_sandbox.
$ # (Измените "/home/pgulutzan" на фактическую корневую директорию
$ # пользователя машины, используемой для тестирования.)
$ cd /home/pgulutzan/tarantool_sandbox

$ # Запустите экземпляр Tarantool-сервера. Не используйте файл инициализации Lua.

$ tarantool
tarantool: version 1.7.0-222-g48b98bb
type 'help' for interactive help
tarantool> $ git clone https://github.com/tarantool/mysql.git
 $ cd mysql && cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
 $ make
 $ make install $ git clone https://github.com/tarantool/pg.git
$ cd pg && cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
$ make
$ make install $ luarocks install mysql MYSQL_LIBDIR=/usr/local/mysql/lib $ luarocks install pg POSTGRESQL_LIBDIR=/usr/local/postgresql/lib $ sudo apt-get install libpq-dev $ sudo apt-get install tarantool-dev **Пример:** *имя-соединения*:close() *имя-соединения*:execute(*sql-оператор* [, *параметры*]) *имя-соединение*:ping() *имя_подключения* = mysql.connect(*параметры подключения*) *имя_подключения* = pg.connect(*параметры подключения*) :samp:`db = {имя-базы-данных}` -- строка, по умолчанию пустая :samp:`host = {имя-хоста}` -- строка, значение по умолчанию = 'localhost' :samp:`pass = {пароль}` или :samp:`password = {пароль}` -- строка, по умолчанию пустая :samp:`password = {пароль}` -- строка, по умолчанию пустая :samp:`port = {номер-порта}` -- число, значение по умолчанию = 3306 :samp:`port = {номер-порта}` -- число, значение по умолчанию = 5432 :samp:`raise = {true|false}` -- логическое значение, по умолчанию, false (ложь) :samp:`user = {имя-пользователя}` -- строка, значение по умолчанию -- имя пользователя в операционной системе На данном этапе желательно проверить, что после установки появился файл под названием ``driver.so``, а также проверить, что этот файл находится в директории, которую можно найти по запросу ``require``. Начните с установки luarocks. Убедитесь, что tarantool указан в серверах, как описано на странице сторонних модулей Tarantool'а `rocks.tarantool.org`_. Затем выполните: Начните с выполнения запроса ``require`` для драйвера mysql. В дальнейших примерах у него будет имя ``mysql``. Начните с выполнения запроса ``require`` для драйвера pg. В дальнейших примерах у него будет имя ``pg``. Проверьте инструкции по `загрузке и установке бинарного пакета <http://tarantool.org/download.html>`_, которые применимы к среде, где установлен Tarantool. Помимо установки ``tarantool``, установите ``tarantool-dev``. Например, в Ubuntu добавьте строку: Закрытие соединения Настройте Tarantool и загрузите модуль mysql. Убедитесь, что Tarantool не выбрасывает ошибку в ответ на вызов "require()". Настройте Tarantool и загрузите модуль pg. Убедитесь, что Tarantool не выбрасывает ошибку в ответ на вызов "require()". Подключение Создайте Lua-функцию, которая подключится к PostgreSQL-серверу (используя значения по умолчанию для параметров порта, пользователя и пароля), выберите одну строку и выведите ее на экран. Описание используемых здесь типов операторов вы можете найти в практикуме по Lua в руководстве пользователя Tarantool'а. Создайте Lua-функцию, которая подключится к экземпляру MySQL-сервера (используя значения по умолчанию для параметров порта, пользователя и пароля), выберите одну строку и выведите ее на экран. Описание используемых здесь типов операторов вы можете найти в практикуме по Lua в руководстве пользователя Tarantool'а. Пример Пример с созданием функции, которая определяет параметры в отдельных строках: Пример с использованием таблицы, заключенной в {фигурные скобки}: Исполнение оператора Для всех операторов MySQL запрос будет: Для всех операторов PostgreSQL запрос будет: Пример: Для получения дополнительной информации, включая примеры редко используемых запросов, см. файл README.md по ссылке `github.com/tarantool/mysql`_. Для получения дополнительной информации, включая примеры редко используемых запросов, см. файл README.md по ссылке `github.com/tarantool/pg`_. С точки зрения пользователя, модули для MySQL и PostgreSQL очень похожи, поэтому следующие разделы -- "Пример для MySQL" и "Пример для PostgreSQL" -- слегка избыточны. Перейдите по ссылке `github.com/tarantool/mysql`_. Следуя инструкциям, введите команду: Перейдите по ссылке `github.com/tarantool/pg`_. Следуя инструкциям, введите команду: Как проверить связь Однако, не все платформы одинаковы, поэтому в данном примере предполагается, что пользователь должен проверить наличие нужных PostgreSQL-файлов, а также явным образом прописать, где они находятся, для сборки драйвера Tarantool/PostgreSQL. Для поиска директорий, где установлены PostgreSQL-файлы, можно воспользоваться командами ``find`` или ``whereis``. Установка Также нужно будет установить библиотеку общего пользования Tarantool'а с драйвером для MySQL, загрузить ее и использовать для подключения к экземпляру MySQL-сервера. После этого можно передавать любой оператор MySQL на экземпляр сервера и получать результаты, включая наборы результатов. Также нужно будет установить библиотеку общего пользования Tarantool'а с драйвером для PostgreSQL, загрузить ее и использовать для подключения к экземпляру PostgreSQL-сервера. После этого можно передавать любой оператор PostgreSQL на экземпляр сервера и получать результаты. Пример для MySQL Что касается библиотеки общего пользования с драйвером для MySQL, ее можно установить двумя способами: Что касается библиотеки общего пользования с драйвером для PostgreSQL, ее можно установить двумя способами: Теперь выполните: Просмотрите результат. В нем есть строка "MySQL row". Это и есть строка, которая была вставлена в базу данных MySQL. А сейчас она выделена с помощью Tarantool-клиента. Просмотрите результат. В нем есть строка "PostgreSQL row". Это и есть строка, которая была вставлена в базу данных PostgreSQL. А сейчас она выделена с помощью Tarantool-клиента. Пример для PostgreSQL  Модули СУБД SQL Tarantool предоставляет модули-коннекторы для СУБД вместе с менеджером модулей для Lua под названием LuaRocks. Модули Tarantool'а позволяют подключаться к SQL-серверам и выполнять SQL-запросы так же, как это делает клиент MySQL или PostgreSQL. Операторы SQL доступны как Lua-методы. Таким образом, Tarantool может служить Lua-коннектором для MySQL или Lua-коннектором для PostgreSQL, что было бы полезно, даже если бы Tarantool больше ничего не умел. Но конечно же, Tarantool также представляет собой СУБД, поэтому модуль используется для любых операций, таких как копирование и ускорение базы данных, которые максимально эффективно, если приложение может работать как с SQL, так и с Tarantool в пределах одной Lua-процедуры. Методы подключения / выборки / вставки / и т.д. аналогичны методам модуля :ref:`net.box <net_box-module>`. Параметры подключения включены в таблицу. Доступные параметры: В данном разделе справочника рассматривается внедрение и использование двух уже созданных модулей: сторонние библиотеки СУБД SQL для MySQL и PostgreSQL. Пример выполняется на машине с ОС Ubuntu 12.04 (Precise Pangolin), где Tarantool установлен в поддиректорию /usr, а копия MySQL установлена в ~/mysql-5.5. Экземпляр сервера mysqld уже запущен на localhost 127.0.0.1. Пример выполняется на машине с ОС Ubuntu 12.04 (Precise Pangolin), где Tarantool установлен в поддиректорию /usr, а копия PostgreSQL установлена в /usr. Экземпляр сервера PostgreSQL уже запущен на localhost 127.0.0.1. Имена параметров похожи на имена, которые используются в PostgreSQL. Имена параметров, за исключением `raise`, похожи на имена, которые используются в MySQL-клиенте mysql, для получения подробной информации см. руководство по MySQL по ссылке `dev.mysql.com/doc/refman/5.6/en/connecting.html`_. Значение параметра `raise` следует указать как :codenormal:`true`, если ошибки должны возникать при обнаружении. Чтобы подключиться по Unix-сокету, а не по TCP, укажите ``host = 'unix/'`` и :samp:`port = {имя-сокета}`. В данном примере предполагается, что установлены MySQL 5.5, MySQL 5.6 или MySQL 5.7. Последние версии MariaDB также подойдут, используется коннектор к MariaDB для C. Самым важным пакетом будет пакет для разработчиков клиента MySQL, который обычно называется libmysqlclient-dev. Наиболее важным файлом из этого пакета будет файл libmysqlclient.so или с похожим названием. Можно использовать `` find`` или `` whereis``, чтобы узнать, в каких директориях установлены эти файлы. В данном примере предполагается, что установлены PostgreSQL 8 или PostgreSQL 9. Более поздние версии  также должны сработать. Самым важным пакетом будет пакет для разработчиков клиента PostgreSQL, который обычно называется libpq-dev. На Ubuntu его можно установить следующим образом: Для вызова другой СУБД из Tarantool'а нужно: другая СУБД и Tarantool. Модуль, который соединяет другую СУБД может называться коннектором. В модуле есть библиотека общего пользования, которая может называться драйвером. Чтобы закрыть сессию, которую открыли с помощью ``mysql.connect``, используется следующий запрос: Чтобы закрыть сессию, которую открыли с помощью ``pg.connect``, используется следующий запрос: Чтобы убедиться, что подключение работает, следует использовать запрос: Предполагаем, что в дальнейших примерах будет использоваться имя 'conn'. Из GitHub Из LuaRocks conn = mysql.connect({
     host = '127.0.0.1',
     port = 3306,
     user = 'p',
     password = 'p',
     db = 'test',
     raise = true
 })
-- ИЛИ
conn = mysql.connect({
    host = 'unix/',
    port = '/var/run/mysqld/mysqld.sock'
}) conn = pg.connect({
    host = '127.0.0.1',
    port = 5432,
    user = 'p',
    password = 'p',
    db = 'test'
}) luarocks install mysql [MYSQL_LIBDIR = *path*]
                       [MYSQL_INCDIR = *path*]
                       [--local] luarocks install pg [POSTGRESQL_LIBDIR = *путь*]
                    [POSTGRESQL_INCDIR = *путь*]
                    [--local] mysql = require('mysql') pg = require('pg') tarantool> -- Функция подключения. Использование: conn = mysql_connect()
tarantool> function mysql_connection()
         >   local p = {}
         >   p.host = 'widgets.com'
         >   p.db = 'test'
         >   conn = mysql.connect(p)
         >   return conn
         > end
---
...
tarantool> conn = mysql_connect()
---
... tarantool> box.cfg{}
...
tarantool> mysql = require('mysql')
---
... tarantool> box.cfg{}
...
tarantool> pg = require('pg')
---
... tarantool> conn:close()
---
... tarantool> conn:execute('select table_name from information_schema.tables')
---
- - table_name: ALL_PLUGINS
  - table_name: APPLICABLE_ROLES
  - table_name: CHARACTER_SETS
  <...>
- 78
... tarantool> conn:execute('select tablename from pg_tables')
---
- - tablename: pg_statistic
  - tablename: pg_type
  - tablename: pg_authid
  <...>
... tarantool> conn:ping()
---
- true
... tarantool> function mysql_select ()
         >   local conn = mysql.connect({
         >     host = '127.0.0.1',
         >     port = 3306,
         >     user = 'root',
         >     db = 'test'
         >   })
         >   local test = conn:execute('SELECT * FROM test WHERE s1 = 1')
         >   local row = ''
         >   for i, card in pairs(test) do
         >       row = row .. card.s2 .. ' '
         >       end
         >   conn:close()
         >   return row
         > end
---
...
tarantool> mysql_select()
---
- 'MySQL row '
... tarantool> function pg_connect()
         >   local p = {}
         >   p.host = 'widgets.com'
         >   p.db = 'test'
         >   p.user = 'postgres'
         >   p.password = 'postgres'
         >   local conn = pg.connect(p)
         >   return conn
         > end
---
...
tarantool> conn = pg_connect()
---
... tarantool> function pg_select ()
         >   local conn = pg.connect({
         >     host = '127.0.0.1',
         >     port = 5432,
         >     user = 'postgres',
         >     password = 'postgres',
         >     db = 'postgres'
         >   })
         >   local test = conn:execute('SELECT * FROM test WHERE s1 = 1')
         >   local row = ''
         >   for i, card in pairs(test) do
         >       row = row .. card.s2 .. ' '
         >       end
         >   conn:close()
         >   return row
         > end
---
...
tarantool> pg_select()
---
- 'PostgreSQL row '
... где ``sql-statement`` -- это строка, а необязательные параметры -- это дополнительные значения, которыми можно заменить любые местозаполнители ($1 $2 $3 и т.д.) в SQL-операторе. где ``sql-statement`` -- это строка, а необязательные параметры -- это дополнительные значения, которыми можно заменить любые знаки вопроса ("?") в SQL-операторе. 