#!/bin/ash

# Эта часть мне не нравится, но из-за отсутсвия конструкции source alpine пришлось изобрести велосипед. 
# Буду признателен если подскажите как сделать красивее и не тащить переменные через файл в docker, т.к. это потенциальная угроза.
/usr/bin/env | /bin/grep MYSQL > ~/.mysql_env
/bin/chmod u+x ~/.mysql_env
~/.mysql_env 

now=$(/bin/date +"%s_%Y-%m-%d")
/usr/bin/mysqldump --opt -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} > "/backup/${now}_${MYSQL_DATABASE}.sql"
