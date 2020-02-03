��          �               |  �   }  &        2  _   F  ^   �  �        �  %   �      �  }     '   �  k   �  �   1     �  !   �            [   %  (   �  L  �  #   �  �  	  �   �
  &   R  7   y  �   �  �   :  i  �     O  ;   o  ,   �  �   �     n  �   �  �   4  ,   �  5   '     ]  <   o  �   �  (   =  L  f  #   �   $ # for Ubuntu/Debian:
$ sudo apt-get install tarantool-<module-name>

$ # for RHEL/CentOS/Amazon:
$ sudo yum install tarantool-<module-name> $ sudo apt-get install tarantool-shard Follow these steps: For example, to install the module `shard <http://github.com/tarantool/shard>`_ on Ubuntu, say: Install Tarantool as recommended on the `download page <http://tarantool.org/download.html>`_. Install the module you need. Look up the module's name on `Tarantool rocks page <http://tarantool.org/rocks.html>`_ and put the prefix "tarantool-" before the module name to avoid ambiguity: Installing a module Installing a module from a repository Installing a module from deb/rpm Modules in Lua and C that come from Tarantool developers and community contributors are available in the following locations: Once these steps are complete, you can: Question-marks stand for the module name that was specified earlier when saying ``require('module-name')``. See `README in tarantool/rocks repository <https://github.com/tarantool/rocks#managing-modules-with-tarantool-174>`_ for detailed instructions. Tarantool deb/rpm repositories. Tarantool modules repository, and for example: load any module with search locally for installed modules using ``package.path`` (Lua) or ``package.cpath`` (C): tarantool> name = require('module-name') tarantool> package.path
---
- ./?.lua;./?/init.lua; /usr/local/share/tarantool/?.lua;/usr/local/share/
tarantool/?/init.lua;/usr/share/tarantool/?.lua;/usr/share/tarantool/?/ini
t.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/
usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;
...

tarantool> package.cpath
---
- ./?.so;/usr/local/lib/x86_64-linux-gnu/tarantool/?.so;/usr/lib/x86_64-li
nux-gnu/tarantool/?.so;/usr/local/lib/tarantool/?.so;/usr/local/lib/x86_64
-linux-gnu/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/local/
lib/lua/5.1/?.so;
... tarantool> shard = require('shard') Project-Id-Version: Tarantool 1.10
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
 $ # для Ubuntu/Debian:
$ sudo apt-get install tarantool-<module-name>

$ # для RHEL/CentOS/Amazon:
$ sudo yum install tarantool-<module-name> $ sudo apt-get install tarantool-shard Выполните следующие действия: Например, чтобы установить модуль `shard <http://github.com/tarantool/shard>`_ на Ubuntu, введите: Установите Tarantool в соответствии с рекомендациями на `странице загрузки <http://tarantool.org/download.html>`_. Установите необходимый модуль. Найдите имя модуля на `странице со сторонними библиотеками Tarantool'а <http://tarantool.org/rocks.html>`_  и введите префикс "tarantool-" перед названием модуля во избежание неоднозначности: Установка модуля Установка модуля из репозитория Установка модуля из deb/rpm Модули на Lua и C от разработчиков Tarantool'а и сторонних разработчиков доступны здесь: Теперь можно: Знаки вопроса стоят вместо имени модуля, которое было указано ранее при вызове ``require('module-name')``. Для получения подробной информации см. `README в репозитории tarantool/rocks <https://github.com/tarantool/rocks#managing-modules-with-tarantool-174>`_. Репозитории deb/rpm Tarantool'а. Репозиторий модулей Tarantool'а и например: загружать любой модуль с помощью локально находить установленные модули с помощью ``package.path`` (Lua) или ``package.cpath`` (C): tarantool> name = require('module-name') tarantool> package.path
---
- ./?.lua;./?/init.lua; /usr/local/share/tarantool/?.lua;/usr/local/share/
tarantool/?/init.lua;/usr/share/tarantool/?.lua;/usr/share/tarantool/?/ini
t.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/
usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;
...

tarantool> package.cpath
---
- ./?.so;/usr/local/lib/x86_64-linux-gnu/tarantool/?.so;/usr/lib/x86_64-li
nux-gnu/tarantool/?.so;/usr/local/lib/tarantool/?.so;/usr/local/lib/x86_64
-linux-gnu/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/local/
lib/lua/5.1/?.so;
... tarantool> shard = require('shard') 