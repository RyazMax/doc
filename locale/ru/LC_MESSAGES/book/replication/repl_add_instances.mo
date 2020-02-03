��    K      t              �    �  O  �  �   ;  L   3	  �  �	  4  d     �     �  %   �     �  1    �  C  �  �  �  �  S  �  a  "  �   c$  [   %     d%     t%     �%  �   �%  �   &  n   �&    '  j   "(  �   �(  q   1)  2  �)  �   �-  #   Z.  4  ~.  �   �/  �   S0  Q   �0  ]   B1  �   �1  D   y2  �   �2  �   3  �   G4  �  %5     �6  N   �6  d   7  Y   ~7     �7     �7  d   8  5   x8     �8     �8  �   �8  �  �9  �   �;  �   �<  I   7=  &   �=  V   �=    �=  �   ?  j  �?  Y   ,A  �   �A  �   qB  %  gC  [  �D  �   �E  �   F  i   %G  -  �G  �   �I  :  �J  '   �K  �  �K    �M  �  �O  #  wS  z   �T  �  U  @  \  *   Ha  4   sa  E   �a  =   �a  U  ,b  k  �g  �  �k  ,  �o  �  �r  �  �u  	  cx  n   my  #   �y  #    z  +   $z  �   Pz  �   E{  �   "|  �  �|  �   �~  �   T  �   K�    �  �   �  C   ��  &  �  :  +�  Z  f�  �   ��  �   ^�  }  �  �   q�  �  ��  d  ��  �  ��  x  ��  (   �  �   <�  �   �  �   ��  "   d�  5   ��  s   ��  y   1�  @   ��  =   �  �  *�  '  ם  �  ��    ��  w   ��  5   �  ~   R�  �  Ѥ    ��  	  ��  �   ��  �  ��  �  !�  �  Ю  *  ��  �   ��    ��  �   ô  �  ��  }  o�  "  ��  `   �   "Connect" means contact the master over the physical network and receive acknowledgment. If there is no acknowledgment after :ref:`box.replication_connect_timeout <cfg_replication-replication_connect_timeout>` seconds (usually 4 seconds), and retries fail, then the connect step fails. "Sync" means receive updates from the master in order to make a local database copy. Syncing is complete when the replica has received all the updates, or at least has received enough updates that the replica's lag (see :ref:`replication.upstream.lag <box_info_replication_upstream_lag>` in ``box.info()``) is less than or equal to the number of seconds specified in :ref:`box.cfg.replication_sync_lag <cfg_replication-replication_sync_lag>`. If ``replication_sync_lag`` is unset (nil) or set to TIMEOUT_INFINITY, then the replica skips the "sync" state and switches to "follow" immediately. # adding master #3 URI to replication sources
tarantool> box.cfg{replication =
         > {'replicator:password@192.168.0.101:3301',
         > 'replicator:password@192.168.0.102:3301',
         > 'replicator:password@192.168.0.103:3301'}}
---
... # making master #3 a real master
tarantool> box.cfg{read_only=false}
---
... $ # launching master #3
$ tarantool master3.lua
2017-06-14 17:10:00.556 [47121] main/101/master3.lua C> version 1.7.4-52-g980d30092
2017-06-14 17:10:00.557 [47121] main/101/master3.lua C> log level 5
2017-06-14 17:10:00.557 [47121] main/101/master3.lua I> mapping 268435456 bytes for tuple arena...
2017-06-14 17:10:00.559 [47121] iproto/101/main I> binary: bound to [::]:3301
2017-06-14 17:10:00.559 [47121] main/104/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.101:3301
2017-06-14 17:10:00.559 [47121] main/105/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.102:3301
2017-06-14 17:10:00.559 [47121] main/106/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.103:3301
2017-06-14 17:10:00.559 [47121] main/105/applier/replicator@192.168.0.10 I> authenticated
2017-06-14 17:10:00.559 [47121] main/101/master3.lua I> bootstrapping replica from 192.168.0.102:3301
2017-06-14 17:10:00.562 [47121] main/105/applier/replicator@192.168.0.10 I> initial data received
2017-06-14 17:10:00.562 [47121] main/105/applier/replicator@192.168.0.10 I> final data received
2017-06-14 17:10:00.562 [47121] snapshot/101/main I> saving snapshot `/Users/e.shebunyaeva/work/tarantool-test-repl/master3_dir/00000000000000000009.snap.inprogress'
2017-06-14 17:10:00.562 [47121] snapshot/101/main I> done
2017-06-14 17:10:00.564 [47121] main/101/master3.lua I> vinyl checkpoint done
2017-06-14 17:10:00.564 [47121] main/101/master3.lua I> ready to accept requests
2017-06-14 17:10:00.565 [47121] main/101/master3.lua I> set 'read_only' configuration option to true
2017-06-14 17:10:00.565 [47121] main C> entering the event loop
2017-06-14 17:10:00.565 [47121] main/104/applier/replicator@192.168.0.10 I> authenticated $ # launching replica #2
$ tarantool replica2.lua
2017-06-14 14:54:33.927 [46945] main/101/replica2.lua C> version 1.7.4-52-g980d30092
2017-06-14 14:54:33.927 [46945] main/101/replica2.lua C> log level 5
2017-06-14 14:54:33.928 [46945] main/101/replica2.lua I> mapping 268435456 bytes for tuple arena...
2017-06-14 14:54:33.930 [46945] main/104/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.101:3301
2017-06-14 14:54:33.930 [46945] main/104/applier/replicator@192.168.0.10 I> authenticated
2017-06-14 14:54:33.930 [46945] main/101/replica2.lua I> bootstrapping replica from 192.168.0.101:3301
2017-06-14 14:54:33.933 [46945] main/104/applier/replicator@192.168.0.10 I> initial data received
2017-06-14 14:54:33.933 [46945] main/104/applier/replicator@192.168.0.10 I> final data received
2017-06-14 14:54:33.934 [46945] snapshot/101/main I> saving snapshot `/var/lib/tarantool/replica2/00000000000000000010.snap.inprogress'
2017-06-14 14:54:33.934 [46945] snapshot/101/main I> done
2017-06-14 14:54:33.935 [46945] main/101/replica2.lua I> vinyl checkpoint done
2017-06-14 14:54:33.935 [46945] main/101/replica2.lua I> ready to accept requests
2017-06-14 14:54:33.935 [46945] main/101/replica2.lua I> set 'read_only' configuration option to true
2017-06-14 14:54:33.936 [46945] main C> entering the event loop **Situation 1: bootstrap** **Situation 2: recovery** **Situation 3: configuration update** **Situation 4: rebootstrap** *If there is a snapshot file and replication source is not empty*: |br| first the local replica goes through the recovery process described in the previous section, using its own .snap and .xlog files. Then it sends a "subscribe" request to all the other replicas of the replica set. The subscribe request contains the server vector clock. The vector clock has a collection of pairs 'server id, lsn' for every replica in the ``_cluster`` system space. Each distant replica, upon receiving a subscribe request, will read its .xlog files' requests and send them to the local replica if (lsn of .xlog file request) is greater than (lsn of the vector clock in the subscribe request). After all the other replicas of the replica set have responded to the local replica's subscribe request, the replica startup is complete. *If there is no snapshot .snap file and the 'replication' parameter is empty*: |br| then the local replica assumes it is an unreplicated "standalone" instance, or is the first replica of a new replica set. It will generate new UUIDs for itself and for the replica set. The replica UUID is stored in the ``_cluster`` space; the replica set UUID is stored in the ``_schema`` space. Since a snapshot contains all the data in all the spaces, that means the local replica's snapshot will contain the replica UUID and the replica set UUID. Therefore, when the local replica restarts on later occasions, it will be able to recover these UUIDs when it reads the .snap file. *If there is no snapshot .snap file and the 'replication' parameter is not empty and the '_cluster' space contains no other replica UUIDs*: |br| then the local replica assumes it is not a standalone instance, but is not yet part of a replica set. It must now join the replica set. It will send its replica UUID to the first distant replica which is listed in ``replication`` and which will act as a master. This is called the "join request". When a distant replica receives a join request, it will send back: *If there is no snapshot .snap file and the 'replication' parameter is not empty and the ``_cluster`` space contains other replica UUIDs*: |br| then the local replica assumes it is not a standalone instance, and is already part of a replica set. It will send its replica UUID and replica set UUID to all the distant replicas which are listed in ``replication``. This is called the "on-connect handshake". When a distant replica receives an on-connect handshake: |br| -- instance file for master #3
box.cfg{
  listen      = 3301,
  replication = {'replicator:password@192.168.0.101:3301',  -- master#1 URI
                 'replicator:password@192.168.0.102:3301',  -- master#2 URI
                 'replicator:password@192.168.0.103:3301'}, -- master#3 URI
  read_only   = true, -- temporarily read-only
}
box.once("schema", function()
   box.schema.user.create('replicator', {password = 'password'})
   box.schema.user.grant('replicator', 'replication') -- grant replication role
   box.schema.space.create("test")
   box.space.test:create_index("primary")
end) -- instance file for replica #2
box.cfg{
  listen = 3301,
  replication = {'replicator:password@192.168.0.101:3301',  -- master URI
                 'replicator:password@192.168.0.102:3301',  -- replica #1 URI
                 'replicator:password@192.168.0.103:3301'}, -- replica #2 URI
  read_only = true
}
box.once("schema", function()
   box.schema.user.create('replicator', {password = 'password'})
   box.schema.user.grant('replicator', 'replication') -- grant replication role
   box.schema.space.create("test")
   box.space.test:create_index("primary")
   print('box.once executed on replica #2')
end) Abort and throw an error if not connected to all nodes in ``box.cfg.replication`` or :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`. Add the URI of master #3 to the :ref:`replication <cfg_replication-replication>` parameter. Adding a master Adding a replica Adding instances After we launch master #3, it gets connected to the other master instances and retrieves their write-ahead-log and snapshot files: After we launch the new replica instance, it gets connected to the master instance and retrieves the master's write-ahead-log and snapshot files: Bootstrap from the leader. See examples in section :ref:`Bootstrapping a replica set <replication-bootstrap>`. Connect to at least :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>` nodes. If failed - set status to 'orphan'. (Attempts to sync will continue in the background and when/if they succeed then 'orphan' will be changed to 'connected'.) Here ``box.cfg{}`` is being called for the first time. A replica is joining but no replica set exists yet. Here ``box.cfg{}`` is not being called for the first time. It is being called again because some replication parameter or something in the replica set has changed. Here ``box.cfg{}`` is not being called for the first time. It is being called again in order to perform recovery. Here ``box.cfg{}`` is not being called. The replica connected successfully at some point in the past, and is now ready for an update from the master. But the master cannot provide an update. This can happen by accident, or more likely can happen because the replica is slow (its :ref:`lag <cfg_replication-replication_sync_lag>` is large), and the WAL (.xlog) files containing the updates have been deleted. This is not crippling. The replica can discard what it received earlier, and then ask for the master's latest snapshot (.snap) file contents. Since it is effectively going through the bootstrap process a second time, this is called "rebootstrapping". However, there has to be one difference from an ordinary bootstrap -- the replica's :ref:`replica id <replication-replica-id>` will remain the same. If it changed, then the master would think that the replica is a new addition to the cluster, and would maintain a record of an instance ID of a replica that has ceased to exist. Rebootstrapping was introduced in Tarantool version 1.10.2 and is completely automatic. Here we add the URI of replica #2 to the :ref:`replication <cfg_replication-replication>` parameter, so now it contains three URIs. Here we make the following changes: However, we recommend specifying the URI of replica #3 in all instance files of the replica set. This will keep all the files consistent with each other and with the current replication topology, and so will help to avoid configuration errors in case of further configuration updates and replica set restart. If connected - sync with all connected nodes, until the difference is not more than :ref:`replication_sync_lag <cfg_replication-replication_sync_lag>` seconds. If earlier steps fail, change status to 'orphan'. (Attempts to sync will continue in the background and when/if they succeed then 'orphan' status will end.) If earlier steps succeed, set status to 'running' (master) or 'follow' (replica). If this instance is elected as the replica set leader, then perform an "automatic bootstrap": In addition to the recovery process described in the section :ref:`Recovery process <internals-recovery_process>`, the server must take additional steps and precautions if :ref:`replication <replication>` is enabled. In background, sync with all the other nodes in the replication set. In order to leave orphan mode you need to sync with a sufficient number (:ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`) of instances. To do so, you may either: In the end, the local replica knows what replica set it belongs to, the distant replica knows that the local replica is a member of the replica set, and both replicas have the same database contents. Next, we add the URI of master #3 to the ``replication`` parameter on the existing two masters. Replication-related parameters are dynamic, so we only need to make a ``box.cfg{}`` request on each of the running instances: Once again the startup procedure is initiated by the ``box.cfg{}`` request. One of the ``box.cfg`` parameters may be :ref:`replication <cfg_replication-replication>` which specifies replication source(-s). We will refer to this replica, which is starting up due to ``box.cfg``, as the "local" replica to distinguish it from the other replicas in a replica set, which we will refer to as "distant" replicas. Orphan status Otherwise this instance will be a replica joining an existing replica set, so: Perform :ref:`recovery <internals-recovery_process>` from the last local snapshot and the WAL files. Reset ``box.cfg.replication`` to exclude instances that cannot be reached or synced with. Return from ``box.cfg{}``. Server startup with replication Set :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>` to a lower value. Set ``box.cfg.replication`` to ``""`` (empty string). Set status to 'orphan'. Set status to 'running'. Since we are adding a read-only instance, there is no need to dynamically update the ``replication`` parameter on the other running instances. This update would be required if we :ref:`added a master instance <replication-add_master>`. Starting with Tarantool version 1.9, there is a change to the procedure when an instance joins a replica set. During ``box.cfg()`` the instance will try to join all masters listed in :ref:`box.cfg.replication <cfg_replication-replication>`. If the instance does not succeed with at least the number of masters specified in :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`, then it will switch to **orphan status**. While an instance is in orphan status, it is read-only. Temporarily specify :ref:`read_only=true <cfg_basic-read_only>` to disable data-change operations on the instance. After launch, master #3 will act as a replica until it retrieves all data from the other masters in the replica set. The URIs in the ``replication`` parameter should all be in the same order on all replicas. This is not mandatory but is an aid to consistency. The following limitation still applies for the current Tarantool version: The following situations are possible. The following temporary limitations applied for Tarantool versions earlier than 1.7.7: The maximum number of entries in the ``_cluster`` space is :ref:`32 <limitations_replicas>`. Tuples for out-of-date replicas are not automatically re-used, so if this 32-replica limit is reached, users may have to reorganize the ``_cluster`` space manually. The replicas of a replica set should be started up at slightly different times. This is not mandatory but prevents a situation where each replica is waiting for the other replica to be ready. This instance might be elected as the replica set 'leader'. Criteria for electing a leader include vclock value (largest is best), and whether it is read-only or read-write (read-write is best unless there is no other choice). The leader is the master that other instances must join. The leader is the master that executes :ref:`box_once() <box-once>` functions. To "join" a master, a replica instance must "connect" to the master node and then "sync". To add a second **replica** instance to the **master-replica** set from our :ref:`bootstrapping example <replication-master_replica_bootstrap>`, we need an analog of the instance file that we created for the first replica in that set: To add a third master instance to the **master-master** set from our :ref:`bootstrapping example <replication-master_master_bootstrap>`, we need an analog of the instance files that we created to bootstrap the other master instances in that set: Try to connect to all nodes from ``box.cfg.replication``, or to the number of nodes required by :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`, within the time period specified in :ref:`replication_connect_timeout <cfg_replication-replication_connect_timeout>`. Try to connect to all nodes from ``box.cfg.replication``, or to the number of nodes required by :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`. Retrying up to 3 times in 30 seconds is possible because this is bootstrap, :ref:`replication_connect_timeout <cfg_replication-replication_connect_timeout>` is overridden. Try to sync with the connected nodes, within the time period specified in :ref:`replication_sync_timeout <cfg_replication-replication_sync_timeout>`. We also recommend to specify master #3 URI in all instance files in order to keep all the files consistent with each other and with the current replication topology. When master #3 catches up with the other masters' state, we can disable read-only mode for this instance: the contents of the distant replica's .snap file. |br| When the local replica receives this information, it puts the replica set UUID in its ``_schema`` space, puts the distant replica's UUID and connection information in its ``_cluster`` space, and makes a snapshot containing all the data sent by the distant replica. Then, if the local replica has data in its WAL .xlog files, it sends that data to the distant replica. The distant replica will receive this and update its own copy of the data, and add the local replica's UUID to its ``_cluster`` space. the distant replica compares its own copy of the replica set UUID to the one in the on-connect handshake. If there is no match, then the handshake fails and the local replica will display an error. the distant replica looks for a record of the connecting instance in its ``_cluster`` space. If there is none, then the handshake fails. |br| Otherwise the handshake is successful. The distant replica will read any new information from its own .snap and .xlog files, and send the new requests to the local replica. the distant replica's replica set UUID, Project-Id-Version: Tarantool 1.10
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
 "Установка соединения" означает контакт с мастером по физической сети и получение подтверждения. Если нет подтверждения соединения через :ref:`box.replication_connect_timeout <cfg_replication-replication_connect_timeout>` секунд (обычно 4 секунды), и повторные попытки подключения не сработали, то соединение не установлено. "Синхронизация" означает получение обновлений от мастера для создания локальной копии базы данных. Синхронизация завершена, когда реплика получила все обновления или хотя бы получила достаточное количество обновлений, чтобы отставание реплики (см. :ref:`replication.upstream.lag <box_info_replication_upstream_lag>` в ``box.info()``) было меньше или равно количеству секунд, указанному в :ref:`box.cfg.replication_sync_lag <cfg_replication-replication_sync_lag>`. Если значение ``replication_sync_lag`` не задано (nil) или указано как "TIMEOUT_INFINITY", то реплика пропускает шаг "синхронизация" и сразу же переходит на "отслеживание". # добавление URI мастера №3 в источники репликации
tarantool> box.cfg{replication =
         > {'replicator:password@192.168.0.101:3301',
         > 'replicator:password@192.168.0.102:3301',
         > 'replicator:password@192.168.0.103:3301'}}
---
... # назначение мастера №3 настоящим мастером
tarantool> box.cfg{read_only=false}
---
... $ # запуск мастера №3
$ tarantool master3.lua
2017-06-14 17:10:00.556 [47121] main/101/master3.lua C> version 1.7.4-52-g980d30092
2017-06-14 17:10:00.557 [47121] main/101/master3.lua C> log level 5
2017-06-14 17:10:00.557 [47121] main/101/master3.lua I> mapping 268435456 bytes for tuple arena...
2017-06-14 17:10:00.559 [47121] iproto/101/main I> binary: bound to [::]:3301
2017-06-14 17:10:00.559 [47121] main/104/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.101:3301
2017-06-14 17:10:00.559 [47121] main/105/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.102:3301
2017-06-14 17:10:00.559 [47121] main/106/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.103:3301
2017-06-14 17:10:00.559 [47121] main/105/applier/replicator@192.168.0.10 I> authenticated
2017-06-14 17:10:00.559 [47121] main/101/master3.lua I> bootstrapping replica from 192.168.0.102:3301
2017-06-14 17:10:00.562 [47121] main/105/applier/replicator@192.168.0.10 I> initial data received
2017-06-14 17:10:00.562 [47121] main/105/applier/replicator@192.168.0.10 I> final data received
2017-06-14 17:10:00.562 [47121] snapshot/101/main I> saving snapshot `/Users/e.shebunyaeva/work/tarantool-test-repl/master3_dir/00000000000000000009.snap.inprogress'
2017-06-14 17:10:00.562 [47121] snapshot/101/main I> done
2017-06-14 17:10:00.564 [47121] main/101/master3.lua I> vinyl checkpoint done
2017-06-14 17:10:00.564 [47121] main/101/master3.lua I> ready to accept requests
2017-06-14 17:10:00.565 [47121] main/101/master3.lua I> set 'read_only' configuration option to true
2017-06-14 17:10:00.565 [47121] main C> entering the event loop
2017-06-14 17:10:00.565 [47121] main/104/applier/replicator@192.168.0.10 I> authenticated $ # запуск реплики №2
$ tarantool replica2.lua
2017-06-14 14:54:33.927 [46945] main/101/replica2.lua C> version 1.7.4-52-g980d30092
2017-06-14 14:54:33.927 [46945] main/101/replica2.lua C> log level 5
2017-06-14 14:54:33.928 [46945] main/101/replica2.lua I> mapping 268435456 bytes for tuple arena...
2017-06-14 14:54:33.930 [46945] main/104/applier/replicator@192.168.0.10 I> remote master is 1.7.4 at 192.168.0.101:3301
2017-06-14 14:54:33.930 [46945] main/104/applier/replicator@192.168.0.10 I> authenticated
2017-06-14 14:54:33.930 [46945] main/101/replica2.lua I> bootstrapping replica from 192.168.0.101:3301
2017-06-14 14:54:33.933 [46945] main/104/applier/replicator@192.168.0.10 I> initial data received
2017-06-14 14:54:33.933 [46945] main/104/applier/replicator@192.168.0.10 I> final data received
2017-06-14 14:54:33.934 [46945] snapshot/101/main I> saving snapshot `/var/lib/tarantool/replica2/00000000000000000010.snap.inprogress'
2017-06-14 14:54:33.934 [46945] snapshot/101/main I> done
2017-06-14 14:54:33.935 [46945] main/101/replica2.lua I> vinyl checkpoint done
2017-06-14 14:54:33.935 [46945] main/101/replica2.lua I> ready to accept requests
2017-06-14 14:54:33.935 [46945] main/101/replica2.lua I> set 'read_only' configuration option to true
2017-06-14 14:54:33.936 [46945] main C> entering the event loop **Ситуация 1: настройка** **Ситуация 2: восстановление** **Ситуация 3: обновление конфигурации** **Ситуация 4: повторная настройка** *Если есть файл снимка и указан источник репликации*: |br| сначала локальная реплика проходит процесс восстановления, описанный в предыдущем разделе, используя свои собственные файлы .snap и .xlog. Затем она отправляет запрос подписки всем репликам в наборе реплик. Запрос подписки содержит векторные часы сервера. Векторные часы включают набор пар 'идентификатор сервера, LSN' для каждой реплики в системном спейсе ``_cluster``. Каждая удаленная реплика, получив запрос подписки, выполняет чтение запросов из файла .xlog и отправляет их на локальную реплику, если LSN из запроса файла .xlog больше, чем LSN векторных часов из запроса подписки. После того, как все реплики из набора реплик отправили ответ на запрос подписки локальной реплики, запуск реплики завершен. *Если нет файла снимка .snap и не указано значение параметра `replication`*: |br| то локальная реплика предполагает, что является нереплицируемым обособленным экземпляром или же первой репликой в новом наборе реплик. Она сгенерирует новые UUID для себя и для набора реплик. UUID реплики хранится в спейсе ``_cluster``; UUID набора реплик хранится в спейсе ``_schema``. Поскольку снимок содержит все данные во всех спейсах, это означает, что снимок локальной реплики будет содержать UUID реплики и UUID набора реплик. Таким образом, когда локальная реплика будет позднее перезапускаться, она сможет восстановить эти UUID после прочтения файла снимка .snap. *Если нет файла снимка .snap, указано значение параметра `replication`, а в спейсе `_cluster` отсутствуют UUID других реплик*: |br| то локальная реплика предполагает, что не является обособленным экземпляром, но еще не входит в набор реплик. Сейчас она должна быть подключиться в набор реплик. Она отправит свой UUID реплики первой удаленной реплике, указанной в параметре ``replication``, которая будет выступать в качестве мастера. Это называется "запрос на подключение". Когда удаленная реплика получает запрос на подключение, она отправляет в ответ: *Если нет файла снимка .snap, указано значение параметра `replication`, а в спейсе ``_cluster`` есть UUID других реплик*: |br| то локальная реплика предполагает, что не является обособленным экземпляром, и уже входит в набор реплик. Она отправит свой UUID реплики и UUID набора реплик всем удаленным репликам, указанным в параметре ``replication``. Это называется "подтверждение связи при подключении". Когда удаленная реплика получает подтверждение связи при подключении: |br| -- файл экземпляра для мастера №3
box.cfg{
  listen      = 3301,
  replication = {'replicator:password@192.168.0.101:3301',  -- URI мастера №1
                 'replicator:password@192.168.0.102:3301',  -- URI мастера №2
                 'replicator:password@192.168.0.103:3301'}, -- URI мастера №3
  read_only   = true, -- временно только для чтения
}
box.once("schema", function()
   box.schema.user.create('replicator', {password = 'password'})
   box.schema.user.grant('replicator', 'replication') -- выдача роли для репликации
   box.schema.space.create("test")
   box.space.test:create_index("primary")
end) -- файл экземпляра для реплики №2
box.cfg{
  listen = 3301,
  replication = {'replicator:password@192.168.0.101:3301',  -- URI мастера
                 'replicator:password@192.168.0.102:3301',  -- URI реплики №1
                 'replicator:password@192.168.0.103:3301'}, -- URI реплики №2
  read_only = true
}
box.once("schema", function()
   box.schema.user.create('replicator', {password = 'password'})
   box.schema.user.grant('replicator', 'replication') -- предоставить роль для репликации
   box.schema.space.create("test")
   box.space.test:create_index("primary")
   print('box.once executed on replica #2')
end) Прекращение работы и выдача ошибки в случае отсутствия соединения со всеми узлами в ``box.cfg.replication`` или :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`. Добавить URI мастера №3 в параметр :ref:`replication <cfg_replication-replication>`. Добавление мастера Добавление реплики Добавление экземпляров После запуска мастер №3 подключается к другим мастер-экземплярам и получает от них файлы журнала упреждающей записи и файлы снимков: После запуска новая реплика подключается к мастер-серверу и получает от него журнал упреждающей записи и файлы снимков: Настройка от лидера. См. примеры в разделе :ref:`Настройка набора реплик <replication-bootstrap>`. Установить соединение с количеством узлов не меньшим, чем :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`. Если не получается - установить статус 'orphan'. (Попытки синхронизации будут повторяться в фоновом режиме, и когда/если они окажутся успешными, статус 'orphan' сменится на 'connected'.) Здесь впервые происходит вызов ``box.cfg{}``. Реплика подключается, но набора реплик пока нет. Здесь вызов ``box.cfg{}`` происходит не впервые, а повторно, поскольку изменились некоторые параметры репликации или что-то в наборе реплик. Здесь вызов ``box.cfg{}`` происходит не впервые, а повторно для осуществления восстановления. Здесь не происходит вызов ``box.cfg{}``. В определенный момент в прошлом реплика успешно установила соединение и в настоящий момент ожидает обновления от мастера. Однако мастер не может передать обновления, что может произойти случайно, или же если реплика работает слишком медленно (большое значение :ref:`lag <cfg_replication-replication_sync_lag>`), а WAL-файлы (.xlog) с обновлениями были удалены. Такая ситуация не является критической -- реплика может сбросить ранее полученные данные, а затем запросить содержание последнего файла снимка (.snap) мастера. Поскольку фактически в таком случае повторно проводится процесс настройки, это называется "повторная настройка". Тем не менее, есть отличие от обычной настройки -- :ref:`идентификатор реплики <replication-replica-id>` останется прежним. Если он изменится, то мастер посчитает, что в кластер добавляется новая реплика, и сохранит идентификатор экземпляра реплики, которой уже не существует. Полностью автоматизированный процесс повторной настройки появился в версии Tarantool'а 1.10.2. Здесь мы добавляем URI реплики №2 в параметр :ref:`replication <cfg_replication-replication>`, так что теперь он содержит три URI. Здесь мы вносим следующие изменения: Тем не менее, рекомендуем указать URI реплики №3 во всех файлах экземпляра в наборе реплик. Это поможет сохранить единообразие файлов и согласовать их с текущей топологией репликации, а также не допустить ошибок конфигурации в случае последующего обновления конфигурации и перезапуска набора реплик. Если соединение установлено - осуществлять синхронизацию со всеми подключенными узлами до тех пор, пока отличия не будут более :ref:`replication_sync_lag <cfg_replication-replication_sync_lag>` секунд. Если предыдущие шаги не выполнены, статус изменяется на 'orphan' (одиночный). (Попытки синхронизации будут продолжаться в фоновом режиме, и когда/если они будут успешны, статус 'orphan' отключится.) Если предыдущие шаги выполнены, статус изменяется на 'running' (мастер) или 'follow' (реплика). Если данный экземпляр выбран лидером набора реплик, выполняется "самонастройка": Помимо процесса восстановления, описанного в разделе :ref:`Процесс восстановления <internals-recovery_process>`, сервер должен предпринять дополнительные шаги и меры предосторожности, если включена :ref:`репликация <replication>`. Синхронизация со всеми остальными узлами в наборе реплик в фоновом режиме. Чтобы вывести узел из одиночного статуса, нужно синхронизировать его с достаточным (т.е. равным :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`) количеством других узлов. Этого можно добиться, выполнив любое из следующих действий: Наконец, локальная реплика понимает, к какому набору реплик относится, удаленная реплика понимает, что локальная реплика входит в набор реплик, и у двух реплик одинаковое содержимое базы данных. Затем добавляем URI мастера №3 в параметр ``replication`` на существующих мастерах. В конфигурации репликации используются динамические параметры, поэтому необходимо только выполнить запрос ``box.cfg{}`` на каждом работающем экземпляре: И снова процедура запуска начинается с запроса ``box.cfg{}``. Одним из параметров запроса ``box.cfg`` может быть :ref:`replication <cfg_replication-replication>`, в котором указываются источники репликации. Реплику, которая запускается сейчас с помощью ``box.cfg``, мы будем называть локальной, чтобы отличать ее от других реплик в наборе реплик, которые мы будем называть удаленными. Статус orphan (одиночный) В противном случае, данный экземпляр будет репликой, которая подключается к существующему набору реплик, поэтому: Проведение :ref:`восстановления <internals-recovery_process>` из последнего локального снимка и WAL-файлов. Убрать из списка ``box.cfg.replication`` недоступные и прочие узлы, с которыми нельзя синхронизироваться. Возврат из ``box.cfg{}``. Запуск сервера с репликацией Уменьшить значение :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`. Вообще задать ``""`` (пустую строку) в качестве значения``box.cfg.replication``. Установка статуса 'orphan' (одиночный). Установка статуса 'running' (запущен). Поскольку мы добавляем экземпляр только для чтения (read-only), нет необходимости в динамическом обновлении параметра ``replication`` на других работающих экземплярах. Такое обновление необходимо, если бы мы :ref:`добавляли мастера <replication-add_master>`. Начиная с версии Tarantool'а 1.9, процедура подключения реплики к набору реплик изменяется. Во время ``box.cfg()`` экземпляр попытается подключиться ко всем мастерам, указанным в :ref:`box.cfg.replication <cfg_replication-replication>`. Если не было успешно выполнено подключение к количеству мастеров, указанному в :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`, экземпляр переходит в **статус orphan** (одиночный). Когда экземпляр находится в статусе orphan, он доступен только для чтения. Временно укажите :ref:`read_only=true <cfg_basic-read_only>`, чтобы отключить операции по изменению данных на этом экземпляре. После запуска мастер №3 будет работать в качестве реплики, пока не получит все данные от других мастеров в наборе реплик. URI в параметре ``replication`` должны быть указаны в одинаковом порядке на всех репликах. Это необязательно, но помогает соблюдать консистентность. Следующее ограничение всё еще применимо к текущей версии Tarantool'а: Возможны следующие ситуации. Следующие временные ограничения применимы к версиям Tarantool'а ниже 1.7.7: Максимальное количество записей в спейсе ``_cluster`` -- :ref:`32 <limitations_replicas>`. Кортежи для устаревших реплик не переиспользуются автоматически, поэтому по достижении предела в 32 реплики, может понадобиться реорганизация спейса ``_cluster`` вручную. Реплики в наборе реплик должны запускаться не одновременно. Это необязательно, но помогает избежать ситуации, когда все реплики ждут готовности друг друга. Экземпляр может быть выбран в качестве лидера 'leader' в наборе реплик. Критерии выбора лидера включают в себя значение vclock (чем больше, тем лучше), а также доступность только для чтения или для чтения и записи (лучше всего для чтения и записи, кроме случаев, когда других вариантов нет). Лидер является мастером, к которому должны подключиться другие экземпляры. Лидер является мастером, который выполняет функции :ref:`box_once() <box-once>`. Чтобы "подключиться" к мастеру, реплика должна "установить соединение" с узлом мастера, а затем "выполнить синхронизацию". Чтобы добавить вторую **реплику** в набор реплик с конфигурацией **мастер-реплика** из нашего :ref:`примера настройки <replication-master_replica_bootstrap>`, необходим аналог файла экземпляра, который мы создали для первой реплики в этом наборе: Чтобы добавить третьего мастера в набор реплик с конфигурацией **мастер-мастер** из нашего :ref:`примера настройки <replication-master_master_bootstrap>`, необходим аналог файлов экземпляров, которые мы создали для настройки других мастеров в этом наборе: Попытка установить соединение со всеми узлами из ``box.cfg.replication`` или с количеством узлов, указанным в параметре :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>` в течение периода времени, указанного в :ref:`replication_connect_timeout <cfg_replication-replication_connect_timeout>`. Попытка установить соединение со всеми узлами из ``box.cfg.replication`` или с количеством узлов, указанным в параметре :ref:`replication_connect_quorum <cfg_replication-replication_connect_quorum>`. Допускаются три повторные попытки за 30 секунд, поскольку идет стадия настройки, параметр :ref:`replication_connect_timeout <cfg_replication-replication_connect_timeout>` не учитывается. Попытка синхронизации со всеми подключенными узлами в течение периода времени, указанного в :ref:`replication_sync_timeout <cfg_replication-replication_sync_timeout>`. Также рекомендуется указать URI мастера №3 во всех файлах экземпляра, чтобы сохранить единообразие файлов и согласовать их с текущей топологией репликации. Когда мастер №3 получает все необходимые изменения от других мастеров, можно отключить режим только для чтения: содержимое файла снимка .snap удаленной реплики. |br| Когда локальная реплика получает эту информацию, она размещает UUID набора реплики в своем спейсе ``_schema``, UUID удаленной реплики и информацию о подключении в своем спейсе ``_cluster``, а затем создает снимок, который содержит все данные, отправленные удаленной репликой. Затем, если в WAL-файлах .xlog локальной реплики содержатся данные, они отправляются на удаленную реплику. Удаленная реплика получается данные и обновляет свою копию данных, а затем добавляет UUID локальной реплики в свой спейс ``_cluster``. удаленная реплика сопоставляет свою версию UUID набора реплик с UUID, переданным в ходе подтверждения связи при подключении. Если они не совпадают, связь не устанавливается, и локальная реплика отобразит ошибку. удаленная реплика ищет запись о подключающемся экземпляре в своем спейсе ``_cluster``. Если такой записи нет, связь не устанавливается. |br| Если есть, связь подтверждается. Удаленная реплика выполняет чтение любой новой информации из своих файлов .snap и .xlog и отправляет новые запросы на локальную реплику. UUID набора реплик, в который входит удаленная реплика 