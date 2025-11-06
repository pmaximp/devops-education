# Решение домашнего задания к занятию "Продвинутые методы работы с Terraform"


# Полный проект находится [тут](https://github.com/pmaximp/devops-education/tree/terraform-04/Module_2/Homework_4/Full_project)


## Задание 1

Прикладываю файлы [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_1/main.tf), [locals.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_1/locals.tf), [vms_variables.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_1/vms_variables.tf) и [cloud-init.yml](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_1/cloud-init.yml) а также скрины.


![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_1/images/image1_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_1/images/image1_2.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_1/images/image1_3.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_1/images/image1_4.png)

## Задание 2

В качестве решения прикладываю код и документацию модуля [modules_vpc](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_2/module_vpc). Тажке приклдываю файл [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_2/main.tf). При выполнии кода с использованием модуля из-за разных названий сетей и подсетей, созданные ВМ подлежат пресозданию. Т.к. не можем пересоздать сети в которых есть объекты. По условиям задания не описано как должна вести себя инфраструтура, поэтому не стал усложнять код и добавлять название подсетей. 
Чтобы обойти пересоздание ВМ использовал возможность переименования в state файле, что наверное, не есть хорошей практикой. Но в случае изначального использования модуля таких проблем бы не было. Скрины прикрепляю. 1 destroy вызван из-за того, что модуль создает только в одной зоне подсеть. Более универсальное решение находится в задании 4.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_2/images/image2_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_2/images/image2_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_2/images/image2_1.png)

## Задание 3

Прикладываю скрины процесса удаления и добавления объектов из state-файла без внесения измениния в облачную инфраструктуру.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_3/images/image3_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_3/images/image3_2.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_3/images/image3_3.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_3/images/image3_4.png)

## Задание 4

Прикладываю код модуля [module_vpc](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_4/module_vpc) и [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_4/main.tf) с примером вызова, а также скрины.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_4/images/image4_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_4/images/image4_2.png)

## Задание 5

Will come later...

## Задание 6

В процессе решения потратил достаточно много времени, чтобы понять как это работает. В итоге, создать бакет у меня получилось с ролью `editor`, а вот чтобы его настроить потребовалась роль `storage.admin`. Предварительно был создан сервисный аккаунт через `yc cli` и ему выдана роль storage.admin на каталог. Создать сервисный аккаунт и дать ему роль storage.admin на каталог в коде не удается из-за того, что сервисный аккаунт из под которого я работаю в terraform имеет роль editor, а она не может назначать роли на объекты. Для создания сервисного аккаунта в коде, на сколько я понял, потберовалась бы роль admin, т.к. по описанию у нее есть возможность назначать роли на объекты. Или использовать в коде УЗ в облаке и iam токен для выполнения этих действий, но это не есть хорошо. В рамках обучения, можно использовать любой вариант, но на реальных объектах все зависит от орг. структуры, наверное. Как по мне вариант создания сервисного аккаунта через yc cli или web допустим.

Также добавило проблем несоответвие readme и variables в yc-s3. Переменной `storage_admin_service_account` - нету. Вместо используется `existing_service_account`. Пришлось почитать код модуля, но это даже плюс)

В качестве ответа прикладываю файлы [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_6/main.tf), [outputs.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_6/outputs.tf), [providers.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_6/providers.tf) и [variables.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_6/variables.tf). id, access_key и secret_key передавал через файл `personal.auto.tfvars` и скрин(бакет пересоздан).

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_6/images/image6_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_6/images/image6_2.png)

## Задание 7

Прикрепляю файлы [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_7/main.tf), [outputs.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_7/outputs.tf) и [providers.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_4/Task_7/providers.tf), а также скрин. На сколько успел разобраться, добавить секрет в дефолтный каталог secret нет возможности, поэтому создал новый каталог с типом kv версии 2. 

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_7/images/image7_1.png)

## Задание 8

В качестве ответа прикладываю скриншоты. Полный код проекта находится в ветке [terraform-04](https://github.com/pmaximp/devops-education/tree/terraform-04/Module_2/Homework_4/Full_project). Не очень нравится обращение к результатам работы vpc, а именно обращение к зонам (`local.vpc_dev.ru-central1-a.network_id`), но ввиду того что в списке объектов есть только зона и ipv4 cidr решил итерироваться по зонам дотупности. По хорошему бы изменить формат передачи подсетей или формат вывода. Или не использовать outputs, а обращаться к элементам в state файле напрямую.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_8/images/image8_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_8/images/image8_2.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_8/images/image8_3.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_4/Task_8/images/image8_4.png)