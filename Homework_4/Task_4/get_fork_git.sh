#!/bin/bash

set -e

PROJECT_NAME="shvirtd-example-python"
URL="https://github.com/pmaximp/$PROJECT_NAME.git"
WORK_DIR="/opt"

# Скрипт запускается только из под root
if [ "$EUID" -ne 0 ]; then
    echo "Use from root!"
    exit 1
fi

# Проверка установление ли git
if ! which git &> /dev/null; then
    apt update && apt install -y git && apt clean
fi

# Переходит в рабочий каталог
cd $WORK_DIR

# Проверка загружен ли репозиторий и обновление. Если репозитория нет, то клонируем
if [ -d "$WORK_DIR/$PROJECT_NAME/.git" ]; then
    echo "Обновление репозитория"
    cd $PROJECT_NAME && git pull
else
    echo "Клонирование репозитрия"
    git clone $URL
fi

# Проверка загружен ли compose.yaml файл. Если загружен то запускаем. Docker уже установлен по условию задачи
if [ ! -f "$WORK_DIR/$PROJECT_NAME/compose.yaml" ]; then
    echo "Нет файла compose.yaml"
    exit 1
else
    cd $WORK_DIR/$PROJECT_NAME
    docker compose up -d
fi

echo "Done."