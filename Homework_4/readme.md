
# Решение практического задания к занятию "Практическое применение Docker"

## Задача 0 ##

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_0/images/image0.png)

## Задача 1 ##

**Структура решения 1-й задачи:**

        Homework_4/
        ...
        ├── Task_1/
        │   ├── Dockerfile.python
        │   ├── .dockerignore
        │   ├── main.py
        │   └── images/
        │       ├── image1_1.png
        |       ...
        |       └── image1_7.png
        ...

### Ответ по п.1

<u>Комментарии по п.1</u>

>При многочисленных попытках выполнить multistage build получал ошибку вида `ModuleNotFoundError: No module named 'pydantic_core._pydantic_core`. Погуглив, оказалось, что в slim и alpine используются разные бинарные сборки и передача артефектов имеет неочевидные нюансы. В итоге удалось собрать только на slim и только на alpine. В решение загрузил версию Dockefile с alpine. В качестве демонстрации работы приложения(без прокси) в контейнере. Была создана сеть с драйвером bridge для резолва внутри docker network. Запущен контейнер с mysql в новой сети. При запуске контейнера с приложением переопределена переменная DB_HOST='имя контейнера с mysql'. Результат работы продемонстрирован на скринах.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_2.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_3.png)


### Ответ по п.2

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_4.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_5.png)


### Ответ по п.3

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_6.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_1/images/image1_7.png)


## Задача 2 ##

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_2/images/image2.png)


## Задача 3 ##


![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_3/images/image3.png)


## Задача 4 ##

**Структура решения 4-й задачи:**

        Homework_4/
        ...
        ├── Task_4/
        │   ├── get_fork_git.sh
        │   └── images/
        |       └── image4.png
        ...

[Ссылка на fork-репозиторий shvirtd-example-python](https://github.com/pmaximp/shvirtd-example-python)

<u>Комментарии</u>

>Fork репозитория прикладываю. Скрипт называется `get_fork_git.sh` и находится в текущем репозитории.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_4/images/image4.png)


## Задача 5 ##

**Структура решения 5-й задачи:**

        Homework_4/
        ...
        ├── Task_5/
        │   ├── Dockerfile
        │   ├── .dockerignore
        │   ├── setup.sh
        │   ├── images/
        │   │   └── image5.png
        |   └── bin 
        |       ├── crontab
        |       └── setup_backup.sh
        ...


<u>Комментарий</u>

> Самая большая проблема которую на которую ушло очень много времени, в связи с ограничения задания, это отсутсвие модуля `caching_sha2_password.so` для MySQL в образе `schnitzler/mysqldump`. Было 2 пути решения. 1 -  использовать другой образ для снятия бэкапа, например тот же самый mysql:8, но насколько я понял по заданию необходимо написать скрипт для сбора бэкапа и crontab для периодического запуска. Т.е. использовать подход 1 сервис = 1 контейнер. Поэтому пришлось пойти по второму пути. Поэтому пересобрал контейнер с добавленным mariadb-connector-c. Dockefile прикрепляю. Добавлять в скрипт установку `mariadb-connector-c` не хотелось т.к. задания будут выполняться по сron каждый раз запускать установку не есть хорошо. Более того при начилии закрытого контура не всегда есть возможность стянуть что-либо с удаленного репозитория. Вероятно я слишком заморочился и было достаточно `docker exec -it database mysqldump ...` и создание скрипта который будет дергать `docker exec` и запуск его по `cron`. Но для наработки опыта лучше так. Для делоя всего этого написал мини скрипт, который создает каталоги, назначает права и поднимает контейнер. Ждет 1 минуту чтобы 1-й бэкап был готов и завершается. Для доставки использовал был ansile, но время поджимало и ansible будет дальше) Надеюсь я правильно понял задачу и зря ее не усложнил.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_5/images/image5.png)


## Задача 6 ##

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_6/images/image6_1.png)


## Задача 6.1 ##

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_4/Task_6/images/image6_2.png)
