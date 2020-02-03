��          �                 �       �  t  �  �  .  :   �  �   �  {   �	  /   p
      �
     �
  �   A  G      X   h  '   �  D   �  �  .  �   �  !  �  �  �  �  p  e     f  �  �   �  c   �  0   5  �   f  �  
  s   �  �     K   �  t   �   "Degraded state" is a situation when the master becomes unavailable -- due to hardware or network failure, or due to a programming bug. # report from replica #1
tarantool> box.info.replication
---
- 1:
    id: 1
    uuid: 70e8e9dc-e38d-4046-99e5-d25419267229
    lsn: 542
    upstream:
      peer: replicator@192.168.0.101:3301
      lag: 0.00026607513427734
      status: disconnected
      idle: 182.36929893494
      message: connect, called on fd 13, aka 192.168.0.101:58244
  2:
    id: 2
    uuid: fb252ac7-5c34-4459-84d0-54d248b8c87e
    lsn: 0
  3:
    id: 3
    uuid: fd7681d8-255f-4237-b8bb-c4fb9d99024d
    lsn: 0
    downstream:
      vclock: {1: 542}
... # report from replica #2
tarantool> box.info.replication
---
- 1:
    id: 1
    uuid: 70e8e9dc-e38d-4046-99e5-d25419267229
    lsn: 542
    upstream:
      peer: replicator@192.168.0.101:3301
      lag: 0.00027203559875488
      status: disconnected
      idle: 186.76988101006
      message: connect, called on fd 13, aka 192.168.0.101:58253
  2:
    id: 2
    uuid: fb252ac7-5c34-4459-84d0-54d248b8c87e
    lsn: 0
    upstream:
      status: follow
      idle: 186.76960110664
      peer: replicator@192.168.0.102:3301
      lag: 0.00020599365234375
  3:
    id: 3
    uuid: fd7681d8-255f-4237-b8bb-c4fb9d99024d
    lsn: 0
... $ # messages from a replica's log
2017-06-14 16:23:10.993 [19153] main/105/applier/replicator@192.168.0. I> can't read row
2017-06-14 16:23:10.993 [19153] main/105/applier/replicator@192.168.0. coio.cc:349 !> SystemError
unexpected EOF when reading from socket, called on fd 17, aka 192.168.0.101:57815,
peer of 192.168.0.101:3301: Broken pipe
2017-06-14 16:23:10.993 [19153] main/105/applier/replicator@192.168.0. I> will retry every 1 second
2017-06-14 16:23:10.993 [19153] relay/[::ffff:192.168.0.101]:/101/main I> the replica has closed its socket, exiting
2017-06-14 16:23:10.993 [19153] relay/[::ffff:192.168.0.101]:/101/main C> exiting the relay loop ... and the master's status is reported as "disconnected": If there are updates on the old master that were not propagated before the old master went down, :ref:`re-apply them manually <admin-disaster_recovery-master_replica>` to the new master using ``tarantoolctl cat`` and ``tarantoolctl play`` commands. In a master-replica set, if a master disappears, error messages appear on the replicas stating that the connection is lost: Make sure that the old master is gone for good: Recovering from a degraded state Say ``box.cfg{read_only=false, listen=URI}`` on the replica, and ``box.cfg{replication=URI}`` on the other replicas in the set. There is no automatic way for a replica to detect that the master is gone forever, since sources of failure and replication environments vary significantly. So the detection of degraded state requires an external observer. To declare that one of the replicas must now take over as a new master: change network routing rules to avoid any more packets being delivered to the master, or power off the container or the machine. shut down the master instance, if you have access to the machine, or Project-Id-Version: Tarantool 1.10
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
 "Сбой" -- это ситуация, когда мастер становится недоступен вследствие проблем с оборудованием, сетевых неполадок или программной ошибки. # отчет от реплики № 1
tarantool> box.info.replication
---
- 1:
    id: 1
    uuid: 70e8e9dc-e38d-4046-99e5-d25419267229
    lsn: 542
    upstream:
      peer: replicator@192.168.0.101:3301
      lag: 0.00026607513427734
      status: disconnected
      idle: 182.36929893494
      message: connect, called on fd 13, aka 192.168.0.101:58244
  2:
    id: 2
    uuid: fb252ac7-5c34-4459-84d0-54d248b8c87e
    lsn: 0
  3:
    id: 3
    uuid: fd7681d8-255f-4237-b8bb-c4fb9d99024d
    lsn: 0
    downstream:
      vclock: {1: 542}
... # отчет от реплики № 2
tarantool> box.info.replication
---
- 1:
    id: 1
    uuid: 70e8e9dc-e38d-4046-99e5-d25419267229
    lsn: 542
    upstream:
      peer: replicator@192.168.0.101:3301
      lag: 0.00027203559875488
      status: disconnected
      idle: 186.76988101006
      message: connect, called on fd 13, aka 192.168.0.101:58253
  2:
    id: 2
    uuid: fb252ac7-5c34-4459-84d0-54d248b8c87e
    lsn: 0
    upstream:
      status: follow
      idle: 186.76960110664
      peer: replicator@192.168.0.102:3301
      lag: 0.00020599365234375
  3:
    id: 3
    uuid: fd7681d8-255f-4237-b8bb-c4fb9d99024d
    lsn: 0
... $ # сообщения из журнала реплики
2017-06-14 16:23:10.993 [19153] main/105/applier/replicator@192.168.0. I> can't read row
2017-06-14 16:23:10.993 [19153] main/105/applier/replicator@192.168.0. coio.cc:349 !> SystemError
unexpected EOF when reading from socket, called on fd 17, aka 192.168.0.101:57815,
peer of 192.168.0.101:3301: Broken pipe
2017-06-14 16:23:10.993 [19153] main/105/applier/replicator@192.168.0. I> will retry every 1 second
2017-06-14 16:23:10.993 [19153] relay/[::ffff:192.168.0.101]:/101/main I> the replica has closed its socket, exiting
2017-06-14 16:23:10.993 [19153] relay/[::ffff:192.168.0.101]:/101/main C> exiting the relay loop ... а статус мастера выводится как "отключенный" (disconnected): Если на старом мастере есть обновления, не переданные до выхода старого мастера из строя, :ref:`примените их вручную <admin-disaster_recovery-master_replica>` на новом мастере с помощью команд ``tarantoolctl cat`` и``tarantoolctl play``. В конфигурации мастер-реплика, если мастер пропадает, на репликах выводятся сообщения об ошибке с указанием потери соединения: Убедитесь, что старый мастер окончательно недоступен: Восстановление после сбоя Выполните ``box.cfg{read_only=false, listen=URI}`` на реплике и ``box.cfg{replication=URI}`` на других репликах в наборе. Реплика не может автоматически определить, что мастер не будет доступен в будущем, поскольку причины отказа и среды репликации могут существенно отличаться друг от друга. Поэтому обнаруживать сбой должен человек. Чтобы объявить, что одна из реплик должна стать новым мастером: измените правила маршрутизации в сети, чтобы больше не отправлять пакеты на мастер, или отключите питание контейнера или машины. отключите мастер-экземпляр, если у вас есть доступ к машине, или 