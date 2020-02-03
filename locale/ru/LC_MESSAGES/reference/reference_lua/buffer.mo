��          �               �      �   D  
  �   O     �  �     �     0   �     �  
  �     �            s     �  �     (	  �  :	  
         �  '  #    j   4  "   �  
  �     �     �  2   �  s      **Example:** Assume a Tarantool server is listening on farhost:3301. Assume it has a space ``T`` with one tuple: ``'ABCDE', 12345``. In this example we start up a server on localhost:3302 and then use ``net.box`` routines to connect to farhost. Then we create a buffer, and use it as an option for a ``conn.space...select()`` call. The result will be in MsgPack_ format. To show this, we will use :ref:`msgpack.decode_unchecked() <msgpack-decode_unchecked>` on ``ibuf.rpos`` (the "read position" of the buffer). Thus we do not decode on the remote server, but we do decode on the local server. Before Tarantool version 1.7.7, the function to use for this case is ``msgpack.ibuf_decode(ibuf.rpos)``. Starting with Tarantool version 1.7.7, ``ibuf_decode`` is deprecated. Module `buffer` Ordinarily the ``net.box`` methods return a Lua table. If a ``buffer`` option is used, then the ``net.box`` methods return a raw MsgPack_ string. This saves time on the server, if the client application has its own routine for decoding MsgPack strings. The ``buffer`` module returns a dynamically resizable buffer which is solely for use as an option for methods of the :ref:`net.box module <net_box-module>`. The result of the final request looks like this: a descriptor of a buffer. box.cfg{listen=3302}
buffer = require('buffer')
ibuf = buffer.ibuf()
net_box = require('net.box')
conn = net_box.connect('farhost:3301')
buffer = require('buffer')
conn.space.T:select({},{buffer=ibuf})
msgpack = require('msgpack')
msgpack.decode_unchecked(ibuf.rpos) cdata return rtype tarantool> msgpack.decode_unchecked(ibuf.rpos)
---
- {48: [['ABCDE', 12345]]}
- 'cdata<char *>: 0x7f97ba10c041'
... Project-Id-Version: Tarantool 1.10
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
 **Пример:** Предположим, что Tarantool-сервер настроен на прослушивание на farhost:3301. Предположим, что на нем есть спейс ``T`` с одним кортежем: ``'ABCDE', 12345``. В данном примере запустим сервер на localhost:3302, а затем используем процедуры ``net.box`` для подключения к farhost. Затем создадим буфер и используем его как опцию для вызова ``conn.space...select()``. Результат получим в формате MsgPack_. Чтобы показать это, используем :ref:`msgpack.decode_unchecked() <msgpack-decode_unchecked>` на ``ibuf.rpos`` ("позиция для чтения" в буфере). Таким образом, мы проведем декодирование не на удаленном сервере, а на локальном. До версии 1.7.7 Tarantool'а в данном случае следует использовать функцию ``msgpack.ibuf_decode(ibuf.rpos)``. Начиная с версии  1.7.7 Tarantool'а , ``ibuf_decode`` объявлена устаревшей. Модуль `buffer` Как правило, модуль ``net.box`` возвращает Lua-таблицу. Если используется опция ``buffer``, то методы модуля ``net.box`` возвращают неформатированную строку MsgPack_. Это экономит время работы на сервере, если в клиентском приложении есть собственная процедура декодирования MsgPack-строк. Модуль ``buffer`` возвращает буфер, допускающий динамическое изменение размера, который используется только в качестве опции для методов :ref:`модуля net.box <net_box-module>`. Результат последнего запроса выглядит следующим образом: дескриптор буфера. box.cfg{listen=3302}
buffer = require('buffer')
ibuf = buffer.ibuf()
net_box = require('net.box')
conn = net_box.connect('farhost:3301')
buffer = require('buffer')
conn.space.T:select({},{buffer=ibuf})
msgpack = require('msgpack')
msgpack.decode_unchecked(ibuf.rpos) cdata. возвращает тип возвращаемого значения tarantool> msgpack.decode_unchecked(ibuf.rpos)
---
- {48: [['ABCDE', 12345]]}
- 'cdata<char *>: 0x7f97ba10c041'
... 