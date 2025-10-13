# Решение практического задания к занятию "Оркестрация группой Docker контейнеров на примере Docker Compose."

## Задача 1

[Ссылка на custom-nginx:1.0.0 на Docker Hub](https://hub.docker.com/repository/docker/maximper/custom-nginx/general)

**Структура решения 1-го задания:**

        Homework_3/
        ├── Task_1/
        │   ├── Dockerfile
        │   └── configs/
        │       └── index.html
        ...

## Задача 2

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_2/images/image2.png)

## Задача 3

#### Ответ по п.3

> Т.к. при выполнении команды `docker attach` мы подключаемся к стандартному потоку ввода(stdin)/вывода(stdout)/ошибок(stderr) контейнера то выполнении `Ctrl + C` мы отправляем сигнал **SIGINT** процессу, т.е. завершаем его. Фактически мы останавливаем единственно-живой процесс в контейнере и так он получает код 0 что означает успешную транзакцию. Т.к. контейнер жив до тех пор пока жив основной процесс, в этом случае nginx.

#### Ответ по п.10

> Причина падения контейнера в следующем, после изменении порта с 80 на 81 мы выполнили команду `nginx -s reload` которая в буквальном смысле сказла, что я перестану слушать порт 80 и начну слушать 81, но демону докера об этом никто не рассказал. Он попытался проверить работает ли сервис по 80 порту, т.к. в Dockerfile nginx'a есть инструкция `EXOPSE 80`, но не получил ответа и решил что процесс мертв, а если процесс мертв, то контейнер не работает. Решение проблемы приведено на скрине, но изменение конфигурации контейнера с остановной демона не есть хорошо, на мой взгляд. Вариант с reload демона вылглядит лучше. Я бы сделал как описано в п.5 или п.4 [приведенной статьи](https://www.baeldung.com/ops/assign-port-docker-container), но все зависит от конкретного кейса.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_3/images/image3_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_3/images/image3_2.png)

## Задача 4

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_4/images/image4.png)

## Задача 5

**Структура решения 5-го задания:**

        Homework_3/
        └── Task_5/
            ├── compose.yaml
            └── images/
                └── image5_1.png
                ...
                └── image5_4.png

#### Ответ по п.1

> Запустится compose.yml, т.к. имеет более высокий приоритет в порядке поиска файлов Compose. Если нужно в явном виде указать файл можно воспользоваться опцией -f.

#### Ответ по п.7

> Предупреждение говорит о контейнерах без проекта. Т.к. при запуске проект состоял из двух сервисов то docker-compose видит, что при запуске после удаления файла `compose.yml` не хватает сервиса в проекте. В данном случае проектом является рабочий каталог, т.е. task_5.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_5/images/image5_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_5/images/image5_2.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_5/images/image5_3.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Homework_3/Task_5/images/image5_4.png)
