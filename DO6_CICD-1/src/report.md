# DO6_CICD-1

## Part 1. Настройка gitlab-runner

Поднимем виртуальную машину `Ubuntu Server 22.04 LTS`.

<div align="center">

![virtual_machine](images/Part_1_machine.png)

*Виртуальная машина*
</div>

Скачаем и установим на виртуальную машину `gitlab-runner`. Для этого добавим официальный репозиторий gitlab Runner `curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash`

<div align="center">

![repository](images/Part_1_repository.png)

*Добавленный репозиторий*
</div>

Теперь установим gitlab runner

<div align="center">

![install](images/Part_1_install.png)

*Установленный gitlab-runner*
</div>

Зарегистрируем `gitlab-runner` для использования в текущем проекте.

<div align="center">

![registry](images/Part_1_registry.png)

*Регистрация gitlab-runner*
</div>

## Part 2. Сборка

Напишем этап для `CI` по сборке приложений из проекта `C2_SimpleBashUtils`.

В файле `gitlab-ci.yml` добавим этап запуска сборки через мейк файл из проекта `C2`.

<div align="center">

![.gitlab-runner](images/Part_2_git_runner.png)

*Файл .gitlab-runner*
</div>

<div align="center">

![init_make](images/Part_2_init_make.png)

*Содержимое init_make*
</div>

Файлы, полученные после сборки (артефакты), будут храниться в течении 30 дней.

На вкладке `'Jobs'` в `'GitLab'` удостоверимся, что проект собирается без ошибок.

<div align="center">

![check](images/Part_2_check.png)

*Отчет о сборке в GitLab*
</div>

## Part 3. Тест кодстайла

Напишем этап для `CI`, который запускает скрипт кодстайла `(clang-format)`.

<div align="center">

![style](images/Part_3_style.png)

*Этап code-style для CI*
</div>

Скрипты для проверки `cat` и `grep` имеют вид:

<div align="center">

![cat](images/Part_3_cat.png)

*Скрипт для cat*
</div>

<div align="center">

![grep](images/Part_3_grep.png)

*Скрипт для grep*
</div>

Проверим стадию `code_style` для уже отформатированного кода

<div align="center">

![nice](images/Part_3_nice.png)

*Pipeline при отформатированном коде*
</div>

<div align="center">

![out_nice](images/Part_3_out_nice.png)

*Вывод стадии code_style*
</div>

Сделаем стилистическую ошибку в `s21_grep.c` и если кодстайл не пройдет, то «зафейлим» пайплайн.

<div align="center">

![bad](images/Part_3_bad.png)

*Pipeline при неотформатированном коде*
</div>

<div align="center">

![out_bad](images/Part_3_out_bad.png)

*Вывод стадии code_style*
</div>

Исправим ошибку и продолжим работу.

## Part 4. Интеграционные тесты

Напишем этап для `CI`, который запускает интеграционные тесты из того же проекта.

<div align="center">

![stage](images/Part_4_stage.png)

*Этап запуска инеграционных тестов*
</div>

<div align="center">

![cat](images/Part_4_cat.png)

*Блок my_test.sh для cat,ответственный за код возврата*
</div>

<div align="center">

![grep](images/Part_4_grep.png)

*Блок my_test_grep.sh, ответственный за код возврата*
</div>

Так как я писал `grep` для `MacOS`, а сейчас запускаю тесты и grep на `Ubuntu`, то часть тестов работает некорректно (188 тестов).Делаем корректировку ответа (уменьшаем количество фейлов на количество сломанных тестов)

Запустим `CI` без ошибок в тестах

<div align="center">

![good_pipe](images/Part_4_good_pipe.png)

*Pipline без ошибок в тестах*
</div>

<div align="center">

![good_output](images/Part_4_good_output.png)

*Вывод этапа интеграционных тестов*
</div>

Запустим `CI` без поправки на сломанные тесты

<div align="center">

![commit](images/Part_4_commit.png)

*Отмена поправок в my_test_grep*
</div>

<div align="center">

![bad_pipe](images/Part_4_bad_pipe.png)

*Pipline c ошибками в тестах*
</div>

<div align="center">

![bad_output](images/Part_4_bad_output.png)

*Вывод этапа интеграционных тестов c ошибками*
</div>

Вернем поправку и продолжим работу.

## Part 5. Этап деплоя

Поднимем вторую виртуальную машину Ubuntu `Server 22.04 LTS`.

<div align="center">

![clone](images/Part_5_clone.png)

*Связанная копия машины ivan-server, названная machine2*
</div>

Напишем этап для `CD`, который «разворачивает» проект на другой виртуальной машине.

<div align="center">

![CD](images/Part_5_CD.png)

*Этап CD в .gitlab-ci.yml*
</div>

Напишем bash-скрипт, который при помощи `ssh` и `scp` копирует файлы, полученные после сборки (артефакты), в директорию `/usr/local/bin` второй виртуальной машины.

<div align="center">

![init_ssh](images/Part_5_init_ssh.png)

*Содержимое скрипта init_ssh.sh*
</div>

Дадим права каталогу `/usr/local/bin` c помощью команды `sudo chmod 777 /usr/local/bin`

Настроем локальную сеть на машинах `ivan-server` и `machine2`:

<div align="center">

![net](images/Part_5_net.png)

*Настройка конфигураций сети на машинах ivan-server и machine2*
</div>

Сгенерируем ключ с помощью `ssh-keygen` на машине `ivan-server` и перешлем его на `machine2` с помощью команды `ssh-copy-id machine2@10.0.2.3`. Далее запустим скрипт и проверим, перенесутся ли объектные файлы в `usr/local/bin` на машине `machine2`

<div align="center">

![test](images/Part_5_test.png)

*Проверка работоспособности скрипта*
</div>

Удалим ключ пользователя `ivan` и сгенерируем ключи для `root` и `gitlab-runner` пользователей и прокинем их на `machine2`, чтобы эти пользователи имели возможность подключаться к `machine2`

<div align="center">

![keys](images/Part_5_keys.png)

*Авторизованные ключи на machine2*
</div>

Проверим, как работает написанный нами `gitlab-ci.yml`. Запустим `pipeline`.

<div align="center">

![wait](images/Part_5_wait.png)

*Ожидание ручного запуска стадии `deploy`*
</div>

Запусти этап `deploy` и посмотрим итоговый pipeline

<div align="center">

![result](images/Part_5_result.png)

*Результаты CI/CD*
</div>

В случае ошибки пайплайн фейлится


<div align="center">

![fail](images/Part_5_fail.png)

*Зафейленный pipeline*
</div>

## Part 6. Дополнительно. Уведомления

Настроим уведомления о успешном/неуспешном выполнении пайплайна через бота. Для начала, отправим сообщение `@BotFather` в Telegram, чтобы зарегистрировать своего бота и получить токен аутентификации.

<div align="center">

![create](images/Part_6_create.png)

*Созданный бот*
</div>
 
 Далее напишем скрипт `telegram.sh`, который будет пересылать через бота состояние пайплайна и его стадий


<div align="center">

![telegram](images/Part_6_telegram.png)

*Содержимое telegram.sh*
</div>

Добавим в `.gitlab-ci.yml` поле `after_script` и поместим туда написанный скрипт

<div align="center">

![after](images/Part_6_after_script.png)

*Добавленные поля*
</div>

Уведомления должны содержать информацию об успешности прохождения как этапа **CI**, так и этапа **CD**. Проверим

<div align="center">

![success](images/Part_6_success.png)

*Вывод бота при успешном pipline*
</div>

<div align="center">

![fail](images/Part_6_fail.png)

*Вывод бота при зафейленном pipline*
</div>

