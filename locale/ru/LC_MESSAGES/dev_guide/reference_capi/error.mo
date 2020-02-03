��          �               |  !   }     �  )   �  2   �  -        @  
   O     Z     s  >   �     �  7   �       �       �      0        A     G  
   X     c  �  s  A     1   X  H   �  \   �  -   0	     ^	     s	  +   �	  .   �	  ^   �	     @
  >   U
  7   �
  �  �
    k  �  �  0   x     �  !   �     �     �   A backward-compatible API define. Clear the last error. Error - contains information about error. Get the information about the last API call error. IPROTO :ref:`error code<capi-box_error_code>` Module `error` Parameters Return IPROTO error code Return the error message Return the error type, e.g. "ClientError", "SocketError", etc. Returns See also: IPROTO :ref:`error code<capi-box_error_code>` Set the last error. Successful function can also touch the last error in some cases. You don't have to clear the last error before calling API functions. The returned object is valid only until next call to **any** API function. The Tarantool error handling works most like libc's errno. All API calls return -1 or NULL in the event of error. An internal pointer to box_error_t type is set by API functions to indicate what went wrong. This value is only significant if API call failed (returned -1 or NULL). You must set the last error using box_error_set() in your stored C procedures if you want to return a custom error message. You can re-throw the last API error to IPROTO client by keeping the current value and returning -1 to Tarantool from your stored procedure. enum :ref:`box_error_code <capi-box_error_code>` error format arguments last error not-null string Project-Id-Version: Tarantool 1.10
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
 Обратно совместимые определения API. Удаление последней ошибки. Ошибка -- содержит информацию об ошибке. Получение информации о последней ошибке вызова API. IPROTO :ref:`error code<capi-box_error_code>` Модуль `error` Параметры Возврат кода ошибки IPROTO Возврат сообщения ошибки Возврат типа ошибки, например, "ClientError", "SocketError" и т.д. Возвращает См. также IPROTO :ref:`error code<capi-box_error_code>` Определение последней ошибки. Выполненная функция в некоторых случаях также может затрагивать последнюю ошибку. Необязательно удалять последнюю ошибку перед вызовом API-функций. Возвращаемый объект применим только до следующего вызова **любой** API-функции. Обработка ошибок в Tarantool'е больше всего похожа на errno в стандартной библиотеке языка С libc. Все вызовы API возвращают -1 или NULL в случае ошибки. Внутренний указатель на тип box_error_t задается функциями, чтобы указать, что пошло не так. Это значение показательно, если вызов API не прошел (вернулось -1 или NULL). Следует задать последнюю ошибку с помощью box_error_set() из хранимых процедур на языке C, если необходимо вернуть специальное сообщение об ошибке. Можно повторно сгенерировать последнюю API-ошибку в клиент IPROTO, сохранив текущее значение и вернув -1 to Tarantool из хранимой процедуры. enum :ref:`box_error_code <capi-box_error_code>` ошибка аргументы формата последняя ошибка ненулевая строка 