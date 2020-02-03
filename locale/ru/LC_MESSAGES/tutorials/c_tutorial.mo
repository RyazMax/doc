��    w      �              �  �  �    L	  �  j  �  O    �      �  F   �  %   D  )   j  +   �  %   �  '   �  $         3     T     d  
   t          �  
   �     �  <   �  :   �  J   )  N   t  H   �  K     .   X  �   �  #   (  ~  L  .  �     �  
     -     @   G  B   �  C   �  @     A   P  )   �  �   �  �   q   �   !  =   �!  >   ,"  ?   k"  <   �"  =   �"  B  &#  +  i$  _   �%  \   �%  k   R&  U   �&  >   '  l   S'  V   �'  �   (  q   �(  ~   b)  �   �)  �   ~*  �   5+  L   �+  5   @,  �   v,  /   r-  H   �-  �   �-  u   t.     �.  F  �.  *  @0  �   k2  �   3  >   �3  E   4  F   ^4  !   �4  I  �4  �   6    �6  5  8  .   D9  -   s9  /   �9  �   �9  �   :  8   k;  &   �;     �;  �   �;  �   �<  �   =    �=  �   �>  �   �?  �   g@     9A     VA  `   lA  C   �A  6   B  *   HB  e  sB  )   �C     D  l   D     �D  ,   �D     �D  G   �D  @   #E  y   dE  ]   �E  <   <F  �   yF  �  YG  �  �H    �J  �  �L  �  �T    sX      {Y  F   �Y  %   �Y  )   	Z  +   3Z  %   _Z  '   �Z  $   �Z  /   �Z     [     "[  
   ;[     F[     S[  
   a[     l[  V   x[  B   �[  w   \  �   �\  �   ]  �   �]  Y   ^  �   r^  ]   F_  �  �_  �  'b  5   �c  .   �c  b   d  �   ud  �   �d  �   �e  �   f  �   �f  7   -g  4  eg  I  �h  �  �i  �   |k     l  �   �l     m  �   �m    n  �  	p  ~   	r  n   �r  �   �r  u   |s  e   �s  �   Xt  �   �t  �   �u  �   �v  )  Tw  �   ~x  �   uy  &  bz  s   �{  h   �{  ~  f|  ^   �}  �   D~  �   �~  �   �     i�  �  x�  6  �  .  H�  @  w�  ;   ��  d   �  e   Y�  U   ��    �  3  �  �  P�  �  ӎ  W   s�  U   ː  Q   !�  �   s�  �  \�  a   6�  ;   ��     Ԕ  �   �  �   ��  �   �    ��  �   ɗ  �   ��  �   p�     B�  ,   _�  �   ��  t   �  b   ��  D   �  �  1�  ?   ��  '   ��  �   �  1   ��  8   �  &   �  G   B�  @   ��  y   ˠ  ]   E�  <   ��  Y  �   #include "module.h"
#include "msgpuck.h"
int harder(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  uint32_t arg_count = mp_decode_array(&args);
  printf("arg_count = %d\n", arg_count);
  uint32_t field_count = mp_decode_array(&args);
  printf("field_count = %d\n", field_count);
  uint32_t val;
  int i;
  for (i = 0; i < field_count; ++i)
  {
    val = mp_decode_uint(&args);
    printf("val=%d.\n", val);
  }
  return 0;
} #include "module.h"
#include "msgpuck.h"
int hardest(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  uint32_t space_id = box_space_id_by_name("capi_test", strlen("capi_test"));
  char tuple[1024]; /* Must be big enough for mp_encode results */
  char *tuple_pointer = tuple;
  tuple_pointer = mp_encode_array(tuple_pointer, 2);
  tuple_pointer = mp_encode_uint(tuple_pointer, 10000);
  tuple_pointer = mp_encode_str(tuple_pointer, "String 2", 8);
  int n = box_insert(space_id, tuple, tuple_pointer, NULL);
  return n;
} #include "module.h"
#include <msgpuck.h>
int read(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  char tuple_buf[1024];      /* where the raw MsgPack tuple will be stored */
  uint32_t space_id = box_space_id_by_name("capi_test", strlen("capi_test"));
  uint32_t index_id = 0;     /* The number of the space's first index */
  uint32_t key = 10000;      /* The key value that box_insert() used */
  mp_encode_array(tuple_buf, 0); /* clear */
  box_tuple_format_t *fmt = box_tuple_format_default();
  box_tuple_t *tuple = box_tuple_new(fmt, tuple_buf, tuple_buf+512);
  assert(tuple != NULL);
  char key_buf[16];          /* Pass key_buf = encoded key = 1000 */
  char *key_end = key_buf;
  key_end = mp_encode_array(key_end, 1);
  key_end = mp_encode_uint(key_end, key);
  assert(key_end < key_buf + sizeof(key_buf));
  /* Get the tuple. There's no box_select() but there's this. */
  int r = box_index_get(space_id, index_id, key_buf, key_end, &tuple);
  assert(r == 0);
  assert(tuple != NULL);
  /* Get each field of the tuple + display what you get. */
  int field_no;             /* The first field number is 0. */
  for (field_no = 0; field_no < 2; ++field_no)
  {
    const char *field = box_tuple_field(tuple, field_no);
    assert(field != NULL);
    assert(mp_typeof(*field) == MP_STR || mp_typeof(*field) == MP_UINT);
    if (mp_typeof(*field) == MP_UINT)
    {
      uint32_t uint_value = mp_decode_uint(&field);
      printf("uint value=%u.\n", uint_value);
    }
    else /* if (mp_typeof(*field) == MP_STR) */
    {
      const char *str_value;
      uint32_t str_value_length;
      str_value = mp_decode_str(&field, &str_value_length);
      printf("string value=%.*s.\n", str_value_length, str_value);
    }
  }
  return 0;
} #include "module.h"
#include <msgpuck.h>
int write(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  static const char *space = "capi_test";
  char tuple_buf[1024]; /* Must be big enough for mp_encode results */
  uint32_t space_id = box_space_id_by_name(space, strlen(space));
  if (space_id == BOX_ID_NIL) {
    return box_error_set(__FILE__, __LINE__, ER_PROC_C,
    "Can't find space %s", "capi_test");
  }
  char *tuple_end = tuple_buf;
  tuple_end = mp_encode_array(tuple_end, 2);
  tuple_end = mp_encode_uint(tuple_end, 1);
  tuple_end = mp_encode_uint(tuple_end, 22);
  box_txn_begin();
  if (box_replace(space_id, tuple_buf, tuple_end, NULL) != 0)
    return -1;
  box_txn_commit();
  fiber_sleep(0.001);
  struct tuple *tuple = box_tuple_new(box_tuple_format_default(),
                                      tuple_buf, tuple_end);
  return box_return_tuple(ctx, tuple);
} #include "module.h"
int easy(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  printf("hello world\n");
  return 0;
}
int easy2(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  printf("hello world -- easy2\n");
  return 0;
} $ dnf -y install tarantool-devel $ export CPATH=/usr/local/include/tarantool:/usr/local/include/msgpuck $ gcc -shared -o easy.so -fPIC easy.c $ gcc -shared -o harder.so -fPIC harder.c $ gcc -shared -o hardest.so -fPIC hardest.c $ gcc -shared -o read.so -fPIC read.c $ gcc -shared -o write.so -fPIC write.c $ sudo apt-get install tarantool-dev **An example in the test suite** **Cleaning up** **Preparation** **easy.c** **harder.c** **hardest.c** **read.c** **write.c** ... and this time the result will be "hello world -- easy2". :ref:`easy.c <f_c_tutorial-easy>` -- prints "hello world"; :ref:`harder.c <f_c_tutorial-harder>` -- decodes a passed parameter value; :ref:`hardest.c <f_c_tutorial-hardest>` -- uses the C API to do a DBMS insert; :ref:`read.c <f_c_tutorial-read>` -- uses the C API to do a DBMS select; :ref:`write.c <f_c_tutorial-write>` -- uses the C API to do a DBMS replace. A gcc compiler, any modern version should work After following the instructions, and seeing that the results are what is described here, users should feel confident about writing their own stored procedures. And now the screen looks like this: At this point the ``harder()`` function will start using functions defined in `msgpuck.h <http://rtsisyk.github.io/msgpuck>`_. The routines that begin with "mp" are msgpuck functions that handle data formatted according to the MsgPack_ specification. Passes and returns are always done with this format so one must become acquainted with msgpuck to become proficient with the C API. Both ``module.h`` and ``msgpuck.h`` must be on the include path for the C compiler to see them. For example, if ``module.h`` address is ``/usr/local/include/tarantool/module.h``, and ``msgpuck.h`` address is ``/usr/local/include/msgpuck/msgpuck.h``, and they are not currently on the include path, say: C stored procedures C tutorial Check that these items exist on the computer: Compile the program, producing a library file named ``easy.so``: Compile the program, producing a library file named ``harder.so``: Compile the program, producing a library file named ``hardest.so``: Compile the program, producing a library file named ``read.so``: Compile the program, producing a library file named ``write.so``: Conclusion: calling a C function is easy. Conclusion: decoding parameter values passed to a C function is not easy at first, but there are routines to do the job, and they're documented, and there aren't very many of them. Conclusion: parts of the standard test suite use C stored procedures, and they must work, because releases don't happen if Tarantool doesn't pass the tests. Conclusion: the long description of the whole C API is there for a good reason. All of the functions in it can be called from C functions which are called from Lua. So C "stored procedures" have full access to the database. Create a file. Name it ``easy.c``. Put these six lines in it. Create a file. Name it ``harder.c``. Put these 17 lines in it: Create a file. Name it ``hardest.c``. Put these 13 lines in it: Create a file. Name it ``read.c``. Put these 43 lines in it: Create a file. Name it ``write.c``. Put these 24 lines in it: Download the source code of Tarantool. Look in a subdirectory :code:`test/box`. Notice that there is a file named :code:`tuple_bench.test.lua` and another file named :code:`tuple_bench.c`. Examine the Lua file and observe that it is calling a function in the C file, using the same techniques that this tutorial has shown. For now, though, it's enough to know that ``mp_decode_array()`` returns the number of elements in an array, and ``mp_decode_uint`` returns an unsigned integer, from :code:`args`. And there's a side effect: when the decoding finishes, :code:`args` has changed and is now pointing to the next element. Get rid of each of the function tuples with :ref:`box.schema.func.drop <box_schema-func_drop>`. Get rid of the ``capi_test`` space with :ref:`box.schema.capi_test:drop() <box_space-drop>`. Go back to the shell where the ``easy.c`` and the ``harder.c`` and the ``hardest.c`` programs were created. Go back to the shell where the ``easy.c`` and the ``harder.c`` programs were created. Go back to the shell where the ``easy.c`` program was created. Go back to the shell where the programs ``easy.c``, ``harder.c``, ``hardest.c`` and ``read.c`` were created. Here is one C tutorial: :ref:`C stored procedures <f_c_tutorial-c_stored_procedures>`. If these requests appear unfamiliar, re-read the descriptions of :ref:`box.schema.func.create() <box_schema-func_create>`, :ref:`box.schema.user.grant() <box_schema-user_grant>` and :ref:`conn:call() <net_box-call>`. In plainer language: create a space named ``capi_test``, and make a connection to self named ``capi_connection``. In this tutorial, which can be followed by anyone with a Tarantool development package and a C compiler, there are five tasks: Its first job is to find the 'easy' function, which should be easy because by default Tarantool looks on the current directory for a file named ``easy.so``. Its second job is to call the 'easy' function. Since the ``easy()`` function in ``easy.c`` begins with ``printf("hello world\n")``, the words "hello world" will appear on the screen. Its third job is to check that the call was successful. Since the ``easy()`` function in ``easy.c`` ends with :code:`return 0`, there is no error message to display and the request is over. Leave the client running. It will be necessary to enter more requests later. Now go back to the client and execute these requests: Now let's call the other function in easy.c -- ``easy2()``. This is almost the same as the ``easy()`` function, but there's a detail: when the file name is not the same as the function name, then we have to specify :samp:`{file-name}.{function-name}`. Now, still on the client, execute this request: Remove the ``.c`` and ``.so`` files that were created for this tutorial. Requests will be done using Tarantool as a :ref:`client <admin-using_tarantool_as_a_client>`. Start Tarantool, and enter these requests. Start another shell. Change directory (``cd``) so that it is the same as the directory that the client is running on. Tarantool 1.10 Tarantool can call C code with :ref:`modules <app_server-modules>`, or with :ref:`ffi <cookbook-ffi_printf>`, or with C stored procedures. This tutorial only is about the third option, C stored procedures. In fact the routines are always "C functions" but the phrase "stored procedure" is commonly used for historical reasons. The ``libmsgpuck.a`` static library is necessary with msgpuck versions produced after February 2017. If and only if you encounter linking problems when using the gcc statements in the examples for this tutorial, you should put ``libmsgpuck.a`` on the path (``libmsgpuck.a`` is produced from both msgpuck and Tarantool source downloads so it should be easy to find). For example, instead of ":code:`gcc -shared -o harder.so -fPIC harder.c`" for the second example below, you will need to say ":code:`gcc -shared -o harder.so -fPIC harder.c libmsgpuck.a`". The ``module.h`` file will exist if Tarantool was installed from source. Otherwise Tarantool's "developer" package must be installed. For example on Ubuntu say: The ``msgpuck.h`` file will exist if Tarantool was installed from source. Otherwise the "msgpuck" package must be installed from `https://github.com/rtsisyk/msgpuck <https://github.com/rtsisyk/msgpuck>`_. The function that matters is ``capi_connection:call('easy')``. The result of ``capi_connection:call('read')`` should look like this: The result of ``capi_connection:call('write')`` should look like this: The result should look like this: Therefore the first displayed line will be "arg_count = 1" because there was only one item passed: ``passable_table``. |br| The second displayed line will be "field_count = 3" because there are three items in the table. |br| The next three lines will be "1" and "2" and "3" because those are the values in the items in the table. This proves that the ``hardest()`` function succeeded, but where did :ref:`box_space_id_by_name() <box-box_space_id_by_name>` and :ref:`box_insert() <box-box_insert>` come from? Answer: the :ref:`C API <index-c_api_reference>`. This proves that the ``read()`` function succeeded. Once again the important functions that start with `box` -- :ref:`box_index_get() <c_api-box_index-box_index_get>` and :ref:`box_tuple_field() <c_api-tuple-box_tuple_field>` -- came from the :ref:`C API <index-c_api_reference>`. This proves that the ``write()`` function succeeded. Once again the important functions that start with `box` -- :ref:`box_txn_begin() <txn-box_txn_begin>`, :ref:`box_txn_commit() <txn-box_txn_commit>` and :ref:`box_return_tuple() <box-box_return_tuple>` -- came from the :ref:`C API <index-c_api_reference>`. This time the C function is doing four things: This time the C function is doing six things: This time the C function is doing three things: This time the call is passing a Lua table (``passable_table``) to the ``harder()`` function. The ``harder()`` function will see it, it's in the :code:`char *args` parameter. ``char tuple[1024];`` is used here as just a quick way of saying "allocate more than enough bytes". For serious programs the developer must be careful to allow enough space for all the bytes that the ``mp_encode`` routines will use up. ``libmsgpuck.a`` (only for some recent msgpuck versions) ``module.h`` and files #included in it ``msgpuck.h`` box.cfg{listen=3306}
box.schema.space.create('capi_test')
box.space.capi_test:create_index('primary')
net_box = require('net.box')
capi_connection = net_box:new(3306) box.schema.func.create('easy', {language = 'C'})
box.schema.user.grant('guest', 'execute', 'function', 'easy')
capi_connection:call('easy') box.schema.func.create('easy.easy2', {language = 'C'})
box.schema.user.grant('guest', 'execute', 'function', 'easy.easy2')
capi_connection:call('easy.easy2') box.schema.func.create('harder', {language = 'C'})
box.schema.user.grant('guest', 'execute', 'function', 'harder')
passable_table = {}
table.insert(passable_table, 1)
table.insert(passable_table, 2)
table.insert(passable_table, 3)
capi_connection:call('harder', passable_table) box.schema.func.create('hardest', {language = "C"})
box.schema.user.grant('guest', 'execute', 'function', 'hardest')
box.schema.user.grant('guest', 'read,write', 'space', 'capi_test')
capi_connection:call('hardest') box.schema.func.create('read', {language = "C"})
box.schema.user.grant('guest', 'execute', 'function', 'read')
box.schema.user.grant('guest', 'read,write', 'space', 'capi_test')
capi_connection:call('read') box.schema.func.create('write', {language = "C"})
box.schema.user.grant('guest', 'execute', 'function', 'write')
box.schema.user.grant('guest', 'read,write', 'space', 'capi_test')
capi_connection:call('write') box.space.capi_test:select() ending a transaction; finding the numeric identifier of the ``capi_test`` space by calling ``box_space_id_by_name()``; formatting a search key = 10000 using more ``msgpuck.h`` functions; formatting a tuple using more ``msgpuck.h`` functions; getting a tuple using ``box_index_get()``; going through the tuple's fields with ``box_tuple_get()`` and then decoding each field depending on its type. In this case, since what we are getting is the tuple that we inserted with ``hardest.c``, we know in advance that the type is either MP_UINT or MP_STR; however, it's very common to have a case statement here with one option for each possible type. inserting a tuple using ``box_insert()``. making a new tuple; once again, finding the numeric identifier of the ``capi_test`` space by calling ``box_space_id_by_name()``; or on Fedora say: replacing a tuple in ``box.space.capi_test`` starting a transaction; tarantool> box.space.capi_test:select()
---
- - [10000, 'String 2']
... tarantool> capi_connection:call('easy')
hello world
---
- []
... tarantool> capi_connection:call('harder', passable_table)
arg_count = 1
field_count = 3
val=1.
val=2.
val=3.
---
- []
... tarantool> capi_connection:call('read')
uint value=10000.
string value=String 2.
---
- []
... tarantool> capi_connection:call('write')
---
- [[1, 22]]
... the final line is a replacement for the loop in ``read.c`` -- instead of getting each field and printing it, use the ``box_return_tuple(...)`` function to return the entire tuple to the caller and let the caller display it. Project-Id-Version: Tarantool 1.10
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2020-02-03 19:10+0000
PO-Revision-Date: 2019-10-23 18:45+0400
Last-Translator: 
Language: ru
Language-Team: 
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
 #include "module.h"
#include "msgpuck.h"
int harder(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  uint32_t arg_count = mp_decode_array(&args);
  printf("arg_count = %d\n", arg_count);
  uint32_t field_count = mp_decode_array(&args);
  printf("field_count = %d\n", field_count);
  uint32_t val;
  int i;
  for (i = 0; i < field_count; ++i)
  {
    val = mp_decode_uint(&args);
    printf("val=%d.\n", val);
  }
  return 0;
} #include "module.h"
#include "msgpuck.h"
int hardest(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  uint32_t space_id = box_space_id_by_name("capi_test", strlen("capi_test"));
  char tuple[1024]; /* Must be big enough for mp_encode results */
  char *tuple_pointer = tuple;
  tuple_pointer = mp_encode_array(tuple_pointer, 2);
  tuple_pointer = mp_encode_uint(tuple_pointer, 10000);
  tuple_pointer = mp_encode_str(tuple_pointer, "String 2", 8);
  int n = box_insert(space_id, tuple, tuple_pointer, NULL);
  return n;
} #include "module.h"
#include <msgpuck.h>
int read(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  char tuple_buf[1024];      /* здесь будет храниться тапл в сыром MsgPack-формате */
  uint32_t space_id = box_space_id_by_name("capi_test", strlen("capi_test"));
  uint32_t index_id = 0;     /* номер первого индекса спейса */
  uint32_t key = 10000;      /* значение ключа, используемое box_insert() */
  mp_encode_array(tuple_buf, 0); /* clear */
  box_tuple_format_t *fmt = box_tuple_format_default();
  box_tuple_t *tuple = box_tuple_new(fmt, tuple_buf, tuple_buf+512);
  assert(tuple != NULL);
  char key_buf[16];          /* передаем key_buf = закодированный ключ = 1000 */
  char *key_end = key_buf;
  key_end = mp_encode_array(key_end, 1);
  key_end = mp_encode_uint(key_end, key);
  assert(key_end < key_buf + sizeof(key_buf));
  /* Получить тапл. У нас нет box_select(), но есть вот это. */
  int r = box_index_get(space_id, index_id, key_buf, key_end, &tuple);
  assert(r == 0);
  assert(tuple != NULL);
  /* Получить каждое поле тапла + показать полученное значение */
  int field_no;             /* номер первого поля = 0 */
  for (field_no = 0; field_no < 2; ++field_no)
  {
    const char *field = box_tuple_field(tuple, field_no);
    assert(field != NULL);
    assert(mp_typeof(*field) == MP_STR || mp_typeof(*field) == MP_UINT);
    if (mp_typeof(*field) == MP_UINT)
    {
      uint32_t uint_value = mp_decode_uint(&field);
      printf("uint value=%u.\n", uint_value);
    }
    else /* если (mp_typeof(*field) == MP_STR) */
    {
      const char *str_value;
      uint32_t str_value_length;
      str_value = mp_decode_str(&field, &str_value_length);
      printf("string value=%.*s.\n", str_value_length, str_value);
    }
  }
  return 0;
} #include "module.h"
#include <msgpuck.h>
int write(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  static const char *space = "capi_test";
  char tuple_buf[1024]; /* Должен быть достаточно большим, чтобы вместить результат mp_encode */
  uint32_t space_id = box_space_id_by_name(space, strlen(space));
  if (space_id == BOX_ID_NIL) {
    return box_error_set(__FILE__, __LINE__, ER_PROC_C,
    "Can't find space %s", "capi_test");
  }
  char *tuple_end = tuple_buf;
  tuple_end = mp_encode_array(tuple_end, 2);
  tuple_end = mp_encode_uint(tuple_end, 1);
  tuple_end = mp_encode_uint(tuple_end, 22);
  box_txn_begin();
  if (box_replace(space_id, tuple_buf, tuple_end, NULL) != 0)
    return -1;
  box_txn_commit();
  fiber_sleep(0.001);
  struct tuple *tuple = box_tuple_new(box_tuple_format_default(),
                                      tuple_buf, tuple_end);
  return box_return_tuple(ctx, tuple);
} #include "module.h"
int easy(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  printf("hello world\n");
  return 0;
}
int easy2(box_function_ctx_t *ctx, const char *args, const char *args_end)
{
  printf("hello world -- easy2\n");
  return 0;
} $ dnf -y install tarantool-devel $ export CPATH=/usr/local/include/tarantool:/usr/local/include/msgpuck $ gcc -shared -o easy.so -fPIC easy.c $ gcc -shared -o harder.so -fPIC harder.c $ gcc -shared -o hardest.so -fPIC hardest.c $ gcc -shared -o read.so -fPIC read.c $ gcc -shared -o write.so -fPIC write.c $ sudo apt-get install tarantool-dev **Пример из набора тестов** **Очистка данных** **Подготовка** **easy.c** **harder.c** **hardest.c** **read.c** **write.c** ... и на этот раз результатом будет: "hello world -- easy2". :ref:`easy.c <f_c_tutorial-easy>` -- выводит "hello world"; :ref:`harder.c <f_c_tutorial-harder>` -- декодирует переданное значение параметра; :ref:`hardest.c <f_c_tutorial-hardest>` -- использует API для языка C для вставки в базу данных; :ref:`read.c <f_c_tutorial-read>` -- использует API для языка C для выборки из базы данных; :ref:`write.c <f_c_tutorial-write>` -- использует API для языка C для замены в базе данных. Компилятор GCC, подойдет любая современная версия По окончании задания, вы увидите описанные здесь результаты и сможете самостоятельно написать хранимые процедуры. Теперь вывод на экране выглядит следующим образом: На данный момент функция ``harder()`` начнет использовать функции, определенные в `msgpuck.h <http://rtsisyk.github.io/msgpuck>`_. Процедуры, которые начинаются с "mp" -- это функции msgpuck, которые обрабатывают данные в формате MsgPack_. Передача и возврат всегда осуществляются в этом формате, поэтому следует ознакомиться с msgpuck для того, чтобы овладеть навыками работы с API для языка C. Чтобы компилятор C увидел файлы ``module.h`` и ``msgpuck.h``, путь к ним следует сохранить в переменной. Например, если адрес файла ``module.h`` -- ``/usr/local/include/tarantool/module.h``, а адрес файла ``msgpuck.h`` -- ``/usr/local/include/msgpuck/msgpuck.h``, введите команду: Хранимые процедуры на языке C Практическое задание на C Проверьте наличие следующих элементов на компьютере: Скомпилируйте программу, что создаст файл библиотеки под названием ``easy.so``: Скомпилируйте программу, что создаст файл библиотеки под названием ``harder.so``: Скомпилируйте программу, что создаст файл библиотеки под названием ``hardest.so``: Скомпилируйте программу, что создаст файл библиотеки под названием ``read.so``: Скомпилируйте программу, что создаст файл библиотеки под названием ``write.so``: Вывод: вызвать C-функцию легко. Вывод: на первый взгляд, декодирование значений параметров, переданных в C-функцию непросто, но существуют документированные процедуры для этих целей, и их не так много. Вывод: некоторые тесты из стандартного набора используют хранимые процедуры на языке C, а они должны работать, поскольку мы не можем выпустить Tarantool, если он не прошел тестирование. Вывод: длинное описание всего API для языка C необходимо в силу весомых причин. Все функции можно вызвать из C-функций, которые вызываются из Lua. Таким образом, хранимые процедуры на языке C получают полный доступ к базе данных. Создайте файл. Назовите его ``easy.c``. Запишите в него следующие шесть строк. Создайте файл. Назовите его ``harder.c``. Запишите в него следующие 17 строк: Создайте файл. Назовите его ```hardest.c``. Запишите в него следующие 13 строк: Создайте файл. Назовите его ``read.c``. Запишите в него следующие 43 строки: Создайте файл. Назовите его ``write.c``. Запишите в него следующие 24 строки: Скачайте исходный код Tarantool'а. Откройте поддиректорию :code:`test/box`. Проверьте наличие файла под названием :code:`tuple_bench.test.lua` и еще одного файла под названием :code:`tuple_bench.c`. Изучите Lua-файл на предмет вызова функции в C-файле с использованием методов, описанных в данном практическом задании. Однако, пока достаточно понимать, что функция ``mp_decode_array()`` возвращает количество элементов в массиве, а функция ``mp_decode_uint`` возвращает целое число без знака из :code:`args`. Есть также побочный эффект: по окончании декодирования :code:`args` изменился и теперь указывает на следующий элемент. Удалите все кортежи с функцией с помощью :ref:`box.schema.func.drop <box_schema-func_drop>`. Удалите спейс ``capi_test`` с помощью :ref:`box.schema.capi_test:drop() <box_space-drop>`. Вернитесь в терминал, где были созданы программы ``easy.c``, ``harder.c`` и ``hardest.c``. Вернитесь в терминал, где были созданы программы ``easy.c`` и ``harder.c``. Вернитесь в терминал, где была создана программа ``easy.c``. Вернитесь в терминал, где были созданы программы ``easy.c``, ``harder.c``, ``hardest.c`` и ``read.c``. Ниже приводится практическое занятие на языке C: :ref:`Хранимые процедуры на языке C <f_c_tutorial-c_stored_procedures>`. Если эти запросы вам незнакомы, перечитайте описание :ref:`box.schema.func.create() <box_schema-func_create>`, :ref:`box.schema.user.grant() <box_schema-user_grant>` и :ref:`conn:call() <net_box-call>`. Проще говоря: создайте спейс под названием ``capi_test``, и выполните соединение с одноименным ``capi_connection``. Данное практическое задание могут выполнить те, у кого есть пакет программ для разработки Tarantool'а и компилятор языка программирования C. Оно состоит из пяти задач: Во-первых, она ищет функцию easy, что должно быть легко, потому что по умолчанию Tarantool ищет в текущей директории файл под названием ``easy.so``. Во-вторых, она вызывает функцию easy. Поскольку функция ``easy()`` в ``easy.c`` начинается с ``printf("hello world\n")``, слова "hello world" появятся на экране. В-третьих, она проверяет, что вызов прошел успешно. Поскольку функция ``easy()`` в ``easy.c`` оканчивается на :code:`return 0`, сообщение об ошибке отсутствует, и запрос выполнен. Не закрывайте клиент. Он понадобится для последующих запросов. Теперь вернитесь в клиент и выполните следующие запросы: Теперь вызовем другую функцию в easy.c -- ``easy2()``. Она практически совпадает с функцией ``easy()``, но есть небольшое отличие: если имя файла не совпадет с именем функции, нужно будет указать :samp:`{имя-файла}.{имя-функции}`. Затем всё еще в клиенте выполните следующий запрос: Удалите файлы с разрешением ``.c`` и ``.so``, созданные для данного практического задания. Tarantool выполняет запросы в качестве :ref:`клиента <admin-using_tarantool_as_a_client>`. Запустите Tarantool и введите эти запросы. Запустите еще один терминал. Измените директорию (``cd``), чтобы она совпадала с директорией, где запущен клиент. Tarantool 1.10 Tarantool может вызывать код на языке C с помощью :ref:`модулей <app_server-modules>`, :ref:`ffi <cookbook-ffi_printf>` или хранимых процедур на C. В данном практическом задании рассматривается только третий метод, хранимые процедуры на языке C. На самом деле, программы всегда представляют собой функции на языке C, но исторически сложилось так, что широко используется фраза "хранимая процедура". Статическая библиотека ``libmsgpuck.a`` нужна для версий msgpuck старше февраля 2017 года. Только в том случае, если встречаются проблемы соединения при использовании операторов GCC в примерах данного практического задания, в пути следует указывать ``libmsgpuck.a`` (``libmsgpuck.a`` создан из исходных файлов загрузки msgpuck и Tarantool, поэтому его легко найти). Например, вместо ":code:`gcc -shared -o harder.so -fPIC harder.c`" во втором примере ниже, необходимо ввести ":code:`gcc -shared -o harder.so -fPIC harder.c libmsgpuck.a`". Файл ``module.h`` есть в системе, если Tarantool был установлен из исходных файлов. В противном случае, следует установить пакет Tarantool'а "developer". Например, на Ubuntu введите команду: Файл ``msgpuck.h`` есть в системе, если Tarantool был установлен из исходных файлов. В противном случае, следует установить пакет "msgpuck" по ссылке `https://github.com/rtsisyk/msgpuck <https://github.com/rtsisyk/msgpuck>`_. Важна функция ``capi_connection:call('easy')``. В результате вызова ``capi_connection:call('read')`` должны получить: В результате вызова ``capi_connection:call('write')`` должны получить: Результат должен выглядеть следующим образом: Таким образом, первой будет отображена строка "arg_count = 1", поскольку был передан только один элемент: ``passable_table``. |br| Второй будет отображена строка "field_count = 3", потому что в таблице находятся три элемента. |br| Следующие три строки будут "1", "2" и "3", потому что это значения элементов в таблице. Это доказывает, что функция ``hardest()`` была успешно выполнена, но откуда взялись :ref:`box_space_id_by_name() <box-box_space_id_by_name>` и :ref:`box_insert() <box-box_insert>`? Ответ: :ref:`API для языка C <index-c_api_reference>`. Это доказывает, что функция ``read()`` была успешно выполнена. И снова важные функции, которые начинаются с `box` -- :ref:`box_index_get() <c_api-box_index-box_index_get>` и :ref:`box_tuple_field() <c_api-tuple-box_tuple_field>` -- пришли из :ref:`API для языка C <index-c_api_reference>`. Это доказывает, что функция ``write()`` была успешно выполнена. И снова важные функции, которые начинаются с `box` -- :ref:`box_txn_begin() <txn-box_txn_begin>`, :ref:`box_txn_commit() <txn-box_txn_commit>` и :ref:`box_return_tuple() <box-box_return_tuple>` -- пришли из :ref:`API для языка C <index-c_api_reference>`. На этот раз C-функция выполняет четыре действия: На этот раз C-функция выполняет шесть действий: На этот раз C-функция выполняет три действия: На этот раз вызов передает Lua-таблицу (``passable_table``) в функцию ``harder()``. Функция``harder()`` увидит это, как указано в параметре :code:`char *args`. ``char tuple[1024];`` используется здесь просто в качестве быстрого способа ввода команды "выделить байтов с запасом". В серьезных программах разработчику следует обратить внимание на то, чтобы выделить достаточно места, которое будут использовать процедуры ``mp_encode``. ``libmsgpuck.a`` (только для некоторых последних версий msgpuck) ``module.h`` и включенные в него файлы ``msgpuck.h`` box.cfg{listen=3306}
box.schema.space.create('capi_test')
box.space.capi_test:create_index('primary')
net_box = require('net.box')
capi_connection = net_box:new(3306) box.schema.func.create('easy', {language = 'C'})
box.schema.user.grant('guest', 'execute', 'function', 'easy')
capi_connection:call('easy') box.schema.func.create('easy.easy2', {language = 'C'})
box.schema.user.grant('guest', 'execute', 'function', 'easy.easy2')
capi_connection:call('easy.easy2') box.schema.func.create('harder', {language = 'C'})
box.schema.user.grant('guest', 'execute', 'function', 'harder')
passable_table = {}
table.insert(passable_table, 1)
table.insert(passable_table, 2)
table.insert(passable_table, 3)
capi_connection:call('harder', passable_table) box.schema.func.create('hardest', {language = "C"})
box.schema.user.grant('guest', 'execute', 'function', 'hardest')
box.schema.user.grant('guest', 'read,write', 'space', 'capi_test')
capi_connection:call('hardest') box.schema.func.create('read', {language = "C"})
box.schema.user.grant('guest', 'execute', 'function', 'read')
box.schema.user.grant('guest', 'read,write', 'space', 'capi_test')
capi_connection:call('read') box.schema.func.create('write', {language = "C"})
box.schema.user.grant('guest', 'execute', 'function', 'write')
box.schema.user.grant('guest', 'read,write', 'space', 'capi_test')
capi_connection:call('write') box.space.capi_test:select() заканчивает транзакцию; найдет числовой идентификатор спейса ``capi_test`` путем вызова ``box_space_id_by_name()``; форматирует ключ поиска = 10 000, используя другие функции ``msgpuck.h``; форматирует кортеж, используя другие функции ``msgpuck.h``; получает кортеж с помощью ``box_index_get()``; проходит по полям каждого кортежа с помощью ``box_tuple_get()``. а затем декодирует каждое поле в зависимости от его типа. В данном случае, поскольку мы получаем кортеж, который сами вставили с помощью ``hardest.c``, мы знаем заранее, что его тип будет MP_UINT или MP_STR. Однако, весьма часто здесь употребляется оператор выбора case с одной опцией для каждого возможного типа. вставит кортеж с помощью ``box_insert()``. создает новый кортеж; снова найдет числовой идентификатор спейса ``capi_test`` путем вызова ``box_space_id_by_name()``; или на Fedora введите команду: заменяет кортеж в ``box.space.capi_test`` начинает транзакцию; tarantool> box.space.capi_test:select()
---
- - [10000, 'String 2']
... tarantool> capi_connection:call('easy')
hello world
---
- []
... tarantool> capi_connection:call('harder', passable_table)
arg_count = 1
field_count = 3
val=1.
val=2.
val=3.
---
- []
... tarantool> capi_connection:call('read')
uint value=10000.
string value=String 2.
---
- []
... tarantool> capi_connection:call('write')
---
- [[1, 22]]
... последняя строка заменяет цикл ``read.c`` -- вместо получения и вывода каждого поля, использует функцию ``box_return_tuple(...)`` для возврата всего кортежа вызывающему клиенту, чтобы вывести его на экран. 