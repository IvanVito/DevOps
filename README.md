# Записка по проектам

Этот репозиторий содержит четыре проекта, каждый из которых имеет свои особенности и задачи. В этом документе вы найдете краткое описание выполненных работ для каждого проекта.

## Содержание

1. [Проект 1: Установка и администрирование операционной системы Linux (Linux)](#проект-1-установка-и-администрирование-операционной-системы-linux-linux)
2. [Проект 2: Настройка сетей на виртуальных машинах (LinuxNetwork)](#проект-2-настройка-сетей-на-виртуальных-машинах-linuxnetwork)
3. [Проект 3: Разработка Docker-образа для веб-сервера (SimpleDocker)](#проект-3-разработка-docker-образа-для-веб-сервера-simpledocker)
4. [Проект 4: Настройка CI/CD процесса (CICD)](#проект-4-настройка-cicd-процесса-cicd)

## Проект 1: Установка и администрирование операционной системы Linux (Linux)

[Перейти к проекту](https://github.com/IvanVito/DevOps/tree/main/Linux)

В этом проекте было выполнено следующее:

1. **Установка ОС**
   - Установлен **Ubuntu 20.04 Server LTS** на виртуальную машину без графического интерфейса через VirtualBox. Проверена версия ОС и добавлен скриншот.

2. **Создание пользователя**
   - Создан новый пользователь и добавлен в группу `adm`. Проверено наличие пользователя, приложены скриншоты.

3. **Настройка сети ОС**
   - Изменено имя машины, установлена временная зона и настроены сетевые параметры. Применены статические IP-адреса и DNS, проверена их работоспособность.

4. **Обновление ОС**
   - Обновлены системные пакеты до последней версии, проверено отсутствие доступных обновлений.

5. **Использование команды sudo**
   - Разрешено выполнение команд с помощью `sudo` для нового пользователя. Изменен hostname от его имени.

6. **Установка и настройка службы времени**
   - Настроена автоматическая синхронизация времени. Проверено состояние с помощью команды `timedatectl show`.

7. **Установка и использование текстовых редакторов**
   - Установлены **VIM**, **NANO** и **JOE**. Проведена работа с каждым редактором.

8. **Установка и базовая настройка сервиса SSHD**
   - Установлен и настроен SSHD, изменен порт на 2022. Проверен статус службы.

9. **Установка и использование утилит top и htop**
   - Установлены и использованы утилиты **top** и **htop** для мониторинга системы.

10. **Использование утилиты fdisk**
    - Получена информация о жестком диске с помощью `fdisk -l`.

11. **Использование утилиты df**
    - Получена информация о файловых системах с помощью `df` и `df -Th`.

12. **Использование утилиты du**
    - Получен размер папок и содержимого в `/var/log` с помощью `du`.

13. **Установка и использование утилиты ncdu**
    - Установлена **ncdu** и проверены размеры папок.

14. **Работа с системными журналами**
    - Просмотрены и проанализированы журналы `/var/log/dmesg`, `/var/log/syslog` и `/var/log/auth.log`.

15. **Использование планировщика заданий CRON**
    - Настроено задание для выполнения команды `uptime` каждые 2 минуты.

## Проект 2: Настройка сетей на виртуальных машинах (LinuxNetwork)

[Перейти к проекту](https://github.com/IvanVito/DevOps/tree/main/LinuxNetwork)

В этом проекте выполнено следующее:

1. **Инструмент `ipcalc`**
   - Использован для вычисления сетевых адресов и масок. Проверено обращение к приложению на `localhost` с различных IP-адресов.

2. **Статическая маршрутизация между двумя машинами**
   - Настроены сетевые интерфейсы и статическая маршрутизация для двух виртуальных машин. Проверена связь и добавлены маршруты.

3. **Утилита `iperf3`**
   - Измерена скорость соединения между двумя машинами, переведены скорости в различные единицы измерения.

4. **Сетевой экран (Firewall)**
   - Настроены фаерволлы с помощью `iptables`, протестированы правила доступа с использованием `nmap`.

5. **Статическая маршрутизация сети**
   - Настроены пять виртуальных машин, установлены маршруты и IP-переадресация.

6. **Динамическая настройка IP с помощью DHCP**
   - Настроена служба DHCP для одной из машин.

## Проект 3: Разработка Docker-образа для веб-сервера (SimpleDocker)

[Перейти к проекту](https://github.com/IvanVito/DevOps/tree/main/SimpleDocker)

В этом проекте выполнены следующие этапы:

1. **Готовый Docker**
   - Скачан и проверен образ **nginx**. Запущен и проверен доступ к стартовой странице.

2. **Операции с контейнером**
   - Извлечен и изменен конфигурационный файл **nginx**. Контейнер экспортирован, удален и импортирован обратно.

3. **Мини веб-сервер**
   - Разработан мини-сервер на **C** с использованием FastCGI. Настроен **nginx** для проксирования запросов.

4. **Свой Docker**
   - Написан Dockerfile для создания образа с мини-сервером. Проверено его функционирование.

5. **Dockle**
   - Сканирован образ с помощью **Dockle** для выявления уязвимостей. Исправлены ошибки и предупреждения.

6. **Базовый Docker Compose**
   - Создан файл `docker-compose.yml` для поднятия двух контейнеров и проверки их работы.

## Проект 4: Настройка CI/CD процесса (CICD)

[Перейти к проекту](https://github.com/IvanVito/DevOps/tree/main/CICD)

В этом проекте выполнено следующее:

1. **Настройка gitlab-runner**
   - Установлен и зарегистрирован **gitlab-runner** на виртуальной машине с **Ubuntu Server 22.04 LTS**.

2. **Сборка**
   - Написан этап сборки в файле `_gitlab-ci.yml`, использующий `make` для сборки.

3. **Тест кодстайла**
   - Настроен этап для проверки кодстайла с помощью `clang-format`.

4. **Интеграционные тесты**
   - Добавлен этап для запуска интеграционных тестов.

5. **Этап деплоя**
   - Установлен второй **Ubuntu Server 22.04 LTS** для деплоя артефактов с помощью `ssh` и `scp`.

6. **Дополнительно. Уведомления**
   - Настроены уведомления в **Telegram** о статусе пайплайнов.
