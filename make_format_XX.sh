#!/usr/bin/env bash
VER=17   # у другому файлі — VER=23

if [ $# -ne 1 ]; then
    echo "Usage: $0 <project_root>"
    echo "Форматує .c/.h файли на місці версією clang-format-$VER"
    exit 1
fi
PROJECT="$1"

if [ ! -d "$PROJECT" ]; then
    echo "Помилка: директорія $PROJECT не існує"
    exit 1
fi

if [ ! -f "$PROJECT/.clang-format" ]; then
    echo "Помилка: у $PROJECT немає .clang-format"
    exit 1
fi

clang-format-$VER -style=file -i "$PROJECT"/src/*.c "$PROJECT"/include/*.h
echo "Відформатовано clang-format-$VER"
