# Решение домашнего задания к занятию "Введение в Terraform"

## Задание 1

2. Согласно .gitignore личную и секретную информацию можно хранить в файле personal.auto.tfvars. Файл .terraformrc находится в домашнем каталоге пользователя для настройки registry для загрузки плагинов или провайдеров. Файл .tfstate описывает текущую конфигурацию или, если так можно сказать, в результаты крайнего `terraform apply`.

3. "result": "xkE3BF3bgDHLBhkf"

4. Ошибки были в строках:
    >`resource "docker_image" {` - ошибка заключается в отсутсвии уникального имени ресурса. Т.е. без указания имени мы не сможем получить результат работы этого ресурса или дата соурс, что логично. При выполнении terraform validate это подсвечивается.
    
    >`resource "docker_container" "1nginx" {` - ошибка заключается в том, что уникальное имя начинается с цифры, это не поддерживает terraform. По информации из ошибки, имя ресурса или дата соурс может начинаться с буквы или нижнего подчеркивания, а само название может содержать только буквы, цифры, подеркивание и тире.
    
    >`name  = "example_${random_password.random_string_FAKE.resulT}"` - ошибка заключается в неправильном имени ранее описанного ресурса в строке `15`. Тут 2 пути: 1 - исправить имя ресурса `random_password` в строке `15`.  2 - исправить имя в строке `name` ресурса `docker_container`. И вторая ошибка заключается в несуществующем методе `resulT` для ресурса `random_password`, а именно ошибка в регистре последней букв. 

5. Исправленный вариант прикладываю [main.tf](https://github.com/pmaximp/devops-education/tree/main/Module_2/Homework_1/Task_1/main.tf).

    ![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_1/Task_1/images/image1_1.png)

    *Наблюдения...*
    > При применнении конфигурации видно, что поле name обозначено как sensitive value. Вероятно это из-за использования ресурса `random_password`, terraform понимает что это чувствительные данные.Но почему-то все равно кладет их в стате файл, но это другое...

6. Опасность применения ключа `-auto-apporove` заключается в отсутсвии валидации человеком. Случаются такие моменты, что написанный код человеком воспринимается программой иначе. Это может быть вызвано сменой версионности ПО или человеческим фактором(ошибки в коде и т.д.). В связи с этим отсутствие валидации со стороны человека, т.е. просмотра того что и как будет изменено, может привести к пагубным или вовсе необратимым последсвтиям в инфраструктуре.
Могу предоложить, что ключ может использоваться при запуске в какой-либо среде без возможности отправить ключевое значение `yes` в stdin. Например при использовании в ansible сценарии.
Как по мне, перед любыми изменения стоит использовать `terraform plan` для просмтора измениний в случае применений.
    ![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_1/Task_1/images/image1_2.png)

7. Результат [terraform.tfstate](https://github.com/pmaximp/devops-education/tree/main/Module_2/Homework_1/Task_1/terraform.tfstate) прикладываю.

8. Образ не был удален из-за использования параметра `keep_locally = true`. Что в прямом смысле означает "сохранить локально". Также эта информация подкрепляется по ссылке в [документации](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs/resources/image#keep_locally-1). Значение по-умолчанию `false`, т.е. образ будет удален при `terraform destroy` если ключ не задан.

## Задание 2

В качестве ответа на задание прикрепляю итоговый [main.tf](https://github.com/pmaximp/devops-education/tree/main/Module_2/Homework_1/Task_2/main.tf) и скрин.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_1/Task_2/images/image2.png)


## Задание 3

Код запустился, предварительно также потребовалось настроить зеркала для загрузки плагинов и провайдеров. Для наглядности изменил название контейнера. Разницы в рамках запуска и работы [текущего](https://github.com/pmaximp/devops-education/tree/main/Module_2/Homework_1/Task_3/main.tf) кода не заметил. При применении более сложного кода, вероятно, они будут.

![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_1/Task_2/images/image3_1.png)
![alt text](https://github.com/pmaximp/devops-education/raw/main/Module_2/Homework_1/Task_2/images/image3_2.png)