��    [      �              �  9   �       1     *   O  =   z  h   �     !     7     J  L   ^     �  �   �  �   |  �   7	  }   $
  �   �
     <  �   T       e     b   �  *   �  �     _   �  6   4  _   k  @   �           -     B  ;  `  �   �  �  "  J   �  �     k   �  x     �   �      y     @   �  �   �  S   v  [   �  �   &  �     -        3  d   M  �  �  �   p  M     j  Q  o   �   6   ,!  9   c!  <  �!  �   �"  1   �#  �   �#  �   �$  &  8%  *  _&  )   �'  4   �'  �   �'  �   (  J   )  b   d)  �   �)  w   �*  w   +  w   �+  w   ,  7   �,  F   �,  F   �,  /   F-     v-     �-     �-     �-     �-     �-  	   �-     �-     �-     �-     �-     �-  �  �-  9   �/     �/  1   �/  *   "0  =   M0  �   �0  #   L1  +   p1     �1  L   �1     	2  )  2  B  A3  �  �4  �   u6  [  u7  #   �8  �   �8  :   �9  �   �9  t   �:  G   -;    u;  �   �<  B   9=  �   |=  j   9>  @   �>  1   �>  8   ?  Y  P?  �   �A  �  B  �   E    F  �   G  �   �G  �   �H  �  �I  �   �K  |   >L  ^  �L  �   N  �   �N  �  SO  &  Q  Y   -S  3   �S  �   �S  ]  �T  4  �[  �   ]  �  �]  �   O`  y   �`  u   ma  x  �a  �  \d  ~   �e  b  zf    �g  �  �h  �  �j  W   �m  4   �m  �   n  �   �n  �   ?o  �   �o  J  �p  w   �q  w   tr  w   �r  w   ds  V   �s  \   3t  g   �t  A   �t  -   :u     hu     pu     uu     |u  W   �u  	   �u     �u     �u     �u      v     v   $ git format-patch --cover-letter --thread=shallow HEAD~2 $ git format-patch -1 $ git format-patch -1 --subject-prefix='PATCH v2' $ git format-patch -1 -o ~/patches-to-send $ git send-email --to tarantool-patches@dev.tarantool.org 00* (``00*`` wildcard will be expanded by your shell to the list of patches generated at the previous step.) **Preparing a patch** **Review process** **Sending a patch** 0000-cover-letter.patch
0001-first-commit.patch
0002-second-commit.patch
... A template: After having sent your patches, you just wait for a review. The reviewer will send their comments back to you in reply to the email that contains the patch that in their opinion needs to be fixed. After the command has been successfully executed, you will find all your patches formatted as separate emails in your current directory (or in the directory specified via ``-o`` option): And don't forget to add hyperlinks to the GitHub issue and branch where your series can be found. In this case you don't need to put links or any additional information to each individual email -- the cover letter will cover everything. Any commit needs a helpful message. Mind the following guidelines when committing to any of Tarantool repositories at GitHub. Any defect, even minor, if it changes the user-visible server behavior, needs a bug report. Report a bug at http://github.com/tarantool/tarantool/issues. Based on [1_] and [2_]. Changes in v3:
  - Fixed comments as per review by Alex
  - Added more tests
Changes in v2:
  - Fixed a crash if the user passes invalid options
  - Fixed a memory leak at exit Developer guidelines Do follow the guidelines above. If you do not comply, your patches are likely to be silently ignored. Do not disagree with the reviewer without providing a good argument supporting your point of view. Do not end the subject line with a period. Do not expect that the reviewer will tell you how to do your thing. It is not their job. The reviewer might suggest alternative ways to tackle the problem, but in general it is your responsibility. Do not forget to update your remote git branch every time you send a new version of your patch. Do not put "gh-xx", "closes #xxx" to the subject line. Do not take every word the reviewer says for granted. Reviewers are humans too, hence fallible. For mail.ru users, the configuration will be slightly different: How to submit a patch for review How to work on a bug How to write a commit message If there are multiple patches you want to submit in one go (e.g. this is a big feature which requires some preparatory patches to be committed first), you should send each patch in a separate email in reply to a cover letter. To format a patch series accordingly, pass the following options to ``git format-patch``: If there is just one patch, the change log should go right after ``---`` in the message body (it will be ignored by ``git am`` then). If you feel that the accumulated change set is large enough to send the whole series anew and restart the review process in a different thread, you generate the patch email(s) again with ``git format-patch``, this time adding v2 (then v3, v4, and so forth) to the subject and a change log to the message body. To modify the subject line accordingly, use the ``--subject-prefix`` option to ``git format-patch`` command: If you use a GMail account, add the following code to your ``.gitconfig``: If you want someone in particular to review your patch, add them to the list of recipients by passing ``--to`` or ``--cc`` once per each recipient. If your email account is hosted by another service, consult your service provider about your SMTP settings. It is also a good practice to add a reference to the previous version of your patch set (via a hyperlink or message id). It is useful to check that ``git send-email`` will work as expected without sending anything to the world. Use ``--dry-run`` option for that. It will format the commit at the top of your local git repository as a plain-text email and write it to a file in the current directory. The file name will look like ``0001-your-commit-subject-line.patch``. To specify a different directory, use ``-o`` option: Link GitHub issues on the lasts lines (`see how <https://help.github.com/articles/closing-issues-via-commit-messages>`_). Once configured, use the following command to send your patches: Once the patch has been formatted, you can view and edit it with your favorite text editor (after all, it is a plain-text file!). We strongly recommend adding: Once there is a positive code review, push the patch and set the status to 'Closed' Once you have committed a patch to your local git repository, you can submit it for review. Once you have formatted your patches, they are ready to be sent via email. Of course, you can send them with your favorite mail agent, but it is much easier to use ``git send-email`` for this. Before using this command, you need to configure it. Patches for bugs should contain a reference to the respective Launchpad bug page or at least bug id. Each patch should have a test, unless coming up with one is difficult in the current framework, in which case QA should be alerted. Separate subject from body with a blank line. Some real-world examples: Start the subject line with a capital letter unless it prefixed with a subsystem name and semicolon: Summarize changes in 50 characters or less

More detailed explanatory text, if necessary.
Wrap it to 72 characters or so.
In some contexts, the first line is treated as the subject of the
commit, and the rest of the text as the body.
The blank line separating the summary from the body is critical
(unless you omit the body entirely); various tools like `log`,
`shortlog` and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequences of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

- Bullet points are okay, too.

- Typically a hyphen or asterisk is used for the bullet, preceded
  by a single space, with blank lines in between, but conventions
  vary here.

Fixes: #123
Closes: #456
Needed for: #859
See also: #343, #789 The cover letter will have BLURB in its subject and body. You'll have to edit it before submitting (again, it is a plain text file). Please write: There are two things you need to do when your patch makes it into the master: To add a change log, open the generated email with you favorite text editor and edit the message body. If there is just one patch, the change log should go right after ``---`` in the message body (it will be ignored by ``git am`` then). If there is more than one patch, the change log should be added to the cover letter. Here is an example of a good change log: To omit ``--cover-letter`` and ``--thread=shallow`` options, you can add the following lines to your gitconfig: To prepare an email, use ``git format-patch`` command: Try to limit the subject line to **50 characters** or so. Upon reaching an agreement, you send a fixed patch in reply to the email that ended the discussion. To send a patch, you can either attach a plain diff (created by ``git diff`` or ``git format-patch``) to email and send it with your favorite mail agent, or use ``--in-reply-to`` option of ``git send-email`` command. Upon receiving an email with review remarks, you carefully read it and reply about whether you agree or disagree with. Please note that we use the interleaved reply style (aka "inline reply") for communications over email. Use the body to explain **what and why** vs. how. Use the imperative mood in the subject line. A properly formed Git commit subject line should always be able to complete the following sentence: "If applied, this commit will */your subject line here/*". Use your real name and real email address. For Tarantool team members, **@tarantool.org** email is preferred, but not mandatory. We don't accept GitHub pull requests. Instead, all patches should be sent as plain-text messages to tarantool-patches@dev.tarantool.org. Please subscribe to our mailing list at https://lists.tarantool.org/mailman/listinfo/tarantool-patches to ensure that your messages are added to the archive. When reporting a bug, try to come up with a test case right away. Set the current maintenance milestone for the bug fix, and specify the series. Assign the bug to yourself. Put the status to 'In progress' Once the patch is ready, put the bug the bug to 'In review' and solicit a review for the fix. Wrap the body to **72 characters** or so. [format]
    thread = shallow
    coverLetter = auto [sendemail]
    smtpencryption = ssl
    smtpserver = smtp.mail.ru
    smtpserverport = 465
    smtpuser = your.name@mail.ru
    smtppass = topsecret [sendemail]
    smtpencryption = tls
    smtpserver = smtp.gmail.com
    smtpserverport = 587
    smtpuser = your.name@gmail.com
    smtppass = topsecret ``--cover-letter`` will make ``git format-patch`` generate a cover letter; ``--thread=shallow`` will mark each formatted patch email to be sent in reply to the cover letter; ``HEAD~2`` (we now use it instead of ``-1``) will make ``git format-patch`` format the first two patches at the top of your local git branch instead of just one. To format three patches, use ``HEAD~3``, and so forth. `tarantool/tarantool@076a842 <https://github.com/tarantool/tarantool/commit/076a842011e09c84c25fb5e68f1b23c9917a3750>`_ `tarantool/tarantool@2993a75 <https://github.com/tarantool/tarantool/commit/2993a75858352f101deb4a15cefd497ae6a78cf7>`_ `tarantool/tarantool@386df3d <https://github.com/tarantool/tarantool/commit/386df3d3eb9c5239fc83fd4dd3292d1b49446b89>`_ `tarantool/tarantool@ccacba2 <https://github.com/tarantool/tarantool/commit/ccacba28f813fb99fd9eaf07fb41bf604dd341bc>`_ a few words about each patch of the series in the body. a hyperlink to the GitHub issue your patch is supposed to fix, if any. a hyperlink to the branch where this patch can be found at GitHub, and a short series description in the subject line; delete the remote branch. iproto: lua: memtx: net.box: put the bug to 'fix committed', recovery: replication: sql: vinyl: where: xlog: Project-Id-Version: Tarantool 1.10
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
 $ git format-patch --cover-letter --thread=shallow HEAD~2 $ git format-patch -1 $ git format-patch -1 --subject-prefix='PATCH v2' $ git format-patch -1 -o ~/patches-to-send $ git send-email --to tarantool-patches@dev.tarantool.org 00* (подстановочный символ ``00*`` будет распространяться на список патчей, сгенерированных в предыдущем шаге.) **Подготовка патча** **Процесс рассмотрения** **Отправка патча** 0000-cover-letter.patch
0001-first-commit.patch
0002-second-commit.patch
... Шаблон: После отправки патчей вы ожидаете их рассмотрения. Редактор отправит свои комментарии в ответ на сообщение с патчем, который нуждается в доработке, по его мнению. После успешного выполнения этой команды все ваши патчи будут отформатированы в виде отдельных сообщений в текущей директории (или в директории, указанной с помощью опции ``-o``): Кроме того, не забудьте добавить ссылки на проблему на GitHub и на ветку, где можно найти серию патчей. В таком случае нет необходимости указывать ссылки или дополнительную информацию в каждом отдельном письме, поскольку всё необходимое уже будет в сопроводительном письме. Любой коммит следует описать в полезном сообщении. Следуйте нижеприведенным рекомендациям при коммитах в любой репозиторий Tarantool'а на GitHub. На любой дефект, даже незначительный, если он изменяет доступное пользователю поведение сервера, необходимо составить отчет об ошибке. Сообщите о дефекте по ссылке http://github.com/tarantool/tarantool/issues. Основано на [1_] и [2_]. Changes in v3:
  - Fixed comments as per review by Alex
  - Added more tests
 Changes in v2:
  - Fixed a crash if the user passes invalid options
  - Fixed a memory leak at exit Рекомендации для разработчиков Соблюдайте вышеуказанные рекомендации. Если вы не будете их соблюдать, ваши патчи могут быть молча проигнорированы. Не спорьте с редактором без веских аргументов в свою поддержку. Не заканчивайте тему сообщения точкой. Не ждите, что редактор скажет вам, как что делать. Это не их работа. Редактор может предложить пути решения проблемы, но вообще говоря, это ваша обязанность. Не забывайте обновлять удаленную ветку git каждый раз, когда отправляете новую версию патча. Не пишите "gh-xx", "closes #xxx" в строке темы. Не принимайте любые слова редактора без доказательств. Редакторы -- тоже люди, которые могут ошибаться. Для пользователей mail.ru настройки будут слегка отличаться: Как отправить патч на рассмотрение Как работать над дефектами Как писать сообщение о коммите Если же вы хотите отправить сразу несколько патчей (например, это важная функция, для которой нужны несколько предварительных патчей), каждый из них следует отправлять в отдельном сообщении в ответ на сопроводительное письмо. Чтобы соответствующим образом отформатировать серию патчей, передайте следующие опции в ``git format-patch``: Если патч всего один, журнал изменений должен идти сразу после ``---`` в теле сообщения (тогда ``git am`` проигнорирует его). Если вы считаете, что общий набор изменений достаточно велик, чтобы отправить всю серию заново и перезапустить процесс рассмотрения в рамках нового обсуждения, вы снова генерируете сообщения с патчами с помощью ``git format-patch``, на этот раз добавив v2 (затем v3, v4 и так далее) в тему и журнал изменений в тело сообщения. Чтобы соответствующим образом изменить тему сообщения, используйте опцию ``--subject-prefix`` в команде ``git format-patch``: Если используется учетная запись GMail, добавьте следующий код в ``.gitconfig``: Если вы бы хотели, чтобы определенный человек рассматривал ваш патч, добавьте его в список получателей, передав ``--to`` или ``--cc`` для каждого получателя. Если ваша учетная запись электронной почты находится на другом ресурсе, уточните SMTP-настройки у поставщика услуг. Также правильно будет добавить ссылку на предыдущую версию набора патчей (гиперссылку или идентификатор сообщения). Неплохо проверить, что ``git send-email`` будет работать должным образом, не отправив ничего на весь мир. Для этого воспользуйтесь опцией ``--dry-run``. В результате последний коммит в локальном репозитории git будет отформатирован в виде обычного текстового сообщения в файл в текущей директории. Название файла будет выглядеть так: ``0001-тема-коммита.patch``. Чтобы указать другую директорию, используйте опцию ``-o``: Привяжите задачи на GitHub в последних строках (`см. как <https://help.github.com/articles/closing-issues-via-commit-messages>`_). После настройки используйте следующую команду для отправки патчей: После форматирования патча его можно просмотреть и отредактировать в вашем любимом текстовом редакторе (всё-таки это файл с обычным текстом!) Мы настоятельно рекомендуем добавить следующее: После успешного рассмотрения кода опубликуйте патч и укажите статус "Closed" (закрыт). После коммита патча в локальный репозиторий git вы можете отправить его на рассмотрение. После форматирования патчей их можно отправлять по электронной почте. Конечно, можно воспользоваться и любимым почтовым клиентом, но гораздо проще отправить их с помощью ``git send-email``. Перед использованием команды ее необходимо настроить. Патчи для исправления ошибок должны содержать ссылку на соответствующую страницу дефекта Launchpad или хотя бы идентификатор дефекта. Каждому патча должен соответствовать отдельный тест, если только это не слишком трудно сделать в текущем окружении, и в этом случае следует предупредить тестировщиков. Отделяйте тему от тела сообщения пустой строкой. Некоторые реальные примеры: Начните тему сообщения с прописной буквы, если ей не предшествует префикс с именем подсистемы и точка с запятой: Кратко сформулируйте изменения в пределах 50 символов.

При необходимости, более подробные объяснения.
Уместите детали в примерно 72 символов.
Иногда первая строка считается темой
коммита, а остальной текст -- телом сообщения.
Критически важна пустая строка, которая отделяет тему от тела сообщения
(если только тело не отсутствует совсем); различные средства, такие как `log`,
`shortlog` и `rebase` могут их перепутать, если нет разделения.

Объясните проблему, которую решает данный коммит. Уделите внимание тому, почему
вы вносите эти изменения, а не как (это объясняется в коде).
Есть ли побочные эффекты или другие неочевидные последствия применения этих
изменений? Здесь можно объяснить их.

Следующие абзацы идут после пустых строк.

- Можно также использовать элементы в списке.

- Как правило, в качестве маркера применяется дефис или звездочка, которой предшествует
  пробел, а между строками вставляются пустые строки, но в данном случае
  условные обозначения могут разниться.

Исправляет: #123
Закрывает: #456
Необходим для: #859
См. также: #343, #789 В теме и теле сопроводительного письма будут рекламные аннотации. Вам нужно их отредактировать перед отправкой (опять же, это обычный текст). Просьба указать следующее: Когда ваш патч доходит до главной ветки проекта, нужно сделать следующее: Чтобы добавить журнал изменений, откройте созданное сообщение с помощью любимого текстового редактора и отредактируйте тело сообщения. Если патч всего один, журнал изменений должен идти сразу после ``---`` в теле сообщения (тогда ``git am`` проигнорирует его). Если патчей несколько, журнал изменений следует добавить в сопроводительное письмо. Хороший пример журнала изменений: Чтобы не указывать опции ``--cover-letter`` и ``--thread=shallow``, можно добавить в gitconfig следующие строки: Чтобы подготовить сообщение, воспользуйтесь командой ``git format-patch``: Постарайтесь ограничить тему сообщения примерно **50 символами**. Достигнув соглашения, вы отправляете доработанный патч в ответ на последнее сообщение в обсуждении. Чтобы отправить патч, вы можете либо вложить простой diff (созданный с помощью ``git diff`` или ``git format-patch``) в сообщение электронной почте и отправить его с помощью вашего любимого почтового клиента, либо использовать опцию ``--in-reply-to`` команды ``git send-email``. Получив электронное письмо с примечаниями, вы внимательно читаете его и отвечаете, согласны вы или нет. Обратите внимание, что мы используем стиль ответа с чередованием (он же "встроенный ответ") в сообщениях электронной почты. Используйте тело сообщения, чтобы объяснить, **что и почему**, а не как. В теме сообщения используйте повелительное наклонение. Правильно оформленная тема Git-коммита должна корректно дополнять следующее предложение: "Если применить, коммит */здесь тема сообщения/*". Используйте настоящие имя и адрес электронной почты. Членам проектной команды Tarantool'а рекомендуется указывать почту на **@tarantool.org**, но это необязательно. Мы не принимаем запросы на включение в проект на GitHub. Вместо этого все патчи следует отправлять в виде обычного текстового сообщения по адресу tarantool-patches@dev.tarantool.org. Подпишитесь на рассылку https://lists.tarantool.org/mailman/listinfo/tarantool-patches, чтобы убедиться, что ваши сообщения добавляются в архив. Когда вы сообщаете об ошибке, постарайтесь сразу же приступить к тестовому сценарию. Установите текущую контрольную точку для исправления ошибки и укажите серию. Назначьте задачу на себя. Укажите статус "In progress" (выполняется). Как только патч готов, укажите статус ошибки "In review" (на рассмотрении) и отправьте версию с исправленными ошибками на рассмотрение. Уместите тело сообщения в примерно **72 символа**. [format]
    thread = shallow
    coverLetter = auto [sendemail]
    smtpencryption = ssl
    smtpserver = smtp.mail.ru
    smtpserverport = 465
    smtpuser = your.name@mail.ru
    smtppass = topsecret [sendemail]
    smtpencryption = tls
    smtpserver = smtp.gmail.com
    smtpserverport = 587
    smtpuser = your.name@gmail.com
    smtppass = topsecret ``--cover-letter`` заставит ``git format-patch`` сгенерировать сопроводительное письмо; ``--thread=shallow`` отметит каждое сообщение с отформатированными патчами, которые следует отправить в ответ на сопроводительное письмо; ``HEAD~2`` (мы используем вместо ``-1``) заставит ``git format-patch`` форматировать последние два патча в локальной ветке git, а не один. Чтобы форматировать три патча, используйте ``HEAD~3``, и так далее. `tarantool/tarantool@076a842 <https://github.com/tarantool/tarantool/commit/076a842011e09c84c25fb5e68f1b23c9917a3750>`_ `tarantool/tarantool@2993a75 <https://github.com/tarantool/tarantool/commit/2993a75858352f101deb4a15cefd497ae6a78cf7>`_ `tarantool/tarantool@386df3d <https://github.com/tarantool/tarantool/commit/386df3d3eb9c5239fc83fd4dd3292d1b49446b89>`_ `tarantool/tarantool@ccacba2 <https://github.com/tarantool/tarantool/commit/ccacba28f813fb99fd9eaf07fb41bf604dd341bc>`_ несколько слов о каждом патче в теле сообщения. ссылку на проблему на GitHub, которую решает ваш патч. ссылка на ветку, где можно найти этот патч на GitHub, а также короткое описание в теме сообщения; удалить отдельную ветку. iproto: lua: memtx: net.box: перевести статус ошибки в 'fix committed' (исправлено), recovery: replication: sql: vinyl: где: xlog: 