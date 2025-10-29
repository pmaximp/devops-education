# Решение домашнего задания к занятию ""Управляющие конструкции в коде Terraform"


# Полный проект находится [тут](https://github.com/pmaximp/devops-education/tree/terraform-03/Module_2/Homework_3/Full_project)


## Задание 1

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_1/images/image1.png)

## Задание 2

Прикладываю файлы [count-vm.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_2/count-vm.tf), [for_each-vm.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_2/for_each-vm.tf) и [locals.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_2/locals.tf), а также скрин.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_2/images/image2.png)

## Задание 3

Прикладываю файл [disk_vm.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_3/disk_vm.tf) и скрин.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_3/images/image3.png)

## Задание 4

Прикладываю файлы [ansible.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_4/ansible.tf) и [ansible.tftpl](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_4/ansible.tftpl), а также скрин.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_4/images/image4.png)

## Задание 5

Прикладываю файл [outputs.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_4/outputs.tf) и скрин.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_5/images/image5.png)

## Задание 6

Для наработки практики немного пошел дальше и модернизировал логику. В ходе выполнения все также будет создан динамический инвентарь и пременён плейбук. В ходе модернизации поправил ansible playbook [test.yml](ttps://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_6/test.yml) и все описал в файле [task_6.tf](ttps://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_6/task_6.tf). Вкратце, при установке `external_acess_bastion = true` создается бастион с nat=true у остальных инстансов установится nat = false, если `external_acess_bastion = false` бастион не создается у остальных инстансов установится nat = true . В случае наличия бастиона будет сформирован инвентарь с `ip_address` если бастиона нет, то с `nat_ip_address`. Eсли `provision=true` то применить плейбук на хосты из динамеского инвентори. Предварительно будет создан list имен ВМ после для каждой ВМ будет создан пароль. Результатом работы плейбука будет строка `### this (секрет для это ВМ) in (группа серверов) ###` в файле `/tmp/about.pin`. Полный код находится в ветке [terraform-03](https://github.com/pmaximp/devops-education/tree/terraform-03/Module_2/Homework_3/Full_project).

## Задание 7

Прикладываю файл [locals.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_7/locals.tf) и скрин. Фактически таким образом можно собрать любую конструкцию.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_7/images/image7.png)

## Задание 8

Прикладываю исправленный файл шаблона [resolved_task8.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_8/resolved_task8.tf) и скрин. Ошибка заключалась в попытке обращения к `host -> network_interface -> [index] -> nat_ip_address -> и тут найти ключ platform_id=host -> platform_id`. Чего, конечно быть не может, т.к. такого ключа в списке network_interface нет. Терраформ подсветил ошибку, указав, что она находится на 3 строке сверху, 85-86 символ.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_3/Task_8/images/image8.png)

## Задание 9

Прикладываю файл [outputs.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_3/Task_9/outputs.tf). Скрин не прикладываю т.к. уместить его на экран не удается. Вариант решения 9.2 мне не очень нравится, выглядит как "говнокод". Наверняка есть возможность реализовать создание этих массивов с использованием функций терраформа, но ввиду малого опыта дошел только до такого решения.
