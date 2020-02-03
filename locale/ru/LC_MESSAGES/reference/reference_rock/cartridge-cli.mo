��          �               �    �     �      �  $     k   ?     �     �  r   �     A     T  9   Y  '   �     �  �   �  *   d     �  �   �  y   F     �     �     �  �    �   �	  "   ~
  I   �
  (   �
  =     �  R  �  �  0   �  <   �  :     �   N  c   �     N  %  a  -   �     �  t   �  &   7  @   ^  �   �  �   /     �  >  �  �        �          "  �  ;  �   �  "   �  I   �  (   1  =   Z   # in application directory
cartridge start # starts all instances
cartridge start .router_1 # start single instance

# in multi-application environment
cartridge start app_1 # starts all instances of app_1
cartridge start app_1.router_1 # start single instance Applications lifecycle Cartridge Command Line Interface Create an application from template: Default options for ``cartridge`` command can be overriden in ``./.cartridge.yml`` or ``~/.cartridge.yml``: For more details, run Installation It starts tarantool instance in background with enforced env-vars and waits until app’s main script is finished. Managing instances Misc Optionally you may add ``.rocks/bin`` to executable path: Pack an application into distributable: Running end-to-end tests TARANTOOL_INSTANCE_NAME
TARANTOOL_CFG
TARANTOOL_PID_FILE - %run_dir%/%instance_name%.pid
TARANTOOL_CONSOLE_SOCK - %run_dir%/%instance_name%.pid To stop one or more running instances use: Usage When APP_NAME is not provided it is parsed from ``./*.rockspec`` filename. When ``INSTANCE_NAME`` is not provided cartridge reads ``cfg`` file and starts all defined instances: ``cartridge.cfg()`` uses ``TARANTOOL_INSTANCE_NAME`` to read instance’s config from file provided in ``TARANTOOL_CFG``. cartridge --help cartridge create --name myapp cartridge pack rpm myapp cartridge start [APP_NAME[.INSTANCE_NAME]] [options]

Options
    --script FILE       Application's entry point.
                        Default to TARANTOOL_SCRIPT,
                        or ./init.lua when running from app's directory,
                        or :apps_path/:app_name/init.lua in multi-app env.

    --apps_path PATH    Path to apps direcrory when running in multi-app env.
                        Default to /usr/share/tarantool

    --run_dir DIR       Directory with pid and sock files
                        Default to TARANTOOL_RUN_DIR or /var/run/tarantool

    --cfg FILE          Cartridge instances config file.
                        Default to TARANTOOL_CFG or ./instances.yml

    --foreground        Do not daemonize cartridge stop [APP_NAME[.INSTANCE_NAME]] [options]

These options from `start` command are supported
    --run_dir DIR
    --cfg FILE export PATH=$PWD/.rocks/bin/:$PATH run_dir: tmp/run
cfg: cartrifge.yml
apps_path: /usr/local/share/tarantool tarantoolctl rocks install cartridge-cli vagrant up
vagrant ssh 1_10 < test/end-to-end.sh
vagrant halt Project-Id-Version: Tarantool 1.10
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
 # в директории приложения
cartridge start # запускает все экземпляры
cartridge start .router_1 # запускает отдельный экземпляр

# в среде с несколькими приложениями
cartridge start app_1 # запускает все экземпляры app_1
cartridge start app_1.router_1 # запускает отдельный экземпляр Жизненный цикл приложений Интерфейс командной строки Cartridge Создайте приложение из шаблона: Параметры по умолчанию для ``cartridge`` можно изменить в файле ``./.cartridge.yml`` или ``~/.cartridge.yml``: Чтобы получить более подробную информацию, выполните: Установка Это запустит экземпляр Tarantool'а в фоновом режиме с принудительным использованием переменных окружения и будет ожидать выполнения основного скрипта приложения. Управление экземплярами Разное При желании можно добавить ``.rocks/bin`` к путь к исполняемому файлу: Упакуйте приложение: Выполнение сквозного тестирования TARANTOOL_INSTANCE_NAME
TARANTOOL_CFG
TARANTOOL_PID_FILE - %run_dir%/%instance_name%.pid
TARANTOOL_CONSOLE_SOCK - %run_dir%/%instance_name%.pid Чтобы остановить один или несколько работающих экземпляров, используйте: Использование Если ``ИМЯ_ПРИЛОЖЕНИЯ`` не указано, оно выделяется из имени файла ``./*.rockspec``. Если ``ИМЯ_ЭКЗЕМПЛЯРА`` не указывается, cartridge прочитает файл ``cfg`` и запустит все указанные экземпляры: ``cartridge.cfg()`` использует ``ИМЯ_ЭКЗЕМПЛЯРА_TARANTOOL'А``, чтобы считать настройки экземпляра из файла, который находится в ``TARANTOOL_CFG``. cartridge --help cartridge create --name myapp cartridge pack rpm myapp cartridge start [ИМЯ_ПРИЛОЖЕНИЯ[.ИМЯ_ЭКЗЕМПЛЯРА]] [параметры]

Параметры
    --script FILE       Точка входа в приложение.
                        По умолчанию TARANTOOL_SCRIPT,
                        или ./init.lua, если запуск идет из директории приложения,
                        или :путь_к_приложениям/:имя_приложения/init.lua в среде с несколькими приложениями.

    --apps_path PATH    Путь к директории с приложениями при запуске из среды с несколькими приложениями.
                        По умолчанию /usr/share/tarantool

    --run_dir DIR       Директория с файлами pid и sock 
                        По умолчанию TARANTOOL_RUN_DIR or /var/run/tarantool

    --cfg FILE          Конфигурационный файл для экземпляров Cartridge.
                        По умолчанию TARANTOOL_CFG или ./instances.yml

    --foreground        Не в фоне cartridge stop [ИМЯ_ПРИЛОЖЕНИЯ[.ИМЯ_ЭКЗЕМПЛЯРА]] [параметры]

Поддерживаются следующие параметры из команды `start`
    --run_dir DIR
    --cfg FILE export PATH=$PWD/.rocks/bin/:$PATH run_dir: tmp/run
cfg: cartrifge.yml
apps_path: /usr/local/share/tarantool tarantoolctl rocks install cartridge-cli vagrant up
vagrant ssh 1_10 < test/end-to-end.sh
vagrant halt 