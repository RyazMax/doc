��          �               �      �   �  
  
   �     �  �   �  |   �  #   5      Y  !   z  @   �     �  '   �  h     �  u       {  *     �
  )   �
  g  �
  �   K  P     Z   e  K   �  �        �  '     h   ,   **Example:** A particular use is for :ref:`box_once() <box-once>`. For example, when a replica is initializing, it may call a ``box.once()`` function while the server is still in read-only mode, and fail to make changes that are necessary only once before the replica is fully initialized. This could cause conflicts between a master and a replica if the master is in read-write mode and the replica is in read-only mode. Waiting until "read only mode = false" solves this problem. Parameters Submodule `box.ctl` The ``box.ctl`` submodule contains two functions: ``wait_ro`` (wait until read-only) and ``wait_rw`` (wait until read-write). The functions are useful during initialization of a server. To see whether a function is already in read-only or read-write mode, check :ref:`box.info.ro <box_introspection-box_info>`. Wait until ``box.info.ro`` is true. Wait until box.info.ro is false. maximum number of seconds to wait nil, or error may be thrown due to timeout or fiber cancellation return tarantool> box.ctl.wait_rw(0.1)
---
... tarantool> box.info().ro
---
- false
...

tarantool> n = box.ctl.wait_ro(0.1)
---
- error: timed out
... Project-Id-Version: Tarantool 1.10
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
 **Пример:** Для :ref:`box_once() <box-once>` есть особое предназначение. Например, при инициализации реплика может вызвать функцию ``box.once()``, пока сервер все еще находится в режиме только для чтения, и не сможет применить изменения однократно до окончательной инициализации реплики. Это может привести к конфликту между мастером и репликой, если мастер находится в режиме чтения и записи, а реплика доступна только для чтения. Ожидание условия "read only mode = false" (режим только для чтения отключен) решает эту проблему. Параметры Вложенный модуль `box.ctl` Вложенный модуль ``box.ctl`` включает в себя две функции: ``wait_ro`` (дождаться режима только для чтения) и ``wait_rw`` (дождаться режима чтения и записи). Эти функции используются во время инициализации сервера. Чтобы проверить режим функции -- только для чтения или чтение и запись, используйте :ref:`box.info.ro <box_introspection-box_info>`. Дождаться, пока не будет выполнено ``box.info.ro``. Дождаться, пока не перестанет соблюдаться box.info.ro. максимальное количество секунд ожидания нулевое значение nil или ошибка, которая может возникнуть из-за превышения времени ожидания или прерывания работы файбера возвращается tarantool> box.ctl.wait_rw(0.1)
---
... tarantool> box.info().ro
---
- false
...

tarantool> n = box.ctl.wait_ro(0.1)
---
- error: timed out
... 