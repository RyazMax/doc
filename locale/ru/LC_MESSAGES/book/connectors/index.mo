��    �                    �	  H  �	  �   6  �  �  -  �  �  �  o   �  �     X   �!  '   "     8"  (   V"  �   "  �   ##  '   �#  C   $  I   T$  �   �$  �   )%  d   �%  f   #&  1   �&  �   �&     w'     {'     ~'     �'     �'     �'     �'     �'     �'     �'     �'  �    (  %   �(  :   �(  y  +)  �   �+  A  v,  �   �.  P  f/     �0     �0     �0     �0     �0     �0     �0     �0  	   1  
   %1     01     N1  	   U1  	   _1    i1     v3     �3  @   �3  ?   �3  �   4  s   �4  F  I5  m   �6  8  �6  �   7:  '  �:  �   �>  y   �?  �  V@  �   B  �  �B  1  �D  |   F  #   F  Y   �F     �F  Y   G     \G  	  dG     nI     rI  �   �I     J  3   J     @J     IJ     PJ  �  RJ  A   �K  0   .L  )   _L  ,   �L  T   �L  �   M  T  N  �   `O  �   8P  �  Q  �   �R  �   nS  �   8T  �   U  @  �U  A  �V  `  6X  �   �Y  �  �Z  �   7\     �\  �   ]  0   �]  >   ^  �   M^  J   -_  �   x_  {   r`  %   �`  :  a  +   Ob  E   {b  �  �b  -   ed  U   �d  I   �d  e   3e  O  �e  �   �f     �g     �g    �g     �h     �h     �h  >   i  (   Ai  J   ji  %   �i  G   �i     #j  O   2j  �   �j  �  .k  E   m  �   am  �   �m  T   �n  t   �n  \   \o  4  �o  �   �p  =   rq  ,   �q  4   �q  4  r  O   Gt  �  �t  �  :v  �   &{  P  �{  L  �  S  ^�  |   ��  �  /�  X   ҏ  '   +�     S�  (   q�  �   ��  �   >�  '   �  C   +�  I   o�    ��  ?  ʓ  �   
�  �   �  r   ۖ  '  N�     v�     z�     }�  /   ��  A   ��  1   �  +   $�     P�     S�     V�     Y�  �   \�  :   &�  �   a�  
  �  -  ��  �  "�    ��  $  �  <   3�     p�     |�     ��     ��     ��     ��  *   ��     Ч     �  >   ��     7�     >�     M�  �  \�      �     1�  �   4�  �   �  �  ��  *  �  �  <�    ��  �  �  -  ��  B  ��  �  ��  �   ��    ��  �  ��    +�  �  =�  �   $�  D   ��  �   �     ��  �   ��     R�  *  Z�     ��  &   ��    ��     ��  .   ��     ��     ��      �    �  U   "�  2   x�  +   ��  f   ��  �   >�  v  ��    Y�  V  n�  a  ��  �  '�  M  ��  K  �    N�  �   ��    ��    ��    K�  k  c�  U  ��     %�     F�  �  Z�  Y   ��  r   5�    ��  �   ��  �  ~�  �   f�  �   Z�  �  ��  ^   �  �   B   � p   � f   L T   � v    �   T  B    �	    �	   �	    �
    �
    �
 y   �
 (   a J   � %   � h   � !   d �   � *  * �  U E   B �   � �   " T   � t    \   � 4  � �    =   � ,   9 h   f 4  � O     #!/usr/bin/perl
use DR::Tarantool ':constant', 'tarantool';
use DR::Tarantool ':all';
use DR::Tarantool::MsgPack::SyncClient;

my $tnt = DR::Tarantool::MsgPack::SyncClient->connect(
  host    => '127.0.0.1',                      # look for tarantool on localhost
  port    => 3301,                             # on port 3301
  user    => 'guest',                          # username. for 'guest' we do not also say 'password=>...'

  spaces  => {
    999 => {                                   # definition of space[999] ...
      name => 'examples',                      #   space[999] name = 'examples'
      default_type => 'STR',                   #   space[999] field type is 'STR' if undefined
      fields => [ {                            #   definition of space[999].fields ...
          name => 'field1', type => 'NUM' } ], #     space[999].field[1] name='field1',type='NUM'
      indexes => {                             #   definition of space[999] indexes ...
        0 => {
          name => 'primary', fields => [ 'field1' ] } } } } );

$tnt->insert('examples' => [ 99999, 'BB' ]); #!/usr/bin/python
from tarantool import Connection

c = Connection("127.0.0.1", 3301)
result = c.insert("examples",(99999,'Value', 'Value'))
print result #include <stdio.h>
#include <stdlib.h>

#include <tarantool/tarantool.h>
#include <tarantool/tnt_net.h>
#include <tarantool/tnt_opt.h>

void main() {
   struct tnt_stream *tnt = tnt_net(NULL);          /* See note = SETUP */
   tnt_set(tnt, TNT_OPT_URI, "localhost:3301");
   if (tnt_connect(tnt) < 0) {                      /* See note = CONNECT */
       printf("Connection refused\n");
       exit(-1);
   }
   struct tnt_stream *tuple = tnt_object(NULL);     /* See note = MAKE REQUEST */
   tnt_object_format(tuple, "[%d%s]", 99999, "B");
   tnt_insert(tnt, 999, tuple);                     /* See note = SEND REQUEST */
   tnt_flush(tnt);
   struct tnt_reply reply;  tnt_reply_init(&reply); /* See note = GET REPLY */
   tnt->read_reply(tnt, &reply);
   if (reply.code != 0) {
       printf("Insert failed %lu.\n", reply.code);
   }
   tnt_close(tnt);                                  /* See below = TEARDOWN */
   tnt_stream_free(tuple);
   tnt_stream_free(tnt);
} #include <stdio.h>
#include <stdlib.h>
#include <tarantool/tarantool.h>
#include <tarantool/tnt_net.h>
#include <tarantool/tnt_opt.h>

#define MP_SOURCE 1
#include <msgpuck.h>

void main() {
    struct tnt_stream *tnt = tnt_net(NULL);
    tnt_set(tnt, TNT_OPT_URI, "localhost:3301");
    if (tnt_connect(tnt) < 0) {
        printf("Connection refused\n");
        exit(1);
    }
    struct tnt_stream *tuple = tnt_object(NULL);
    tnt_object_format(tuple, "[%d]", 99999); /* tuple = search key */
    tnt_select(tnt, 999, 0, (2^32) - 1, 0, 0, tuple);
    tnt_flush(tnt);
    struct tnt_reply reply; tnt_reply_init(&reply);
    tnt->read_reply(tnt, &reply);
    if (reply.code != 0) {
        printf("Select failed.\n");
        exit(1);
    }
    char field_type;
    field_type = mp_typeof(*reply.data);
    if (field_type != MP_ARRAY) {
        printf("no tuple array\n");
        exit(1);
    }
    long unsigned int row_count;
    uint32_t tuple_count = mp_decode_array(&reply.data);
    printf("tuple count=%u\n", tuple_count);
    unsigned int i, j;
    for (i = 0; i < tuple_count; ++i) {
        field_type = mp_typeof(*reply.data);
        if (field_type != MP_ARRAY) {
            printf("no field array\n");
            exit(1);
        }
        uint32_t field_count = mp_decode_array(&reply.data);
        printf("  field count=%u\n", field_count);
        for (j = 0; j < field_count; ++j) {
            field_type = mp_typeof(*reply.data);
            if (field_type == MP_UINT) {
                uint64_t num_value = mp_decode_uint(&reply.data);
                printf("    value=%lu.\n", num_value);
            } else if (field_type == MP_STR) {
                const char *str_value;
                uint32_t str_value_length;
                str_value = mp_decode_str(&reply.data, &str_value_length);
                printf("    value=%.*s.\n", str_value_length, str_value);
            } else {
                printf("wrong field type\n");
                exit(1);
            }
        }
    }
    tnt_close(tnt);
    tnt_stream_free(tuple);
    tnt_stream_free(tnt);
} #include <stdio.h>
#include <stdlib.h>
#include <tarantool/tarantool.h>
#include <tarantool/tnt_net.h>
#include <tarantool/tnt_opt.h>
void main() {
  struct tnt_stream *tnt = tnt_net(NULL);              /* SETUP */
  tnt_set(tnt, TNT_OPT_URI, "localhost:3301");
   if (tnt_connect(tnt) < 0) {                         /* CONNECT */
       printf("Connection refused\n");
       exit(-1);
   }
   struct tnt_stream *arg; arg = tnt_object(NULL);     /* MAKE REQUEST */
   tnt_object_add_array(arg, 0);
   struct tnt_request *req1 = tnt_request_call(NULL);  /* CALL function f() */
   tnt_request_set_funcz(req1, "f");
   uint64_t sync1 = tnt_request_compile(tnt, req1);
   tnt_flush(tnt);                                     /* SEND REQUEST */
   struct tnt_reply reply;  tnt_reply_init(&reply);    /* GET REPLY */
   tnt->read_reply(tnt, &reply);
   if (reply.code != 0) {
     printf("Call failed %lu.\n", reply.code);
     exit(-1);
   }
   const unsigned char *p= (unsigned char*)reply.data; /* PRINT REPLY */
   while (p < (unsigned char *) reply.data_end)
   {
     printf("%x ", *p);
     ++p;
   }
   printf("\n");
   tnt_close(tnt);                                     /* TEARDOWN */
   tnt_stream_free(arg);
   tnt_stream_free(tnt);
} $ # sometimes this is necessary:
$ export LD_LIBRARY_PATH=/usr/local/lib
$ gcc -o example example.c -ltarantool $ cat <<EOT > Program.cs
using System;
using System.Threading.Tasks;
using ProGaudi.Tarantool.Client;

public class HelloWorld
{
  static public void Main ()
  {
    Test().GetAwaiter().GetResult();
  }
  static async Task Test()
  {
    var box = await Box.Connect("127.0.0.1:3301");
    var schema = box.GetSchema();
    var space = await schema.GetSpace("examples");
    await space.Insert((99999, "BB"));
  }
}
EOT $ cd ~
$ mkdir progaudi.tarantool.test
$ cd progaudi.tarantool.test
$ dotnet new console $ dotnet add package progaudi.tarantool $ dotnet restore
$ dotnet run $ gcc -o example2 example2.c -ltarantool $ git clone git://github.com/tarantool/tarantool-c.git ~/tarantool-c
$ cd ~/tarantool-c
$ git submodule init
$ git submodule update
$ cmake .
$ make
$ make install $ git clone https://github.com/tarantool/tarantool-perl.git tarantool-perl
$ cd tarantool-perl
$ git submodule init
$ git submodule update --recursive
$ perl Makefile.PL
$ make
$ sudo make install $ npm install tarantool-driver --global $ php -d extension=~/tarantool-php/modules/tarantool.so example.php $ sudo cpan install AnyEvent
$ sudo cpan install Devel::GlobalDestruction **CONNECT:** Now that the stream named ``tnt`` exists and is associated with a URI, this example program can connect to a server instance. **GET REPLY:** For most requests, the client will receive a reply containing some indication whether the result was successful, and a set of tuples. **MAKE REQUEST:** Most requests require passing a structured value, such as the contents of a tuple. **SEND REQUEST:** The database-manipulation requests are analogous to the requests in the box library. **SETUP:** The setup begins by creating a stream. **TEARDOWN:** When a session ends, the connection that was made with :c:func:`tarantoolc:tnt_connect()` should be closed, and the objects that were made in the setup should be destroyed. ... 01 02 1-character string: field[1] 1-digit number: field count = 2 2-character string: field[2] 2-digit number: space id 21 41 42 92 <?php
$tarantool = new Tarantool('localhost', 3301);

try {
    $tarantool->insert('examples', [99999, 'BB']);
    echo "Insert succeeded\n";
} catch (Exception $e) {
    echo $e->getMessage(), "\n";
} Add ``progaudi.tarantool`` reference. Also there are several community-driven Python connectors: Before trying to run, check that a server instance is listening at ``localhost:3301`` and that the space ``examples`` exists, as :ref:`described earlier <index-connector_setting>`. To run the program, say :samp:`./example`. The program will connect to the Tarantool instance, and will send the request. If Tarantool is not running on localhost with listen address = 3301, the program will print “Connection refused”. If the insert fails, the program will print "Insert failed" and an error number (see all error codes in the source file `/src/box/errcode.h <https://github.com/tarantool/tarantool/blob/1.10/src/box/errcode.h>`_). Before trying to run, check that the server instance is :ref:`listening <cfg_basic-listen>` at ``localhost:3301`` and that the space ``examples`` exists, as :ref:`described earlier <index-connector_setting>`. Before trying to run, check that the server instance is :ref:`listening <cfg_basic-listen>` at ``localhost:3301`` and that the space ``examples`` exists, as :ref:`described earlier <index-connector_setting>`. To run the program, say :samp:`python example.py`. The program will connect to the Tarantool server, will send the :ref:`INSERT<box_space-insert>` request, and will not throw any exception if all went well. If the tuple already exists, the program will throw ``tarantool.error.DatabaseError: (3, "Duplicate key exists in unique index 'primary' in space 'examples'")``. Before trying to run, check that the server is listening at ``localhost:3301`` and that the space ``examples`` exists, as :ref:`described earlier <index-connector_setting>`. Besides, there is another community-driven `GitHub project <https://github.com/tarantool-php>`_ which includes an `alternative connector <https://github.com/tarantool-php/client>`_ written in pure PHP, an `object mapper <https://github.com/tarantool-php/mapper>`_, a `queue <https://github.com/tarantool-php/queue>`_ and other packages. Build and run your application. Byte #0 Byte #1 Byte #2 Byte #3 C C# Change code in ``Program.cs``. Component Connectors Create a new console project. Erlang Example 1 Example 2 For all connectors, calling a function via Tarantool causes a return in the MsgPack format. If the function is called using the connector's API, some conversions may occur. All scalar values are returned as tuples (with a MsgPack type-identifier followed by a value); all non-scalar values are returned as a group of tuples (with a MsgPack array-identifier followed by the scalar values). If the function is called via the binary protocol command layer -- "eval" -- rather than via the connector's API, no conversions occur. Function description: Go Here are notes corresponding to comments in the example program. Here follow two examples of using Tarantool's high-level C API. Here is a C program which calls the function. Although C is being used for the example, the result would be precisely the same if the calling program was written in Perl, PHP, Python, Go, or Java. Here is a complete C program that inserts :code:`[99999,'B']` into space :code:`examples` via the high-level C API. Here is a complete C program that selects, using index key ``[99999]``, from space ``examples`` via the high-level C API. To display the results, the program uses functions in the `MsgPuck <http://rtsisyk.github.io/msgpuck/>`_ library which allow decoding of `MessagePack <https://en.wikipedia.org/wiki/MessagePack>`_  arrays. Here is a complete PHP program that inserts ``[99999,'BB']`` into a space named ``examples`` via the PHP API. Here is a complete Perl program that inserts ``[99999,'BB']`` into ``space[999]`` via the Perl API. Before trying to run, check that the server instance is listening at ``localhost:3301`` and that the space ``examples`` exists, as :ref:`described earlier <index-connector_setting>`. To run, paste the code into a file named :file:`example.pl` and say :samp:`perl example.pl`. The program will connect using an application-specific definition of the space. The program will open a socket connection with the Tarantool instance at ``localhost:3301``, then send an :ref:`space_object:INSERT<box_space-insert>` request, then — if all is well — end without displaying any messages. If Tarantool is not running on ``localhost`` with :ref:`listen<cfg_basic-listen>` port = 3301, the program will print “Connection refused”. Here is a complete Python program that inserts ``[99999,'Value','Value']`` into space ``examples`` via the high-level Python API. Here is a complete node.js program that inserts ``[99999,'BB']`` into ``space[999]`` via the node.js API. Before trying to run, check that the server instance is :ref:`listening <cfg_basic-listen>` at ``localhost:3301`` and that the space ``examples`` exists, as :ref:`described earlier <index-connector_setting>`. To run, paste the code into a file named :file:`example.rs` and say ``node example.rs``. The program will connect using an application-specific definition of the space. The program will open a socket connection with the Tarantool instance at ``localhost:3301``, then send an :ref:`INSERT <box_space-insert>` request, then — if all is well — end after saying "Insert succeeded". If Tarantool is not running on ``localhost`` with listen port = 3301, the program will print “Connect failed”. If :ref:`the 'guest' user <box_space-user>` does not have authorization to connect, the program will print "Auth failed". If the insert request fails for any reason, for example because the tuple already exists, the program will print "Insert failed". If Tarantool is not running on localhost with listen port = 3301, or if user 'guest' does not have authorization to connect, or if the INSERT request fails for any reason, the program will print an error message, among other things (stacktrace, etc). If the tuple already exists, the program will print "Duplicate key exists in unique index 'primary' in space 'examples'". In the following example, a Lua function will be created. Since it will be accessed externally by a :ref:`'guest' user<box_space-user>`, a :ref:`grant <box_schema-user_grant>` of an execute privilege will be necessary. The function returns an empty array, a scalar string, two booleans, and a short integer. The values are the ones described in the table :ref:`Common Types and MsgPack Encodings <msgpack-common_types_and_msgpack_encodings>`. In this program, the choice is to do an INSERT request, so the program passes the ``tnt_stream`` that was used for connection (``tnt``) and the ``tnt_stream`` that was set up with :c:func:`tarantoolc:tnt_object_format` (``tuple``). In this program, the request will be an :ref:`INSERT<box_space-insert>`, and the tuple contents will be an integer and a string. This is a simple serial set of values, that is, there are no sub-structures or arrays. Therefore it is easy in this case to format what will be passed using the same sort of arguments that one would use with a C ``printf()`` function: ``%d`` for the integer, ``%s`` for the string, then the integer value, then a pointer to the string value. In this program, the stream will be named ``tnt``. Before connecting on the ``tnt`` stream, some options may have to be set. The most important option is TNT_OPT_URI. In this program, the :ref:`URI <index-uri>` is ``localhost:3301``, since that is where the Tarantool instance is supposed to be listening. Install .net core from Microsoft. Follow `.net core installation instructions <https://www.microsoft.com/net/core#ubuntu>`_. Interpreting function return values It is easy to meet all the conditions by starting the instance and executing this script: Java Mono will not work, nor will .Net from xbuild. Only .net core supported on Linux and Mac. Node.js Now, you could send that packet to the Tarantool instance, and interpret the response (the page about :ref:`Tarantool's binary protocol <box_protocol-iproto_protocol>` has a description of the packet format for responses as well as requests). But it would be easier, and less error-prone, if you could invoke a routine that formats the packet according to typed parameters. Something like ``response = tarantool_routine("insert", 513, "A", "B");``. And that is why APIs exist for drivers for Perl, Python, PHP, and so on. PHP Packet example Paste the code into a file named :file:`example.c` and install ``tarantool-c``. One way to install ``tarantool-c`` (using Ubuntu) is: Perl Please see https://github.com/mialinx/go-tarantool. Protocol Python R Read the Microsoft End User License Agreement first, because it is not an ordinary open-source agreement and there will be a message during installation saying "This software may collect information about you and your use of the software, and send that to Microsoft." Still you can `set environment variables <https://docs.microsoft.com/en-us/dotnet/core/tools/telemetry#behavior>`_ to opt out from telemetry. See `Erlang tarantool driver <https://github.com/stofel/taran>`_. See http://github.com/tarantool/tarantool-java/. See https://github.com/thekvs/tarantoolr. Setting up the server for connector examples Similarly to the first example, paste the code into a file named :file:`example2.c`. Tarantool's binary protocol was designed with a focus on asynchronous I/O and easy integration with proxies. Each client request starts with a variable-length binary header, containing request id, request type, instance id, log sequence number, and so on. The Tarantool API exists so that a client program can send a request packet to a server instance, and receive a response. Here is an example of a what the client would send for ``box.space[513]:insert{'A', 'BB'}``. The BNF description of the components is on the page about :ref:`Tarantool's binary protocol <box_protocol-iproto_protocol>`. The connection might fail for a variety of reasons, such as: the server is not running, or the URI contains an invalid :ref:`password<authentication-passwords>`. If the connection fails, the return value will be -1. The example program only shows one request and does not show all that's necessary for good practice. For that, please see  `The node.js driver repository <https://github.com/KlonD90/node-tarantool-driver>`_. The example program only shows one request and does not show all that's necessary for good practice. For that, please see `tarantool-python <http://github.com/tarantool/tarantool-python>`_ project at GitHub. For an example of using Python API with `queue managers for Tarantool <https://github.com/tarantool/queue>`_, see `queue-python <https://github.com/tarantool/queue-python>`_ project at GitHub. The example program only shows one request and does not show all that's necessary for good practice. For that, please see `tarantool/tarantool-php <https://github.com/tarantool/tarantool-php>`_ project at GitHub. The example program only shows one request and does not show all that's necessary for good practice. For that, please see the `tarantool-perl repository <https://github.com/tarantool/tarantool-perl>`_. The example program only shows one request and does not show all that’s necessary for good practice. For that, please see the `progaudi.tarantool driver repository <https://github.com/progaudi/progaudi.tarantool>`_. The example program uses field type names 'STR' and 'NUM' instead of :ref:`'string' and 'unsigned'<box_space-create_index>`, due to a temporary Perl limitation. The first five bytes -- ``dd 0 0 0 5`` -- are the MsgPack encoding for "32-bit array header with value 5" (see `MsgPack specification <http://github.com/msgpack/msgpack/blob/master/spec.md>`_). The rest are as described in the table :ref:`Common Types and MsgPack Encodings <msgpack-common_types_and_msgpack_encodings>`. The mandatory length, present in request header simplifies client or proxy I/O. A response to a request is sent to the client as soon as it is ready. It always carries in its header the same type and id as in the request. The id makes it possible to match a request to a response, even if the latter arrived out of order. The most commonly used C# driver is `progaudi.tarantool <https://github.com/progaudi/progaudi.tarantool>`_, previously named ``tarantool-csharp``. It is not supplied as part of the Tarantool repository; it must be installed separately. The makers recommend `cross-platform installation using Nuget <https://www.nuget.org/packages/progaudi.tarantool>`_. The most commonly used Perl driver is `tarantool-perl <https://github.com/tarantool/tarantool-perl>`_. It is not supplied as part of the Tarantool repository; it must be installed separately. The most common way to install it is by cloning from GitHub. The most commonly used node.js driver is the `Node Tarantool driver <https://github.com/KlonD90/node-tarantool-driver>`_. It is not supplied as part of the Tarantool repository; it must be installed separately. The most common way to install it is with `npm <https://www.sitepoint.com/beginners-guide-node-package-manager/>`_. For example, on Ubuntu, the installation could look like this after npm has been installed: The program will open a socket connection with the Tarantool instance at ``localhost:3301``, then send an :ref:`INSERT <box_space-insert>` request, then -- if all is well -- print "Insert succeeded". The program will: The two example programs only show a few requests and do not show all that's necessary for good practice. See more in the `tarantool-c documentation at GitHub <http://github.com/tarantool/tarantool-c>`_. Then, to install ``tarantool-perl`` itself, say: This chapter documents APIs for various programming languages. This chapter has examples that show how to connect to a Tarantool instance via the Perl, PHP, Python, node.js, and C connectors. The examples contain hard code that will work if and only if the following conditions are met: This program checks for success but does not decode the rest of the reply. To avoid minor warnings that may appear the first time ``tarantool-perl`` is installed, start with installing some other modules that ``tarantool-perl`` uses, with `CPAN, the Comprehensive Perl Archive Network <https://en.wikipedia.org/wiki/Cpan>`_: To be consistent with the other instructions in this chapter, here is a way to install the driver directly on Ubuntu 16.04. To compile and link the program, say: To prepare, paste the code into a file named :file:`example.py` and install the ``tarantool-python`` connector with either :samp:`pip install tarantool\>0.4` to install in :file:`/usr` (requires **root** privilege) or :samp:`pip install tarantool\>0.4 --user` to install in :file:`~` i.e. user's default directory. To run the program, say :samp:`./example2`. To run, paste the code into a file named :file:`example.php` and say: Unless implementing a client driver, you needn't concern yourself with the complications of the binary protocol. Language-specific drivers provide a friendly way to store domain language data structures in Tarantool. A complete description of the binary protocol is maintained in annotated Backus-Naur form in the source tree: please see the page about :ref:`Tarantool's binary protocol <box_protocol-iproto_protocol>`. When this program is executed, it will print: `aiotarantool <https://github.com/shveenkov/aiotarantool>`_ also with asyncio support `asynctnt <https://github.com/igorcoding/asynctnt>`_ with asyncio support `gtarantool <https://github.com/shveenkov/gtarantool>`_ with gevent support **no active maintenance** `tarantool-php <https://github.com/tarantool/tarantool-php>`_ is the official PHP connector for Tarantool. It is not supplied as part of the Tarantool repository and must be installed separately (see `installation instructions <https://github.com/tarantool/tarantool-php/#installing-and-building>`_ in the connector's ``README`` file). `tarantool-python <http://github.com/tarantool/tarantool-python>`_ is the official Python connector for Tarantool. It is not supplied as part of the Tarantool repository and must be installed separately (see below for details). a1 a2 box.cfg{listen=3301}
box.schema.space.create('examples',{id=999})
box.space.examples:create_index('primary', {type = 'hash', parts = {1, 'unsigned'}})
box.schema.user.grant('guest','read,write','space','examples')
box.schema.user.grant('guest','read','space','_space') cd code for insert code for tuple connect using an application-specific definition of the space, dd 0 0 0 5 90 91 a1 61 91 c2 91 c3 91 7f if (tnt_connect(tnt) < 0)
   { printf("Connection refused\n"); exit(-1); } int tnt_connect(struct tnt_stream *s) open a socket connection with the Tarantool server at `localhost:3301`, rest of header send an INSERT request, and — if all is well — end without saying anything. space ``examples`` has id = 999 (``box.space.examples.id = 999``) and has a primary-key index for a numeric field (``box.space[999].index[0].parts[1].type = "unsigned"``), ssize_t tnt_insert(struct tnt_stream *s, uint32_t space, struct tnt_stream *tuple)
ssize_t tnt_replace(struct tnt_stream *s, uint32_t space, struct tnt_stream *tuple)
ssize_t tnt_select(struct tnt_stream *s, uint32_t space, uint32_t index,
                   uint32_t limit, uint32_t offset, uint8_t iterator,
                   struct tnt_stream *key)
ssize_t tnt_update(struct tnt_stream *s, uint32_t space, uint32_t index,
                   struct tnt_stream *key, struct tnt_stream *ops) ssize_t tnt_object_format(struct tnt_stream *s, const char *fmt, ...) struct tnt_reply *tnt_reply_init(struct tnt_reply *r)
tnt->read_reply(struct tnt_stream *s, struct tnt_reply *r)
void tnt_reply_free(struct tnt_reply *r) struct tnt_reply reply;  tnt_reply_init(&reply);
tnt->read_reply(tnt, &reply);
if (reply.code != 0)
   { printf("Insert failed %lu.\n", reply.code); } struct tnt_stream *tnt = tnt_net(NULL);
tnt_set(tnt, TNT_OPT_URI, "localhost:3301"); struct tnt_stream *tnt_net(struct tnt_stream *s)
int tnt_set(struct tnt_stream *s, int option, variant option-value) struct tnt_stream *tuple = tnt_object(NULL);
tnt_object_format(tuple, "[%d%s]", 99999, "B"); tarantool> box.cfg{listen=3301}
2016-03-03 18:45:52.802 [27381] main/101/interactive I> ready to accept requests
---
...
tarantool> function f() return {},'a',false,true,127; end
---
...
tarantool> box.schema.func.create('f')
---
...
tarantool> box.schema.user.grant('guest','execute','function','f')
---
... the Tarantool instance (tarantool) is running on localhost (127.0.0.1) and is listening on port 3301 (``box.cfg.listen = '3301'``), tnt_close(tnt);
tnt_stream_free(tuple);
tnt_stream_free(tnt); tnt_insert(tnt, 999, tuple);
tnt_flush(tnt); user 'guest' has privileges for reading and writing. var TarantoolConnection = require('tarantool-driver');
var conn = new TarantoolConnection({port: 3301});
var insertTuple = [99999, "BB"];
conn.connect().then(function() {
    conn.auth("guest", "").then(function() {
        conn.insert(999, insertTuple).then(function() {
            console.log("Insert succeeded");
            process.exit(0);
    }, function(e) { console.log("Insert failed");  process.exit(1); });
    }, function(e) { console.log("Auth failed");    process.exit(1); });
    }, function(e) { console.log("Connect failed"); process.exit(1); }); void tnt_close(struct tnt_stream *s)
void tnt_stream_free(struct tnt_stream *s) Project-Id-Version: Tarantool 1.10
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
 #!/usr/bin/perl
#!/usr/bin/perl
use DR::Tarantool ':constant', 'tarantool';
use DR::Tarantool ':all';
use DR::Tarantool::MsgPack::SyncClient;

  host    => '127.0.0.1',                      # поиск Tarantool-сервера по адресу localhost
  port    => 3301,                             # на порту 3301
  user    => 'guest',                          # имя пользователя; здесь же можно добавить 'password=>...'

  spaces  => {
    999 => {                                   # определение спейса  space[999] ...
      name => 'examples',                      # имя спейса space[999] = 'examples'
      default_type => 'STR',                   # если тип поля в space[999] не задан, то = 'STR'
      fields => [ {                            # определение полей в спейсе space[999] ...
          name => 'field1', type => 'NUM' } ], # имя поля space[999].field[1]='field1', тип ='NUM'
      indexes => {                             # определение индексов спейса space[999] ...
        0 => {
          name => 'primary', fields => [ 'field1' ] } } } } );

$tnt->insert('examples' => [ 99999, 'BB' ]); #!/usr/bin/python
from tarantool import Connection

c = Connection("127.0.0.1", 3301)
result = c.insert("examples",(99999,'Value', 'Value'))
print result #include <stdio.h>
#include <stdlib.h>

#include <tarantool/tarantool.h>
#include <tarantool/tnt_net.h>
#include <tarantool/tnt_opt.h>

void main() {
   struct tnt_stream *tnt = tnt_net(NULL);          /* См. ниже = НАСТРОЙКА */
   tnt_set(tnt, TNT_OPT_URI, "localhost:3301");
   if (tnt_connect(tnt) < 0) {                      /* См. ниже = СОЕДИНЕНИЕ */
       printf("Connection refused\n");
       exit(-1);
   }
   struct tnt_stream *tuple = tnt_object(NULL);     /* См. ниже = СОЗДАНИЕ ЗАПРОСА */
   tnt_object_format(tuple, "[%d%s]", 99999, "B");
   tnt_insert(tnt, 999, tuple);                     /* См. ниже = ОТПРАВКА ЗАПРОСА */
   tnt_flush(tnt);
   struct tnt_reply reply;  tnt_reply_init(&reply); /* См. ниже = ПОЛУЧЕНИЕ ОТВЕТА */
   tnt->read_reply(tnt, &reply);
   if (reply.code != 0) {
       printf("Insert failed %lu.\n", reply.code);
   }
   tnt_close(tnt);                                  /* См. ниже = ЗАВЕРШЕНИЕ */
   tnt_stream_free(tuple);
   tnt_stream_free(tnt);
} #include <stdio.h>
#include <stdlib.h>
#include <tarantool/tarantool.h>
#include <tarantool/tnt_net.h>
#include <tarantool/tnt_opt.h>

#define MP_SOURCE 1
#include <msgpuck.h>

void main() {
    struct tnt_stream *tnt = tnt_net(NULL);
    tnt_set(tnt, TNT_OPT_URI, "localhost:3301");
    if (tnt_connect(tnt) < 0) {
        printf("Connection refused\n");
        exit(1);
    }
    struct tnt_stream *tuple = tnt_object(NULL);
    tnt_object_format(tuple, "[%d]", 99999); /* кортеж tuple = ключ для поиска */
    tnt_select(tnt, 999, 0, (2^32) - 1, 0, 0, tuple);
    tnt_flush(tnt);
    struct tnt_reply reply; tnt_reply_init(&reply);
    tnt->read_reply(tnt, &reply);
    if (reply.code != 0) {
        printf("Select failed.\n");
        exit(1);
    }
    char field_type;
    field_type = mp_typeof(*reply.data);
    if (field_type != MP_ARRAY) {
        printf("no tuple array\n");
        exit(1);
    }
    long unsigned int row_count;
    uint32_t tuple_count = mp_decode_array(&reply.data);
    printf("tuple count=%u\n", tuple_count);
    unsigned int i, j;
    for (i = 0; i < tuple_count; ++i) {
        field_type = mp_typeof(*reply.data);
        if (field_type != MP_ARRAY) {
            printf("no field array\n");
            exit(1);
        }
        uint32_t field_count = mp_decode_array(&reply.data);
        printf("  field count=%u\n", field_count);
        for (j = 0; j < field_count; ++j) {
            field_type = mp_typeof(*reply.data);
            if (field_type == MP_UINT) {
                uint64_t num_value = mp_decode_uint(&reply.data);
                printf("    value=%lu.\n", num_value);
            } else if (field_type == MP_STR) {
                const char *str_value;
                uint32_t str_value_length;
                str_value = mp_decode_str(&reply.data, &str_value_length);
                printf("    value=%.*s.\n", str_value_length, str_value);
            } else {
                printf("wrong field type\n");
                exit(1);
            }
        }
    }
    tnt_close(tnt);
    tnt_stream_free(tuple);
    tnt_stream_free(tnt);
} #include <stdio.h>
#include <stdlib.h>
#include <tarantool/tarantool.h>
#include <tarantool/tnt_net.h>
#include <tarantool/tnt_opt.h>
void main() {
  struct tnt_stream *tnt = tnt_net(NULL);              /* НАСТРОЙКА */
  tnt_set(tnt, TNT_OPT_URI, "localhost:3301");
   if (tnt_connect(tnt) < 0) {                         /* СОЕДИНЕНИЕ */
       printf("Connection refused\n");
       exit(-1);
   }
   struct tnt_stream *arg; arg = tnt_object(NULL);     /* СОЗДАНИЕ ЗАПРОСА */
   tnt_object_add_array(arg, 0);
   struct tnt_request *req1 = tnt_request_call(NULL);  /* ВЫЗОВ функции f() */
   tnt_request_set_funcz(req1, "f");
   uint64_t sync1 = tnt_request_compile(tnt, req1);
   tnt_flush(tnt);                                     /* ОТПРАВКА ЗАПРОСА */
   struct tnt_reply reply;  tnt_reply_init(&reply);    /* ПОЛУЧЕНИЕ ОТВЕТА */
   tnt->read_reply(tnt, &reply);
   if (reply.code != 0) {
     printf("Call failed %lu.\n", reply.code);
     exit(-1);
   }
   const unsigned char *p= (unsigned char*)reply.data; /* ВЫВОД ОТВЕТА */
   while (p < (unsigned char *) reply.data_end)
   {
     printf("%x ", *p);
     ++p;
   }
   printf("\n");
   tnt_close(tnt);                                     /* ЗАВЕРШЕНИЕ */
   tnt_stream_free(arg);
   tnt_stream_free(tnt);
} $ # иногда это необходимо:
$ export LD_LIBRARY_PATH=/usr/local/lib
$ gcc -o example example.c -ltarantool $ cat <<EOT > Program.cs
using System;
using System.Threading.Tasks;
using ProGaudi.Tarantool.Client;

public class HelloWorld
{
  static public void Main ()
  {
    Test().GetAwaiter().GetResult();
  }
  static async Task Test()
  {
    var box = await Box.Connect("127.0.0.1:3301");
    var schema = box.GetSchema();
    var space = await schema.GetSpace("examples");
    await space.Insert((99999, "BB"));
  }
}
EOT $ cd ~
$ mkdir progaudi.tarantool.test
$ cd progaudi.tarantool.test
$ dotnet new console $ dotnet add package progaudi.tarantool $ dotnet restore
$ dotnet run $ gcc -o example2 example2.c -ltarantool $ git clone git://github.com/tarantool/tarantool-c.git ~/tarantool-c
$ cd ~/tarantool-c
$ git submodule init
$ git submodule update
$ cmake .
$ make
$ make install $ git clone https://github.com/tarantool/tarantool-perl.git tarantool-perl
$ cd tarantool-perl
$ git submodule init
$ git submodule update --recursive
$ perl Makefile.PL
$ make
$ sudo make install $ npm install tarantool-driver --global $ php -d extension=~/tarantool-php/modules/tarantool.so example.php $ sudo cpan install AnyEvent
$ sudo cpan install Devel::GlobalDestruction **СОЕДИНЕНИЕ:** Теперь когда мы создали поток с именем ``tnt`` и связали его с конкретным URI, наша программа может устанавливать соединение с экземпляром. **ПОЛУЧЕНИЕ ОТВЕТА:** На большинство запросов клиент получает ответ, который содержит информацию о том, был ли данный запрос успешно выполнен,  а также содержит набор кортежей. **СОЗДАНИЕ ЗАПРОСА:** В большинстве запросов требуется передавать структурированные данные, например содержимое кортежа. **ОТПРАВКА ЗАПРОСА:** Отправка запросов на изменение данных в базе делается аналогично тому, как это делается в Tarantool-библиотеке ``box``. **НАСТРОЙКА:** Настройка начинается с создания потока (``tnt_stream``). **ЗАВЕРШЕНИЕ:** По окончании сессии нам нужно закрыть соединение, созданное с помощью функции :c:func:`tarantoolc:tnt_connect()`, и удалить  объекты, созданные на этапе настройки. ... 01 02 строка из 1 символа: поле[1] число из 1 цифры: количество полей = 2 строка из 2 символов: поле[2] число из 2 цифр: ID спейса 21 41 42 92 <?php
$tarantool = new Tarantool('localhost', 3301);

try {
    $tarantool->insert('examples', [99999, 'BB']);
    echo "Insert succeeded\n";
} catch (Exception $e) {
    echo $e->getMessage(), "\n";
} Добавьте ссылку на ``progaudi.tarantool``. Кроме того, сообщество разработчиков поддерживает другие Python-коннекторы: Перед запуском проверьте, что у экземпляра задан порт для прослушивания на``localhost:3301``, и в базе создан спейс ``examples``, как :ref:`описано выше <index-connector_setting>`. Чтобы запустить программу, выполните команду :samp:`./example`. Программа установит соединение с экземпляром Tarantool'а и отправит запрос. Если Tarantool не запущен на localhost на прослушивание по порту 3301, то программа выдаст сообщение об ошибке “Connection refused”. Если вставка не сработает, программа выдаст сообщение об ошибке "Insert failed" и код ошибки (все коды ошибок см. в исходном файле `/src/box/errcode.h <https://github.com/tarantool/tarantool/blob/1.10/src/box/errcode.h>`_). Перед запуском проверьте, что у экземпляра задан порт для :ref:`прослушивания <cfg_basic-listen>` на ``localhost:3301``, и в базе создан спейс ``examples``, как :ref:`описано выше <index-connector_setting>`. Перед запуском данной программы проверьте, что у Tarantool-сервера задан порт ``localhost:3301`` для :ref:`прослушивания <cfg_basic-listen>` и в базе создан спейс ``examples``), как :ref:`описано выше <index-connector_setting>`. Чтобы запустить тестовую программу, выполните команду :samp:`python example.py`. Программа установит соединение с Tarantool-сервером, пошлет запрос :ref:`INSERT<box_space-insert>` и не сгенерирует никакого исключения, если всё прошло хорошо. Если окажется, что такой кортеж уже существует, то программа сгенерирует исключение `tarantool.error.DatabaseError: (3, "Duplicate key exists in unique index 'primary' in space 'examples'")`. Перед запуском проверьте, что у экземпляра задан порт для прослушивания на``localhost:3301``, и в базе создан спейс ``examples``, как :ref:`описано выше <index-connector_setting>`. Кроме того, сообщество разработчиков поддерживает `проект на GitHub <https://github.com/tarantool-php>`_, который включает в себя `вариант коннектора <https://github.com/tarantool-php/client>`_, написанный на чистом PHP, `модуль сопоставления объектов <https://github.com/tarantool-php/mapper>`_, `администратор очередей <https://github.com/tarantool-php/queue>`_ и другие пакеты. Соберите и запустите приложение. Байт #0 Байт #1 Байт #2 Байт #3 C C# Измените код в ``Program.cs``. Компонент Коннекторы Создайте новый консольный проект. Erlang Пример 1 Пример 2 При работе с любым Tarantool-коннектором функции, вызванные с помощью Tarantool'а, возвращают значения в формате MsgPack. Если функция была вызвана через API коннектора, то формат возвращаемых значений будет следующим: скалярные значения возвращаются в виде кортежей (сначала идет идентификатор типа из формата MsgPack, а затем идет значение); все прочие  (не скалярные) значения возвращаются в виде групп кортежей (сначала идет  идентификатор массива в формате MsgPack, а затем идут скалярные значения). Но если функция была вызвана в рамках бинарного протокола (с помощью команды ``eval``), а не через API коннектора, то подобных изменений формата возвращаемых значений не происходит. Описание функции: Go Далее следуют примечания, на которые мы ссылались в комментариях к исходному коду тестовой программы. В этом разделе даны два примера использования высокоуровневого API для Tarantool'а и языка C. Далее идет пример программы на C, из который мы вызываем эту Lua-функцию.  Хотя в примере использован код на C, результат будет одинаковым, на каком бы языке ни была написана вызываемая программа: Perl, PHP, Python, Go или Java. Далее приводится пример полноценной программы на языке C, которая осуществляет вставку кортежа ``[99999,'B']`` в спейс :code:`examples` с помощью высокоуровневого API для языка C. Далее приводится еще один пример полноценной программы на языке C, которая осуществляет выборку по индекс-ключу ``[99999]`` из спейса ``examples`` с помощью высокоуровневого Tarantool API для языка C. Для вывода результатов в этой программе используются функции из библиотеки `MsgPuck <http://rtsisyk.github.io/msgpuck/>`_. Эти функции нужны для декодирования массивов значений в формате `MessagePack <https://en.wikipedia.org/wiki/MessagePack>`_. Далее приводится пример полноценной программы на языке PHP, которая осуществляет вставку кортежа ``[99999,'BB']`` в спейс ``examples``  с помощью API для языка PHP. Далее приводится пример полноценной программы на языке Perl, которая осуществляет вставку кортежа ``[99999,'BB']`` в спейс ``space[999]`` с помощью API для языка Perl. Перед запуском проверьте, что у экземпляра задан порт для прослушивания на ``localhost:3301``, и в базе создан спейс ``examples``, как :ref:`описано выше <index-connector_setting>`.  Чтобы запустить программу, сохраните код в файл с именем :file:`example.pl` и выполните команду :samp:`perl example.pl`. Программа установит соединение, используя определение спейса для этой цели, откроет сокет для соединения с экземпляром по ``localhost:3301``, пошлет запрос :ref:`space_object:INSERT<box_space-insert>`, а затем -- если всё хорошо -- закончит работу без каких-либо сообщений. Если Tarantool не запущен на ``localhost`` на :ref:`прослушивание <cfg_basic-listen>` по порту = 3301, то программа выдаст сообщение об ошибке "Connection refused". Далее приводится пример полноценной программы на языке Python, которая осуществляет вставку ``[99999,'Value','Value']`` в спейс ``examples`` с помощью высокоуровневого API для языка Python. Далее приводится пример полноценной программы на языке node.js, которая осуществляет вставку кортежа ``[99999,'BB']`` в спейс ``space[999]`` с помощью API для языка node.js. Перед запуском проверьте, что у экземпляра задан порт для :ref:`прослушивания <cfg_basic-listen>` на ``localhost:3301``, и в базе создан спейс ``examples``, как :ref:`описано выше <index-connector_setting>`. Чтобы запустить программу, сохраните код в файл с именем :file:`example.rs` и выполните команду ``node example.rs``. Программа установит соединение, используя определение спейса для этой цели, откроет сокет для соединения с экземпляром по ``localhost:3301``, отправит :ref:`INSERT-запрос <box_space-insert>`, а затем -- если всё хорошо -- выдаст сообщение "Insert succeeded". Если Tarantool не запущен на ``localhost`` на прослушивание по порту = 3301, то программа выдаст сообщение об ошибке “Connect failed”. Если у :ref:`пользователя 'guest' <box_space-user>` нет прав на соединение, программа выдаст сообщение об ошибке "Auth failed". Если запрос вставки по какой-либо причине не сработает, например поскольку такой кортеж уже существует, то программа выдаст сообщение об ошибке "Insert failed". Если Tarantool не запущен на ``localhost`` на прослушивание по порту 3301, или у пользователя 'guest' нет прав на соединение, или запрос вставки по какой-либо причине не сработает, то программа выдаст сообщение об ошибке и другую информацию (трассировку стека и т.д.). Если такой кортеж уже существует, то программа выдаст сообщение об ошибке “Duplicate key exists in unique index 'primary' in space 'examples'”. Далее приводится пример создания Lua-функции. Поскольку эту функцию будет  вызывать внешний пользователь :ref:`'guest' user<box_space-user>`, то нужно настроить права на исполнение с помощью :ref:`grant <box_schema-user_grant>`. Эта функция возвращает пустой массив, строку-скаляр, два логических значения и короткое целое число. Значение будут теми же, что описаны в разделе про MsgPack в таблице :ref:`Стандартные типы в MsgPack-кодировке <msgpack-common_types_and_msgpack_encodings>`. В данной программе мы делаем INSERT-запрос. В этом запросе мы передаем поток ``tnt``, который ранее использовали для установки соединения, и поток :code:`tuple`, который также ранее настроили с помощью функции :c:func:`tarantoolc:tnt_object_format`. В данной программе мы используем запрос :ref:`INSERT<box_space-insert>`, а кортеж содержит целое число и строку.  Это простой набор значений без каких-либо вложенных структур или массивов. И передаваемые значения мы можем указать самым простым образом -- аналогично тому, как это сделано в стандартной C-функции ``printf()``: ``%d`` для обозначения целого числа, ``%s`` для обозначения строки, затем числовое значение, затем указатель на строковое значение. В нашей программе поток назван ``tnt``. Перед установкой соединения с потоком ``tnt`` нужно задать ряд опций. Самая важная из них -- TNT_OPT_URI. Для этой опции указан :ref:`URI <index-uri>` ``localhost:3301``, т.е. адрес, по которому должно быть настроено прослушивание на стороне экземпляра Tarantool'а. Установите среду .NET Core от Microsoft. Следуйте `инструкциям по установке .NET Core <https://www.microsoft.com/net/core#ubuntu>`_. Интерпретация возвращаемых значений Можно легко соблюсти все условия, запустив экземпляр и выполнив следующий скрипт: Java Mono не сработает, как не сработает и .Net от xbuild. Только .NET Core поддерживается на Linux и Mac. Node.js Теперь получившийся пакет можно послать в адрес экземпляра Tarantool'а и затем расшифровать ответ (описания формата пакета ответов и вопросов вы найдете на той же странице о :ref:`бинарном протоколе в Tarantool'е <box_protocol-iproto_protocol>`). Но более простым и верным способом будет вызвать процедуру, которая сформирует готовый пакет с заданными параметрами. Что-то вроде ``response = tarantool_routine("insert", 513, "A", "B");``. Для этого и существуют API для драйверов для Perl, Python, PHP и т.д. PHP Пример пакета данных Скопируйте исходный код программы в файл с именем :file:`example.c` и установите коннектор ``tarantool-c``. Вот один из способов установки ``tarantool-c`` (под Ubuntu): Perl См. https://github.com/mialinx/go-tarantool. Протокол Python R Сначала прочитайте Условия лицензионного соглашения с Microsoft, поскольку оно не похоже на обычные соглашения для ПО с открытым кодом, и во время установки система выдаст сообщение о том, что ПО может собирать информацию ("This software may collect information about you and your use of the software, and send that to Microsoft."). Несмотря на это, можно `определить переменные окружения  <https://docs.microsoft.com/en-us/dotnet/core/tools/telemetry#behavior>`_, чтобы отказаться от участия в сборе телеметрических данных. См. `Erlang-драйвер для Tarantool'а <https://github.com/stofel/taran>`_. См. http://github.com/tarantool/tarantool-java/. См. https://github.com/thekvs/tarantoolr. Настройка окружения для примеров работы с коннекторами Аналогично первому примеру, сохраните исходный код программы в файле с именем :file:`example2.c`. Бинарный протокол для передачи данных в Tarantool'е был разработан с учетом потребностей асинхронного ввода-вывода для облегчения интеграции с прокси-серверами. Каждый клиентский запрос начинается с бинарного заголовка переменной длины. В заголовке указывается идентификатор и тип запроса, идентификатор экземпляра, номер записи в журнале и т.д. С помощью API Tarantool'а клиентские программы могут отправлять пакеты с запросами в адрес экземпляра и получать на них ответы. Вот пример для запроса :code:`box.space[513]:insert{'A', 'BB'}`. Описания компонентов запроса (в виде BNF-диаграмм) вы найдете на странице о :ref:`бинарном протоколе в Tarantool'е <box_protocol-iproto_protocol>`. Попытка соединения может и не удаться по разным причинам, например если Tarantool-сервер не запущен или в URI-строке указан неверный :ref:`пароль <authentication-passwords>`. В случае неудачи функция вернет -1. В этой программе мы привели пример использования лишь одного запроса. Для полноценной работы с Tarantool'ом обратитесь к документации из `репозитория драйвера для node.js <https://github.com/KlonD90/node-tarantool-driver>`_. В этой программе мы привели пример использования лишь одного запроса. Для полноценной работы с Tarantool'ом обратитесь к документации из `проекта tarantool-python на GitHub <http://github.com/tarantool/tarantool-python>`_. А на странице `проекта queue-python на GitHub <https://github.com/tarantool/queue-python>`_ вы сможете найти примеры использования Python API для работы с `очередями сообщений в Tarantool'е <https://github.com/tarantool/queue>`_. В этой программе мы привели пример использования лишь одного запроса. Для полноценной работы с Tarantool'ом обратитесь к документации из `проекта tarantool-php на GitHub <https://github.com/tarantool/tarantool-php>`_. В этой программе мы привели пример использования лишь одного запроса. Для полноценной работы с Tarantool'ом обратитесь к документации из `репозитория tarantool-perl <https://github.com/tarantool/tarantool-perl>`_. В этой программе мы привели пример использования лишь одного запроса. Для  полноценной работы с Tarantool'ом с помощью PHP API, пожалуйста, обратитесь к документации из `проекта tarantool-php на GitHub <https://github.com/tarantool/tarantool-php>`_. Из-за временных ограничений в языке Perl, вместо полей типа :ref:`'string' и 'unsigned'<box_space-create_index>` в тестовой программе указаны поля типа 'STR' и 'NUM'. Первые пять байт -- ``dd 0 0 0 5`` -- это фрагмент данных в формате MsgPack, означающий "32-битный заголовок массива со значением 5" (см. `спецификацию на формат MsgPack <http://github.com/msgpack/msgpack/blob/master/spec.md>`_). Остальные значения описаны в таблице :ref:`Стандартные типы в MsgPack-кодировке <msgpack-common_types_and_msgpack_encodings>`. Также в заголовке обязательно указывается длина запроса, что облегчает обработку данных. Ответ на запрос посылается по мере готовности. В заголовке ответа указывается тот же идентификатор и тип запроса, что и в изначальном запросе. По идентификатору можно легко соотнести запрос с ответом, даже если ответ был получен не в порядке отсылки запросов. Самый используемый драйвер для C# -- `progaudi.tarantool <https://github.com/progaudi/progaudi.tarantool>`_, который раньше назывался ``tarantool-csharp``. Он не входит в репозиторий Tarantool'а, его необходимо устанавливать отдельно. Создатели драйвера рекомендуют `кроссплатформенную установку с помощью Nuget <https://www.nuget.org/packages/progaudi.tarantool>`_. Самый используемый драйвер для Perl -- `tarantool-perl <https://github.com/tarantool/tarantool-perl>`_. Он не входит в репозиторий Tarantool'а, его необходимо устанавливать отдельно. Проще всего установить его путем клонирования с GitHub. Самый используемый драйвер для node.js -- `Node Tarantool driver <https://github.com/KlonD90/node-tarantool-driver>`_. Он не входит в репозиторий Tarantool'а, его необходимо устанавливать отдельно. Проще всего установить его вместе с `npm <https://www.sitepoint.com/beginners-guide-node-package-manager/>`_. Например, на Ubuntu, когда npm уже установлен, установка драйвера будет выглядеть следующим образом: Программа откроет сокет для соединения с экземпляром по ``localhost:3301``, отправит :ref:`INSERT-запрос <box_space-insert>`, а затем -- если всё хорошо -- выдаст сообщение "Insert succeeded". Программа: В этих двух программах мы привели пример использования лишь двух запросов. Для полноценной работы с Tarantool'ом с помощью C API, пожалуйста, обратитесь к документации из `проекта tarantool-c на GitHub <http://github.com/tarantool/tarantool-c>`_. Затем для установки самого ``tarantool-perl``, выполните: В этой главе описаны API для различных языков программирования. В этой главе приводятся примеры того, как можно установить соединение с Tarantool-сервером с помощью коннекторов для языков Perl, PHP, Python, node.js и C. Обратите внимание, что в примерах указаны фиксированные значения, поэтому для корректной работы всех примеров нужно соблюсти следующие условия: Данная программа проверяет, был ли запрос выполнен успешно, но никак не интерпретирует оставшуюся часть ответа. Во избежание незначительных предупреждений, которые может выдать система после первой установки ``tarantool-perl``, начните установку с некоторых других модулей, которые использует ``tarantool-perl``, с `CPAN, the Comprehensive Perl Archive Network (Всеобъемлющая сеть архивов Perl) <https://ru.wikipedia.org/wiki/CPAN>`_: Чтобы придерживаться метода оформления других инструкций в данной главе, дадим описание способа установки драйвера напрямую на 16.04. Чтобы скомпилировать и слинковать тестовую программу, выполните следующую  команду: Чтобы запустить тестовую программу, сохраните ее исходный код в файл с именем :file:`example.py` и установите коннектор ``tarantool-python``. Для установки коннектора воспользуйтесь либо командой :samp:`pip install tarantool\>0.4` (для установки в директорию :file:`/usr`; вам потребуются права уровня  **root**), либо командой :samp:`pip install tarantool\>0.4 --user` (для установки в директорию :file:`~`, т.е. в используемую по умолчанию директорию текущего пользователя). Для запуска программы выполните команду :samp:`./example2`. Чтобы запустить программу, сохраните код в файл с именем :file:`example.php` и выполните: Вдаваться в тонкости реализации Tarantool-протокола нужно только при разработке нового коннектора для Tarantool'а -- см. :ref:`полное описание бинарного протокола в Tarantool'е <box_protocol-iproto_protocol>` в виде аннотированных BNF-диаграмм (Backus-Naur Form). В остальных случаях достаточно взять уже существующий коннектор для нужного вам языка программирования. Такие коннекторы позволяют легко хранить структуры данных из разных языков в формате Tarantool'а. По завершении программа выведет на экран следующие значения: `aiotarantool <https://github.com/shveenkov/aiotarantool>`_ также с поддержкой asyncio `asynctnt <https://github.com/igorcoding/asynctnt>`_ с поддержкой asyncio `gtarantool <https://github.com/shveenkov/gtarantool>`_ с поддержкой gevent **не обновляется** `tarantool-php <https://github.com/tarantool/tarantool-php>`_ -- это официальный PHP-коннектор для Tarantool'а. Он не входит в репозиторий Tarantool'а, его необходимо устанавливать отдельно (`инструкции по установке <https://github.com/tarantool/tarantool-php/#installing-and-building>`_ см. в файле коннектора :file:`README`). `tarantool-python <https://github.com/tarantool/tarantool-python>`_ -- это официальный Python-коннектор для Tarantool'а. Он не входит в репозиторий Tarantool'а, его необходимо устанавливать отдельно (см. ниже подробную информацию). a1 a2 box.cfg{listen=3301}
box.schema.space.create('examples',{id=999})
box.space.examples:create_index('primary', {type = 'hash', parts = {1, 'unsigned'}})
box.schema.user.grant('guest','read,write','space','examples')
box.schema.user.grant('guest','read','space','_space') cd код для вставки код для кортежа установит соединение, используя определение спейса для этой цели, dd 0 0 0 5 90 91 a1 61 91 c2 91 c3 91 7f if (tnt_connect(tnt) < 0)
   { printf("Connection refused\n"); exit(-1); } int tnt_connect(struct tnt_stream *s) откроет сокет для соединения с экземпляром по ``localhost:3301``, остаток заголовка отправит INSERT-запрос, а затем -- если всё хорошо -- закончит работу без каких-либо сообщений. в базе есть спейс``examples`` с идентификатором 999 (``box.space.examples.id = 999``), и у него есть первичный индекс, построенный по ключу числового типа (``box.space[999].index[0].parts[1].type = "unsigned"``), ssize_t tnt_insert(struct tnt_stream *s, uint32_t space, struct tnt_stream *tuple)
ssize_t tnt_replace(struct tnt_stream *s, uint32_t space, struct tnt_stream *tuple)
ssize_t tnt_select(struct tnt_stream *s, uint32_t space, uint32_t index,
                   uint32_t limit, uint32_t offset, uint8_t iterator,
                   struct tnt_stream *key)
ssize_t tnt_update(struct tnt_stream *s, uint32_t space, uint32_t index,
                   struct tnt_stream *key, struct tnt_stream *ops) ssize_t tnt_object_format(struct tnt_stream *s, const char *fmt, ...) struct tnt_reply *tnt_reply_init(struct tnt_reply *r)
tnt->read_reply(struct tnt_stream *s, struct tnt_reply *r)
void tnt_reply_free(struct tnt_reply *r) struct tnt_reply reply;  tnt_reply_init(&reply);
tnt->read_reply(tnt, &reply);
if (reply.code != 0)
   { printf("Insert failed %lu.\n", reply.code); } struct tnt_stream *tnt = tnt_net(NULL);
tnt_set(tnt, TNT_OPT_URI, "localhost:3301"); struct tnt_stream *tnt_net(struct tnt_stream *s)
int tnt_set(struct tnt_stream *s, int option, variant option-value) struct tnt_stream *tuple = tnt_object(NULL);
tnt_object_format(tuple, "[%d%s]", 99999, "B"); tarantool> box.cfg{listen=3301}
2016-03-03 18:45:52.802 [27381] main/101/interactive I> ready to accept requests
---
...
tarantool> function f() return {},'a',false,true,127; end
---
...
tarantool> box.schema.func.create('f')
---
...
tarantool> box.schema.user.grant('guest','execute','function','f')
---
... экземпляр (Tarantool) запущен на локальной машине (``localhost = 127.0.0.1``),  а прослушивание для него настроено на порту 3301 (``box.cfg.listen = '3301'``), tnt_close(tnt);
tnt_stream_free(tuple);
tnt_stream_free(tnt); tnt_insert(tnt, 999, tuple);
tnt_flush(tnt); для пользователя 'guest' настроены права на чтение и запись. var TarantoolConnection = require('tarantool-driver');
var conn = new TarantoolConnection({port: 3301});
var insertTuple = [99999, "BB"];
conn.connect().then(function() {
    conn.auth("guest", "").then(function() {
        conn.insert(999, insertTuple).then(function() {
            console.log("Insert succeeded");
            process.exit(0);
    }, function(e) { console.log("Insert failed");  process.exit(1); });
    }, function(e) { console.log("Auth failed");    process.exit(1); });
    }, function(e) { console.log("Connect failed"); process.exit(1); }); void tnt_close(struct tnt_stream *s)
void tnt_stream_free(struct tnt_stream *s) 