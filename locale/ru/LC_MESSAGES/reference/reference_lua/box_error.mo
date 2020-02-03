��    "      ,              <     =  $   J  *   o  (   �  &   �  /   �           5  �   V  ]  /     �  #   �     �     �     �  
   �     �     �       y     U   �     �  (   �            ,   *  2   W     �     �    �    �  4  �	  (   �
  �       �  $   �  *   �  (   "  &   K  ^   r  /   �  1     k  3  �  �     �  C   �     �     �             +   3     _     w  �   �  �   �     	  Y        j  E   �  i   �  S   0     �  2   �    �    �  	  �  4   �   **Example:** :ref:`box.error() <box_error-error>` :ref:`box.error.clear() <box_error-clear>` :ref:`box.error.last() <box_error-last>` :ref:`box.error.new() <box_error-new>` Below is a list of all ``box.error`` functions. Clear the record of errors Create an error but do not throw Create an error object, but do not throw. This is useful when error information should be saved for later retrieval. The parameters are the same as for :ref:`box.error() <box_error-error>`, see the description there. Emulate a request error, with text based on one of the pre-defined Tarantool errors defined in the file `errcode.h <https://github.com/tarantool/tarantool/blob/1.10/src/box/errcode.h>`_ in the source tree. Lua constants which correspond to those Tarantool errors are defined as members of ``box.error``, for example ``box.error.NO_SUCH_USER == 45``. For example: Get a description of the last error Index Name Overview Parameters Submodule `box.error` Throw an error Use When called with a Lua-table argument, the code and reason have any user-desired values. The result will be those values. When called without arguments, ``box.error()`` re-throws whatever the last error was. cdata description of an error, defined by user except number of a pre-defined error numeric code for this error, defined by user part of the message which will accompany the error return rtype tarantool> box.error{code = 555, reason = 'Arbitrary message'}
---
- error: Arbitrary message
...
tarantool> box.error()
---
- error: Arbitrary message
...
tarantool> box.error(box.error.FUNCTION_ACCESS_DENIED, 'A', 'B', 'C')
---
- error: A access denied for user 'B' to function 'C'
... tarantool> e = box.error.new{code = 555, reason = 'Arbitrary message'}
---
...
tarantool> e:unpack()
---
- type: ClientError
  code: 555
  message: Arbitrary message
  trace:
  - file: '[string "e = box.error.new{code = 555, reason = ''Arbit..."]'
    line: 1
... the ``NO_SUCH_USER`` message is "``User '%s' is not found``" -- it includes one "``%s``" component which will be replaced with errtext. Thus a call to ``box.error(box.error.NO_SUCH_USER, 'joe')`` or ``box.error(45, 'joe')`` will result in an error with the accompanying message "``User 'joe' is not found``". whatever is specified in errcode-number. Project-Id-Version: Tarantool 1.10
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
 **Пример:** :ref:`box.error() <box_error-error>` :ref:`box.error.clear() <box_error-clear>` :ref:`box.error.last() <box_error-last>` :ref:`box.error.new() <box_error-new>` Ниже приведен перечень всех функций модуля ``box.error``. Очистка записи об ошибках Создание ошибки без выдачи Создание ошибки без выдачи. Используется, когда необходимо сохранить информацию об ошибке для последующей выборки. Используются такие же параметры, как в :ref:`box.error() <box_error-error>`, см. описание по ссылке. Моделирование ошибки запроса с текстом на основе одной из ошибок Tarantool'а, заданных в файле `errcode.h <https://github.com/tarantool/tarantool/blob/1.10/src/box/errcode.h>`_ в исходном дереве. Lua-постоянные, которые соответствуют этим ошибкам в Tarantool'е, определяются как элементы ``box.error``, например ``box.error.NO_SUCH_USER == 45``. Пример: Получение описания последней ошибки Указатель Имя Общие сведения Параметры Вложенный модуль `box.error` Вызов ошибки Назначение При вызове с аргументом из Lua-таблицы значения параметров code и reason будут любыми по желанию пользователя. Результатом будут эти значения. При вызове без аргументов ``box.error()`` повторно вызывает последнюю ошибку. cdata. (строка) описание ошибки, задается пользователем Исключение: номер предварительно заданной ошибки (целое число) числовой код ошибки, задается пользователем часть сообщения, которое сопровождает ошибку возвращает тип возвращаемого значения tarantool> box.error{code = 555, reason = 'Arbitrary message'}
---
- error: Arbitrary message
...
tarantool> box.error()
---
- error: Arbitrary message
...
tarantool> box.error(box.error.FUNCTION_ACCESS_DENIED, 'A', 'B', 'C')
---
- error: A access denied for user 'B' to function 'C'
... tarantool> e = box.error.new{code = 555, reason = 'Arbitrary message'}
---
...
tarantool> e:unpack()
---
- type: ClientError
  code: 555
  message: Arbitrary message
  trace:
  - file: '[string "e = box.error.new{code = 555, reason = ''Arbit..."]'
    line: 1
... сообщение ``NO_SUCH_USER`` = "``User '%s' is not found``" (пользователь не найден) -- оно включает в себя компонент "``%s``", который будет заменен значением параметра errtext. Таким образом, вызов ``box.error(box.error.NO_SUCH_USER, 'joe')`` или ``box.error(45, 'joe')`` приведет к ошибке с сообщением "``User 'joe' is not found``" (пользователь 'joe' не найден). то, что указано в номере errcode. 