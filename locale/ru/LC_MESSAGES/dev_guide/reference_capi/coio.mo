��          �               <     =  4   J       N   �  m   �  4   H     }  
   �  
   �     �  �   �     �  :   �  $   �  N     4   \     �  �  �     H  L   Z     �  ~   �  �   F  =        U     i      |     �    �  !   �
  �   �
  H   |  w   �  ;   =  0   y   **Example:** -1 and ``errno`` = ENOMEM if failed to create a task 0 - timeout >0 - returned events. Combination of ``TNT_IO_READ | TNT_IO_WRITE`` bit flags. Close the ``fd`` and wake any fiber blocked in :ref:`coio_wait() <c_api-coio-coio_wait>` call on this ``fd``. Fiber-friendly version of :manpage:`getaddrinfo(3)`. Module `coio` Parameters READ event Returns To avoid double error checking, this function does not throw exceptions. In most cases it is also necessary to check the return value of the called function and perform necessary actions. If func sets errno, the errno is preserved across the call. WRITE event Wait until READ or WRITE event on socket (``fd``). Yields. non-blocking socket file description requested events to wait. Combination of ``COIO_READ | COIO_WRITE`` bit flags. the result of ``close(fd)``, see :manpage:`close(2)` timeout in seconds. Project-Id-Version: Tarantool 1.10
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2020-02-03 19:10+0000
PO-Revision-Date: 2019-11-14 20:46+0300
Last-Translator: 
Language: ru
Language-Team: 
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
 **Пример:** -1 и ``errno`` = ENOMEM, если задача не была создана 0 - время ожидания >0 - возвращаемые события. Комбинация битовых флагов ``TNT_IO_READ | TNT_IO_WRITE``. Закрытие ``fd`` и пробуждение любого файбера, заблокированного в вызове :ref:`coio_wait() <c_api-coio-coio_wait>` на данном сокете ``fd``. Версия :manpage:`getaddrinfo(3)` для файбера. Модуль `coio` Параметры событие чтения READ Возвращает Во избежание двойной проверки ошибок функция не выбрасывает исключения. В большинстве случаев также необходимо проверять возвращаемое значение вызванной функции и выполнить необходимые действия. Если функция определяет номер ошибки errno, этот номер ошибки сохраняется в течение вызова. событие записи WRITE Ожидание события чтения или записи (READ / WRITE) на сокете (``fd``) с передачей управления. дескриптор файла сокета без блокировки запрашиваемые события. Комбинация битовых флагов ``COIO_READ | COIO_WRITE``. результат ``close(fd)``, см. :manpage:`close(2)` время ожидания в секундах. 