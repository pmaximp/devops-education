# Решение домашнего задания к занятию "Введение в Terraform"


# !!! Полный проект находится [тут](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Full_project) !!!


## Задание 1

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_1/images/image1_1.png)
![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_1/images/image1_2.png)

<u>Ответы на вопросы:</u>

1 ошибка заключалась в неправильном наименовании платформы. По информации из [документации](https://yandex.cloud/ru/docs/compute/concepts/vm-platforms) платформы `standart-v4` - не существует. Для уменьшения стоимости ВМ использовал платформу `standard-v2`.

2 ошибка заключается в недопустимом колличестве ядер процессора. По информации из [документации](https://yandex.cloud/ru/docs/compute/concepts/performance-levels#available-configurations) только платформа highfreq-v3 имеет возможность использовать 1 ядро. Для standard-v2 допустимо использовать минимум 2 ЦПУ.

Параметры могут пригодится в ходе обучения для уменьшения стоимости ВМ. Параметр `preemptible = true` означает создать прерываемую ВМ, которая проработает максимум 24 часа, но если будет какой-то технических сбой на облаке или нехватка ресурсов для запуска обычной виртуальной машины в той же зоне доступности, прерываемая ВМ будет остановлена. Параметр `core_fraction=5` пригодится для экономии гранта. По информации из [докуменатции](https://yandex.cloud/ru/docs/compute/concepts/performance-levels#available-configurations) ВМ с уровнем производительности меньше 100% имеют доступ к вычислительной мощности физических ядер как минимум на протяжении указанного процента от единицы времени. Т.е. при выбранном уровне производительности в моей работе, ВМ будет иметь доступ к физическим ядрам как минимум 5%, т.е. 50 мс в течении каждой секунды. ВМ с уровнем производительности меньше 100% предназначены для запуска приложений, не требующих высокой производительности и не чувствительных к задержкам.

## Задание 2

Прикладываю файл [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_2/main.tf) и [variables.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_2/variables.tf) после выполнения задания.

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_2/images/image2.png)

## Задание 3

Прикладываю файл [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_3/main.tf) и [vms_platform.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_3/vms_platform.tf) после выполнения задания.

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_3/images/image3.png)

## Задание 4

Прикладываю файл [outputs.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_4/outputs.tf). Не исключаю, что не доконца понял формулировку задания, но для вывода только ip-адресов воспользовался формирование через `jq`. Буду благодарен если расскажите как можно еще вывести только ip-адреса.

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_4/images/image4.png)

## Задание 5

Прикладываю файл [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_5/main.tf), [vms_platform.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_5/vms_platform.tf) и [locals.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_5/locals.tf) после выполнения задания. По информации из открытых источников, не везде можно использовать интерполяционные переменные. На сколько я нашел информацию, мы не можем использовать интерполяцию при использовании `variable "name" {}`. 

Вопрос:
>Если необходимо собрать значение из нескольких переменных, то мы можем сделать это только блоке `resources` или `data`?

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_5/images/image5.png)

## Задание 6

Прикладываю файл [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_6/main.tf), [vms_platform.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_6/vms_platform.tf), [locals.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_6/locals.tf) и [variables.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_6/variables.tf) после выполнения задания. Также для удобства и тренировки переделал создание сетей с использованием map(object()).

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_6/images/image6.png)

## Задание 7

В качестве ответа прикладываю скриншот. На сколько успел разобраться для "вычленения" каких-либо специфичных параметров необходимо использовать функции. В этом случае использовал `length()` и `keys()`.

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_7/images/image7.png)

## Задание 8

В качестве ответа прикрепляю файл [variables.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_8/variables.tf) и скрин. Не до конца понятна формулировка задания. 

По порядку:
1. "Напишите и проверьте переменную test" - это понятно, создать переменную и заполнить ее в соответсвии с примером.
2. "и полное описание ее type в соответствии со значением из terraform.tfvars" - это **не** понятно. Для простоты, я бы заменил `из terraform.tfvars` на `из примера ниже`. Т.к. сейчас при прочтении появляется мысль искать где-то terraform.tfvars, а его в источните нету...

Может, конечно, я вовсе не понял задание или только мне не понятно и остальных не будет проблем с этим заданием))

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_8/images/image8.png)

## Задание 9

В качестве ответа прикрепляю файл [main.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_9/main.tf) и [vms_platform.tf](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_9/vms_platform.tf) и скрин serial console. При использовании nat_gateway, мы не можем подключиться к ВМ из WAN. Первое не знаем публичный адрес NAT GW. Второе нет проброса до нашей ВМ. Если даже узнаем публичный адрес NAT GW то при попытке подключиться по 22, GW не поймет что с ним делать и просто отросит, т.к. в его таблце нет записей с нашим запросом, напримем, по 22 порту. Но у нас есть возможность выйти в глобальную сеть с ВМ, т.к. при отправке через NAT GW, он фиксирует в своей таблице сокет в котором есть информации о сером адресе:порт нашей ВМ и белом адресе:порт NAT GW, когда приходит ответ от сервера nat смотри в свою таблицу и обратно приобразует в серый адрес, тем самым доставляя пакет до ВМ. Для настройки доступа к ВМ скорей всего есть способы, но пока я с ними в Yandex Cloud не знаком. 

P.S. В описании могут страдать сетевые формулировки если объяснять на пальцах и рисовать при этом, то получится лучше)

![alt text](https://github.com/pmaximp/devops-education/blob/main/Module_2/Homework_2/Task_9/images/image9.png)
