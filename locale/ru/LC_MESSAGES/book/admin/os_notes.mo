��          �               <  _   =  �   �     >     V     ^  ;   k     �     �  s   �  �   >  y   �  w   G  #  �  >   �  =   "  H   `  H  �  �  �  _   �
  �   �
  ,   �     �     �  a   �     :  ]   A  �   �  K  �  �   �  �   �  �  �  |   7  q   �  �   &  �  �   $ /etc/init.d/your_service_name start
$ tail -f -n 100 /var/log/tarantool/your_service_name.log $ cd /etc/init.d
$ ln -s tarantool your_service_name
$ ln -s /usr/share/tarantool/your_service_name.lua /etc/tarantool/instances.available/your_service_name.lua Checking that it works: FreeBSD Gentoo Linux Here is an example of ``tarantoolctl`` defaults on FreeBSD: Mac OS Notes for operating systems On Mac OS, you can administer Tarantool instances only with ``tarantoolctl``. No native system tools are supported. Tarantool instances can be managed (start/stop/reload/status/...) using OpenRC. Consider the example how to create an OpenRC-managed instance: The default instance directory is ``/etc/tarantool/instances.available``, can be redefined in ``/etc/default/tarantool``. The section below is about a dev-db/tarantool package installed from the official layman overlay (named ``tarantool``). To make ``tarantoolctl`` work along with ``init.d`` utilities on FreeBSD, use paths other than those suggested in :ref:`Instance configuration <admin-instance_config>`. Instead of ``/usr/share/tarantool/`` directory, use ``/usr/local/etc/tarantool/`` and create the following subdirectories: ``default`` for ``tarantoolctl`` defaults (see example below), ``instances.available`` for all available instance files, and ``instances.enabled`` for instance files to be auto-started by sysvinit. default_cfg = {
    pid_file   = "/var/run/tarantool", -- /var/run/tarantool/${INSTANCE}.pid
    wal_dir    = "/var/db/tarantool", -- /var/db/tarantool/${INSTANCE}/
    snap_dir   = "/var/db/tarantool", -- /var/db/tarantool/${INSTANCE}
    vinyl_dir = "/var/db/tarantool", -- /var/db/tarantool/${INSTANCE}
    logger     = "/var/log/tarantool", -- /var/log/tarantool/${INSTANCE}.log
    username   = "tarantool",
}

-- instances.available - all available instances
-- instances.enabled - instances to autostart by sysvinit
instance_dir = "/usr/local/etc/tarantool/instances.available" Project-Id-Version: Tarantool 1.10
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
 $ /etc/init.d/your_service_name start
$ tail -f -n 100 /var/log/tarantool/your_service_name.log $ cd /etc/init.d
$ ln -s tarantool your_service_name
$ ln -s /usr/share/tarantool/your_service_name.lua /etc/tarantool/instances.available/your_service_name.lua Проверяем, что работает: FreeBSD Gentoo Linux Так выглядят настройки ``tarantoolctl`` по умолчанию на FreeBSD: Mac OS Замечания по поводу некоторых операционных систем Администрирование экземпляров Tarantool'а на Mac OS возможно только с помощью ``tarantoolctl``. Встроенные системные инструменты не поддерживаются. Управление экземплярами Tarantool'а (запуск/остановка/перезагрузка/проверка статуса и т.д.) можно осуществлять с помощью OpenRC. Рассмотрим пример, как создать экземпляр с управлением OpenRC: По умолчанию с экземплярами используется директория ``/etc/tarantool/instances.available``,  ее можно переопределить в ``/etc/default/tarantool``. В разделе ниже описывается пакет "dev-db/tarantool", установленный из официального оверлея layman (под названием ``tarantool``). Чтобы ``tarantoolctl`` и утилиты ``init.d`` работали на FreeBSD, используйте пути, отличные от предложенных в разделе :ref:`Настройка экземпляров Tarantool’а <admin-instance_config>`. Используйте ``/usr/local/etc/tarantool/`` вместо ``/usr/share/tarantool/`` и создайте  следующие поддиректории: ``default`` для хранения настроек ``tarantoolctl`` по умолчанию (см. пример ниже), ``instances.available`` для хранения всех доступных файлов экземпляра, и ``instances.enabled`` для хранения файлов экземпляра, которые необходимо запускать автоматически с помощью sysvinit. default_cfg = {
    pid_file   = "/var/run/tarantool", -- /var/run/tarantool/${INSTANCE}.pid
    wal_dir    = "/var/db/tarantool", -- /var/db/tarantool/${INSTANCE}/
    snap_dir   = "/var/db/tarantool", -- /var/db/tarantool/${INSTANCE}
    vinyl_dir = "/var/db/tarantool", -- /var/db/tarantool/${INSTANCE}
    logger     = "/var/log/tarantool", -- /var/log/tarantool/${INSTANCE}.log
    username   = "tarantool",
}

-- instances.available - все доступные экземпляры
-- instances.enabled - экземпляры для автоматического запуска через sysvinit
instance_dir = "/usr/local/etc/tarantool/instances.available" 