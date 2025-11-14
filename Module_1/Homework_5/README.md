
# Решение практического задания к занятию "Оркестрация кластером Docker контейнеров на примере Docker Swarm"

## Задача 1

Сервера создаются с помощью terraform. Результат работы кода, готовые сервера и динамический инвентарь ansible. Далее создание кластера вручную, я использовал модуль `shell` в ansilbe передая агрументы для создания кластера. В качестве ответа прикрепляю [код](https://github.com/pmaximp/devops-education/blob/main/Module_1/Homework_5/Task_1/code/) и скрин.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_1/Homework_5/Task_1/images/image1.png)

## Задача 2

В ходе выполенения был модернизирован код из задания 1 для запуска сценария ansible из terraform. После создания ВМ в облаке подгружается конфигурация cloud-init для установки docker'a(лучше делать через ansible, т.к. требуется досточно времения для устновки). Далее будет запущен ansible-playbook для создания docker swarm clustr'a. И последнее что сделает код - это запустит проект с паролями для БД созданными в terraform. Из-за того, что используются ВМ в минимальной конфигурации пришлось добавить паузу перед первым подключением и дать время на установку docker(лучше ставить в ansible). Также для запуска приложения в кластере пришлось установить запуск haproxy и nginx только на мастере для проверки доступности(требуется настройки прокси). Также в конфигурации haproxy добавил resolver 127.0.0.11 для разрешения имен контейнеров. Из-за отсутсвия метода healt в приложении добавил slepp в CMD, чтобы дать время БД придти в себя и быть готовой. По хорошему бы написать метод healt или скрипт который будет проверять что БД готова и добавить его в heatlcheck compose web. В качестве ответа прикрепляю [код](https://github.com/pmaximp/devops-education/blob/main/Module_1/Homework_5/Task_2/code/), [ссылку](https://github.com/pmaximp/shvirtd-example-python) на fork c доработками и скрины.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_1/Homework_5/Task_2/images/image2_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_1/Homework_5/Task_2/images/image2_2.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_1/Homework_5/Task_2/images/image2_3.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_1/Homework_5/Task_2/images/image2_4.png)

## Задача 3

Вероятно вернусь к ней позже. Но в целом идея и варианты реализации были разобраны в Задаче 2. Только тут реализован более красивый подход с использованием ролей.