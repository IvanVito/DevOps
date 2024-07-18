# DO5_SimpleDocker-1 lesleyle

## Part 1. Готовый докер

Возьмем официальный докер-образ с nginx и выкачаем его при помощи ``docker pull nginx``

<div align="center">

![dowload nginx](images/Part_1_nginx.png)

*Выкаченный докер-образ с nginx*
</div>

Проверим наличие докер-образа через ``docker images``.

<div align="center">

![docker](images/Part_1_docker-image.png)

*Список доступных докер-образов*
</div>

Запустим докер-образ через docker ``run -d [image_id|repository]``

<div align="center">

![start_docker](images/Part_1_start_docker.png)

*Запуск докер-образа*
</div>

Проверим, что образ запустился через ``docker ps``

<div align="center">

![start_docker](images/Part_1_docker_ps.png)

*Вывод docker ps*
</div>

Посмотрим информацию о контейнере через `docker inspect [container_id]`

<div align="center">

![info](images/Part_1_info.png)

*Информация о контейнере*
</div>

По выводу команды определим и поместим в отчёт список замапленных портов и ip контейнера.

Замапленные порты (mapped ports) в Docker - это порты, которые были связаны между хостом и контейнером. Это позволяет контейнеру обмениваться данными с внешним миром через сеть.

<div align="center">

![Bindings](images/Part_1_maps.png)

*Замапленные порты*
</div>

<div align="center">

![ip](images/Part_1_ip.png)

*ip контейнера*
</div>

Размер контейнера мы найдем через `docker ps -s`

<div align="center">

![info](images/Part_1_size.png)

*Информация о размере контейнера*
</div>

Здесь 1.09 кб это размер контейнера, а 187 мб - общий размер всех ресурсов, используемых контейнером

Остановим докер образ через `docker stop [container_id|container_name]` и проверим, что образ остановился через `docker ps`.

<div align="center">

![stop](images/Part_1_stop.png)

*Остановка образа и проверка*
</div>

Запустим докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду `run`.

<div align="center">

![stop](images/Part_1_new_docker.png)

*Запуск докера с портами 80 и 443*
</div>

Проверим, что в браузере по адресу `localhost:80` доступна стартовая страница nginx

<div align="center">

![browser](images/Part_1_new_docker.png)

*Стартовая страница nginx*
</div>

Перезапустим докер контейнер через `docker restart [container_id]` и проверим, что контейнер запустился.

<div align="center">

![restart](images/Part_1_restart.png)

*Презапуск и проверка контейнера*
</div>

## Part 2. Операции с контейнером

Прочитаем конфигурационный файл `nginx.conf` внутри докер контейнера через команду `exec`

<div align="center">

![nginx_conf](images/Part_2_nginx_conf.png)

*Содержимое nginx.conf*
</div>

Создадим на локальной машине файл `nginx.conf` и настрой в нем по пути `/status` отдачу страницы статуса сервера nginx.

<div align="center">

![nginx_conf_local](images/Part_2_nginx_conf_local.png)

*Содержимое nginx.conf на локальной машине*
</div>

Скопируем созданный файл `nginx.conf` внутрь докер-образа через команду `docker cp` и перезапустим `nginx` внутри докер-образа через команду `exec`.

<div align="center">

![reload](images/Part_2_reload.png)

*Копируем nginx.conf и перезапускаем nginx*
</div>

Проверим, что по адресу `localhost:80/status` отдается страничка со статусом сервера `nginx`.

<div align="center">

![status](images/Part_2_status.png)

*Содержимое localhost:80/status*
</div>

Экспортируем контейнер в файл `container.tar `через команду `export` и остановим контейнер

<div align="center">

![export](images/Part_2_export.png)

*Экспорт и остановка контейнера*
</div>

Удалим образ через ``docker rmi [repository]``, не удаляя перед этим контейнер, а потом удалим остановленный контейнер.

<div align="center">

![export](images/Part_2_delete.png)

*Удаление докер образа и контейнера*
</div>

Импортируем контейнер обратно через команду `import` и запустим импортированный контейнер.

<div align="center">

![reborn](images/Part_2_reborn.png)

*Импорт и запуск контейнера*
</div>

Здесь:

Опция `-c` позволяет указать команду, которая будет выполнена при запуске контейнера на основе образа. 
 
В данном случае опция `-c 'CMD ["nginx", "-g", "daemon off;"]`' указывает, что при запуске контейнера на основе импортированного образа должна быть выполнена команда `nginx -g "daemon off;"`. Эта команда запускает веб-сервер nginx в переднем плане, без демонизации. 
 
Опция `CMD` используется для установки команды по умолчанию, которая будет выполнена при запуске контейнера. В данном случае опция `-c` используется для переопределения команды по умолчанию, указанной в Dockerfile, при импорте образа.  
 
Опция `-g` используется для установки глобальных директив конфигурации `nginx`.

Проверим, что по адресу `localhost:80/status` отдается страничка со статусом сервера `nginx`.

<div align="center">

![check](images/Part_2_check.png)

*Проверка странички `localhost:80/status`*
</div>

## Part 3. Мини веб-сервер

Напишем мини-сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!

<div align="center">

![check](images/Part_3_server.png)

*Мини-сервер на С*
</div>

Здесь:

`fcgi_stdio.h` cодержит определения функций и констант для работы с FastCGI.

Функция `FCGI_Accept`, которая ожидает входящий FastCGI-запрос от веб-сервера. Если функция FCGI_Accept возвращает значение больше или равное нулю, это означает, что запрос успешно принят и может быть обработан.

Функция `printf` служит для отправки HTTP-заголовка `Content-Type: text/html` и тела ответа `hello world` в стандартный вывод. Этот вывод будет перенаправлен в `FastCGI-сокет` и отправлен клиенту в качестве ответа на входящий запрос.

Запустим написанный мини-сервер через `spawn-fcgi` на порту `8080`.

<div align="center">

![start](images/Part_3_start.png)

*Запуск мини-сервера*
</div>

`Spawn-fcgi` — это утилита, которая запускает приложение FastCGI и управляет его жизненным циклом. Она может запускать приложение в фоновом режиме, перенаправлять ввод/вывод в файлы или сокеты, и мониторить работу приложения, перезапуская его в случае необходимости

Напишем свой `nginx.conf`, который будет проксировать все запросы с `81` порта на `127.0.0.1:8080`.Для этого перейдем в `/etc/nginx` и исправим `nginx.conf`

<div align="center">

![proxy](images/Part_3_proxy.png)

*Файл nginx.conf*
</div>

Скопируем файл конфигурации в папку `server/nginx` проекта.

Проверим, что в браузере по `localhost:81` отдается написанная страничка.

<div align="center">

![prove](images/Part_3_prove.png)

*Страничка по адресу localhost:81*
</div>

## Part 4. Свой докер

Напишем свой докер-образ, который:

1) собирает исходники мини сервера на FastCgi из Части 3;

2) запускает его на 8080 порту;

3) копирует внутрь образа написанный nginx.conf;

4) запускает nginx.

<div align="center">

![container](images/Part_4_container.png)

*Свой докер-образ*
</div>

Соберем написанный докер-образ через `docker build` при этом указав имя и тег.

<div align="center">

![build](images/Part_4_build.png)

*Сборка контейнера*
</div>

Проверим через `docker images`, что все собралось корректно.

<div align="center">

![image](images/Part_4_image.png)

*Докер образ*
</div>

Запустим собранный докер-образ с маппингом `80` порта локальной машины на `81` порт контейнера и маппингом папки `./nginx` внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а

<div align="center">

![start](images/Part_4_start.png)

*Запущенный докер-образ*
</div>

Проверим, что по `localhost:80` доступна страничка написанного мини сервера.

<div align="center">

![check](images/Part_4_check.png)

*Страничка на localhost:80*
</div>

Допишем в `./nginx/nginx.conf` проксирование странички `/status`, по которой надо отдавать статус сервера nginx.

<div align="center">

![nginx](images/Part_4_nginx.png)

*Содержимое ./nginx/nginx.conf*
</div>

Перезапустим докер-образ 

<div align="center">

![restart](images/Part_4_restart.png)

*Перезапуск контейнера*
</div>

Проверим, что теперь по `localhost:80/status` отдается страничка со статусом nginx

<div align="center">

![status](images/Part_4_status.png)

*Содержимое localhost:80/status*
</div>

## Part 5. Dockle

Просканируем образ из предыдущего задания через `dockle repository`.

<div align="center">

![fatal](images/Part_5_fatal.png)

*Ошибки и педупреждения докер-образа*
</div>

Исправим образ так, чтобы при проверке через dockle не было ошибок и предупреждений.

<div align="center">

![no_fatal](images/Part_5_no_fatal.png)

*Исправленнй докер-образ*
</div>

Здесь:

`rm -rf /var/lib/apt/lists` - очистка кэша apt-get.

`RUN groupadd -r appgroup && useradd -r -g appgroup appuser` :

1) `groupadd -r appgroup`- Создает системную группу appgroup.

2) `useradd -r -g appgroup appuser` - Создает системного пользователя `appuser` и добавляет его в группу `appgroup`. Флаги `-r` создают системного пользователя, а опция `-g` назначает пользователю его основную группу.

`chown -R appuser:appgroup /app /var /run` - Изменяет владельца и группу для указанной директории /app и всех ее содержимых файлов и поддиректорий рекурсивно.

`USER appuser` - Эта инструкция переключает исполнение последующих команд в Dockerfile на пользователя `appuser`. Это помогает улучшить безопасность контейнера, поскольку процессы будут запущены с меньшими привилегиями.

`HEALTHCHECK CMD curl -f http://localhost:81/ || exit 1` - устанавливает curl-запрос к `http://localhost:81/` в качестве способа проверки работоспособности контейнера. Если контейнер не может успешно выполнить этот запрос, он будет считаться нерабочим. 

<div align="center">

![check](images/Part_5_check.png)

*Проверка исправленного образа*
</div>

## Part 6. Базовый Docker Compose

Напишем файл `docker-compose.yml`, с помощью которого:

1) Поднимем докер-контейнер из Части `5` (он должен работать в локальной сети, т.е. не будем использовать инструкцию `EXPOSE` и мапить порты на локальную машину).

2) Подними докер-контейнер с `nginx`, который будет проксировать все запросы с `8080` порта на `81` порт первого контейнера.

3) Замапим `8080` порт второго контейнера на `80` порт локальной машины.

<div align="center">

![yml](images/Part_6_yml.png)

*docker-compose.yml файл*
</div>

<div align="center">

![yml](images/Part_6_nginx.png)

*Файл nginx.conf контейнера nginx*
</div>

Остановим все запущенные контейнеры, соберем и запустим проект с помощью команд `docker-compose build` и `docker-compose up`.


<div align="center">

![build](images/Part_6_build.png)

*Сборка проекта*
</div>

Проверим, что в браузере по `localhost:80` отдается написанная нами ранее страничка

<div align="center">

![check](images/Part_6_check.png)

*Содержимое по адресу localhost:80*
</div>