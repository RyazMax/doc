��          �               L  /   M  &   }     �  V   �       
   &     1     =  ?   E  C   �     �     �     �     �               !  5   :  �  p  Y     K   m  <   �  �   �     �     �     �     �  �     �   �  #   H     l     z  !   �  %   �  #   �     �  \   	   A lock for cooperative multitasking environment Allocate and initialize the new latch. Destroy and free the latch. Lock a latch. Waits indefinitely until the current fiber can gain access to the latch. Module `latch` Parameters Return type Returns Try to lock a latch. Return immediately if the latch is locked. Unlock a latch. The fiber calling this function must own the latch. allocated latch object box_latch_t * int latch to destroy latch to lock latch to unlock param box_latch_t* latch status of operation. 0 - success, 1 - latch is locked Project-Id-Version: Tarantool 1.10
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
 Блокировка среды кооперативной многозадачности Выделение и инициализация новой защелки. Удаление и освобождение защелки. Применение защелки. Бесконечно ожидает момента, когда текущий файбер может получить доступ к защелке. Модуль `latch` Параметры Возвращаемый тип Возвращает Попытка применить защелку. Возвращается незамедлительно, если защелка поставлена. Отмена защелки. Файбер, который вызывает данную функцию, должен иметь права на защелку. выделенная защелка box_latch_t * целое число удаляемая защелка применяемая защелка отменяемая защелка param box_latch_t* latch статус операции. 0 -- успешно, 1 -- защелка поставлена 