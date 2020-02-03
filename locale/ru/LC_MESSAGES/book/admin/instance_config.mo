��    %      D              l  �   m  �  1  �   �    �  �  �  �   _	  �   �	  e   �
  y   +  \   �  h     0   k  �   �  �   8     �       M    '  l  �   �  h     �   ~  8   K  �  �  (  (  �   Q     �     �                     -     ;  !   G    i  �   �     !  �  (    �  �  �  �  �  �  �  �  S!  �   E&  U  3'  �   �(  �   4)  �   �)  �   �*  c   D+  �   �+  #  i,  8   �-     �-  ?  �-  5  $0    Z2  �   ^3  -  P4  t   ~5  )  �5  ?  9  �   ];     G<     X<     `<     n<     {<     �<     �<  8   �<    �<  �   �=     �>   #!/usr/bin/env tarantool

box.cfg {
    listen = 3301;
}

-- load my_app module and call start() function
-- with some app options controlled by sysadmins
local m = require('my_app').start({...}) A typical Tarantool application is not a script, but a daemon running in background mode and processing requests, usually sent to it over a TCP/IP socket. This daemon needs to be started automatically when the operating system starts, and managed with the operating system standard tools for service management -- such as ``systemd`` or ``init.d``. To serve this very purpose, we created **instance files**. After this short introduction, you may wonder what an instance file is, what it is for, and how ``tarantoolctl`` uses it. After all, Tarantool is an application server, so why not start the application stored in ``/usr/share/tarantool`` directly? An :ref:`instance file <admin-instance_file>` with instance-specific initialization logic and parameters. Put this file, or a symlink to it, into the **instance directory** (see :ref:`instance_dir <admin-instance_dir>` parameter in ``tarantoolctl`` configuration file). An instance file is designed to not differ in any way from a Lua application. It must, however, configure the database, i.e. contain a call to :ref:`box.cfg{} <box_introspection-box_cfg>` somewhere in it, because it’s the only way to turn a Tarantool script into a background process, and ``tarantoolctl`` is a tool to manage background processes. Other than that, an instance file may contain arbitrary Lua code, and, in theory, even include the entire application business logic in it. We, however, do not recommend this, since it clutters the instance file and leads to unnecessary copy-paste when you need to run multiple instances of an application. An instance file is typically created by a system administrator. An application file is often provided by a developer, in a Lua rock or an rpm/deb package. As a full-featured example, you can take `example.lua <https://github.com/tarantool/tarantool/blob/1.10/extra/dist/example.lua>`_ script that ships with Tarantool and defines all configuration options. Directory for snapshot .snap files; ``tarantoolctl`` will add "/instance_name" to the directory name. Directory for the pid file and control-socket file; ``tarantoolctl`` will add “/instance_name” to the directory name. Directory for vinyl files; ``tarantoolctl`` will add "/instance_name" to the directory name. Directory for write-ahead .xlog files; ``tarantoolctl`` will add "/instance_name" to the directory name. For each Tarantool instance, you need two files: For example, ``/etc/tarantool/instances.enabled/my_app.lua`` (here we load ``my_app.lua`` module and make a call to ``start()`` function from that module): For example, ``/usr/share/tarantool/my_app.lua`` (here we implement it as a :ref:`Lua module <app_server-modules>` that bootstraps the database and exports ``start()`` function for API calls): Instance configuration Instance file Most of the parameters are similar to those used by :ref:`box.cfg{} <box_introspection-box_cfg>`. Here are the default settings (possibly installed in ``/etc/default/tarantool`` or ``/etc/sysconfig/tarantool`` as part of Tarantool distribution -- see OS-specific default paths in :ref:`Notes for operating systems <admin-os_notes>`): The default instance directory depends on Tarantool's ``WITH_SYSVINIT`` build option: when ON, it is ``/etc/tarantool/instances.enabled``, otherwise (OFF or not set) it is ``/etc/tarantool/instances.available``. The latter case is typical for Tarantool builds for Linux distros with ``systemd``. The directory where all instance files for this host are stored. Put instance files in this directory, or create symbolic links. The place where the application log will go; ``tarantoolctl`` will add "/instance_name.log" to the name. The user that runs the Tarantool instance. This is the operating-system user name rather than the Tarantool-client user name. Tarantool will change its effective user to this user after becoming a daemon. To check the build options, say ``tarantool --version``. While instance files contain instance configuration, the ``tarantoolctl`` configuration file contains the configuration that ``tarantoolctl`` uses to override instance configuration. In other words, it contains system-wide configuration defaults. If ``tarantoolctl`` fails to find this file with the method described in section :ref:`Starting/stopping an instance <admin-start_stop_instance>`, it uses default settings. You can have more than one instance file. For example, a single application in ``/usr/share/tarantool`` can run in multiple instances, each of them having its own instance file. Or you can have multiple applications in ``/usr/share/tarantool`` -- again, each of them having its own instance file. [Optional] An :ref:`application file <app_server-launching_app>` with instance-specific logic. Put this file into the ``/usr/share/tarantool/`` directory. ``instance_dir`` ``log`` ``memtx_dir`` ``pid_file`` ``username`` ``vinyl_dir`` ``wal_dir`` `tarantoolctl` configuration file default_cfg = {
    pid_file  = "/var/run/tarantool",
    wal_dir   = "/var/lib/tarantool",
    memtx_dir = "/var/lib/tarantool",
    vinyl_dir = "/var/lib/tarantool",
    log       = "/var/log/tarantool",
    username  = "tarantool",
}
instance_dir = "/etc/tarantool/instances.enabled" local function start()
    box.schema.space.create("somedata")
    box.space.somedata:create_index("primary")
    <...>
end

return {
  start = start;
} where: Project-Id-Version: Tarantool 1.10
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

box.cfg {
    listen = 3301;
}

-- загрузить модуль my_app и вызвать функцию start()
-- некоторые опции приложения под контролем сисадминов
local m = require('my_app').start({...}) Типичное приложение для Tarantool -- это не скрипт, а демон, запущенный в фоновом режиме и обрабатывающий запросы, которые, как правило, посылаются  через TCP/IP-сокет. Необходимо запускать этот демон со стартом операционной системы и управлять им с помощью стандартных средств операционной системы для управления сервисами -- таких как ``systemd`` или ``init.d``. С этой целью и были созданы **файлы экземпляра**. После столь краткого предисловия может возникнуть вопрос: что из себя представляет файл экземпляра, для чего он нужен и как ``tarantoolctl`` использует его? Если Tarantool -- это сервер приложений, так почему бы не запускать хранящееся в ``/usr/share/tarantool`` приложение напрямую? :ref:`Файл экземпляра <admin-instance_file>`, содержащий логику и параметры инициализации данного экземпляра. Поместите этот файл или символьную ссылку на него в **директорию экземпляра** (см. параметр :ref:`instance_dir <admin-instance_dir>` в конфигурационном файле ``tarantoolctl``). По своему устройству файл экземпляра ничем не отличается от Lua-приложения. Однако с его помощью должна настраиваться база данных, поэтому в нем должен содержаться вызов :ref:`box.cfg{} <box_introspection-box_cfg>`, потому что это единственный способ превратить Tarantool-скрипт в фоновый процесс, а ``tarantoolctl`` -- это инструмент для управления фоновыми процессами. За исключением этого вызова, файл экземпляра может содержать произвольный код на Lua и, теоретически, даже всю бизнес-логику приложения. Однако мы не рекомендуем  хранить весь код в файле экземпляра, потому что это приводит как к замусориванию самого файла, так и к ненужному копированию кода при необходимости запустить несколько экземпляров приложения. Обычно файл экземпляра создает системный администратор, а файл приложения  предоставляет разработчик в Lua-модуле или rpm/deb-пакете. В качестве полноценного примера можно использовать скрипт `example.lua <https://github.com/tarantool/tarantool/blob/1.10/extra/dist/example.lua>`_,  который поставляется вместе с Tarantool и задает все конфигурационные параметры. Директория, где хранятся .snap-файлы; ``tarantoolctl`` добавляет “/имя_экземпляра” к имени директории. Директория, где хранятся pid-файл и socket-файл; ``tarantoolctl`` добавляет “/имя_экземпляра” к имени директории. Директория, где хранятся vinyl-файлы; ``tarantoolctl`` добавляет “/имя_экземпляра” к имени директории. Директория, где хранятся .xlog-файлы; ``tarantoolctl`` добавляет “/имя_экземпляра” к имени директории. Для каждого экземпляра Tarantool’а понадобится два файла: Например, ``/etc/tarantool/instances.enabled/my_app.lua`` (здесь мы загружаем модуль ``my_app.lua`` и вызываем из него функцию ``start()``): Например, ``/usr/share/tarantool/my_app.lua`` (здесь мы реализуем его как  :ref:`Lua-модуль <app_server-modules>`, который запускает базу данных и экспортирует функцию ``start()`` для API -вызовов): Настройка экземпляров Tarantool’а Файл экземпляра Большинство параметров схожи с теми, которые используются в :ref:`box.cfg{} <box_introspection-box_cfg>`. Ниже даны настройки по умолчанию (могут быть установлены в ``/etc/default/tarantool`` или ``/etc/sysconfig/tarantool`` как часть дистрибутива Tarantool'а -- см. пути по умолчанию для разных ОС в :ref:`Замечаниях по поводу некоторых операционных систем <admin-os_notes>`): Директория с экземплярами, которая используется по умолчанию, зависит от параметра ``WITH_SYSVINIT`` сборки Tarantool'а: когда его значение "ON", то ``/etc/tarantool/instances.enabled``, в противном случае ("OFF" или значение не установлено), то ``/etc/tarantool/instances.available``. Последний случай характерен для сборок Tarantool'а для дистрибутивов Linux с ``systemd``. Директория, где хранятся все файлы экземпляра для данного компьютера. Поместите сюда файлы экземпляра или создайте символьные ссылки на них. Директория, где хранятся файлы журнала с сообщениями от Tarantool-приложения; ``tarantoolctl`` добавляет “/имя_экземпляра” к имени директории. Пользователь, запускающий экземпляр Tarantool'а. Это пользователь операционной системы, а не Tarantool-клиента. Став демоном, Tarantool сменит своего пользователя на указанного. Для проверки параметров сборки выполните команду ``tarantool --version``. Файлы экземпляра содержат конфигурацию экземпляра, тогда как конфигурационный файл ``tarantoolctl`` содержит конфигурацию, которую ``tarantoolctl`` использует, чтобы переопределять конфигурацию экземпляров. Другими словами, он содержит общесистемную конфигурацию по умолчанию. Если ``tarantoolctl`` не сможет обнаружить этот файл, используя метод, описанный в разделе :ref:`Запуск/остановка экземпляра <admin-start_stop_instance>`, будут использованы настройки по умолчанию. Файлов экземпляра может быть больше одного. Например, одно и то же приложение в ``/usr/share/tarantool`` может быть запущено на нескольких экземплярах Tarantool'а, у каждого из которых есть свой файл экземпляра. Или в ``/usr/share/tarantool`` может быть несколько приложений, и на каждое из них будет опять же приходиться свой файл экземпляра. [Необязательный] :ref:`Файл приложения <app_server-launching_app>`, содержащий логику данного экземпляра. Поместите его в папку ``/usr/share/tarantool/``. ``instance_dir`` ``log`` ``memtx_dir`` ``pid_file`` ``username`` ``vinyl_dir`` ``wal_dir`` Конфигурационный файл `tarantoolctl` default_cfg = {
    pid_file  = "/var/run/tarantool",
    wal_dir   = "/var/lib/tarantool",
    memtx_dir = "/var/lib/tarantool",
    vinyl_dir = "/var/lib/tarantool",
    log       = "/var/log/tarantool",
    username  = "tarantool",
}
instance_dir = "/etc/tarantool/instances.enabled" local function start()
    box.schema.space.create("somedata")
    box.space.somedata:create_index("primary")
    <...>
end

return {
  start = start;
} где: 