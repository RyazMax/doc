��    !      $              ,     -      :     [  �   z  3     )   9     c  Q   �     �     �     �            
          ~   %  l   �  <        N  /   R  (   �     �  %   �     �       4     }   T     �     �     �  �   �  c   k  �  �     r	      �	     �	    �	  K   �
  X     0   x  q   �  <        X     k     ~     �     �     �  �   �    �  s   �     *  G   ?  L   �     �  %   �       H   .  \   w  �   �     �  2   �       �   &  c   �   **Example:** :ref:`uri.format() <uri-format>` :ref:`uri.parse() <uri-parse>` A "URI" is a "Uniform Resource Identifier". The `IETF standard <https://www.ietf.org/rfc/rfc2396.txt>`_ says a URI string looks like this: A common type, a hierarchical URI, looks like this: Below is a list of all ``uri`` functions. Construct a URI from components For example the string ``'https://tarantool.org/x.html#y'`` has three components: Get a table of URI components Index Module `uri` Name Overview Parameters Table Tarantool's URI module provides routines which convert URI strings into their components, or turn components into URI strings. URI-components-table. Possible components are fragment, host, login, password, path, query, scheme, service. URI-string. Thus uri.format() is the reverse of uri.parse(). Use [scheme:][//authority][path][?query][#fragment] [scheme:]scheme-specific-part[#fragment] ``https`` is the scheme, ``tarantool.org/x.html`` is the path, ``y`` is the fragment. a Uniform Resource Identifier a series of name:value pairs, one for each component boolean. If this is supplied and is ``true``, then the password component is rendered in clear text, otherwise it is omitted. return rtype string tarantool> uri = require('uri')
---
...

tarantool> uri.parse('http://x.html#y')
---
- host: x.html
  scheme: http
  fragment: y
... tarantool> uri.format({host = 'x.html', scheme = 'http', fragment = 'y'})
---
- http://x.html#y
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
 **Пример:** :ref:`uri.format() <uri-format>` :ref:`uri.parse() <uri-parse>` URI -- это Унифицированный идентификатор ресурса (Uniform Resource Identifier). Согласно `стандарту IETF <https://www.ietf.org/rfc/rfc2396.txt>`_, URI-строка выглядит следующим образом: Общий тип, иерархический URI, выглядит так: Ниже приведен перечень всех функций модуля ``uri``. Создание URI из компонентов Например, строка ``'https://tarantool.org/x.html#y'`` содержит три компонента: Получение таблицы URI-компонентов Указатель Модуль `uri` Имя Общие сведения Параметры Таблица Модуль Tarantool'а URI включает в себя процедуры для разложения URI-строк на компоненты или объединения компонентов в URI-строку. таблица с компонентами URI. Доступные компоненты: fragment (фрагмент), host (хост), login (имя для входа), password (пароль), path (путь), query (запрос), scheme (схема), service (сервис). URI-строка. Таким образом, uri.format() -- это операция, обратная uri.parse(). Назначение [схема:][//адрес][путь][?запрос][#фрагмент] [схема:]специальная-часть-схемы[#фрагмент] ``https`` -- схема, ``tarantool.org/x.html`` -- путь, ``y`` -- фрагмент. Унифицированный идентификатор ресурса ряд пар ключ-значение, одна для каждого компонента логическое значение. Если указать значение ``true``, то компонент пароля отображается открытым текстом, в остальных случаях не отображается. возвращает тип возвращаемого значения строка tarantool> uri = require('uri')
---
...

tarantool> uri.parse('http://x.html#y')
---
- host: x.html
  scheme: http
  fragment: y
... tarantool> uri.format({host = 'x.html', scheme = 'http', fragment = 'y'})
---
- http://x.html#y
... 