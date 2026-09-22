#!/usr/bin/env bash

XX_VER=17
YY_VER=23

if [ $# -ne 1 ]; then
    echo "Usage: $0 <project_root>"
    echo "Перевіряє відповідність .c/.h файлів стилю з .clang-format (версії $XX_VER і $YY_VER)"
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

for ver in $XX_VER $YY_VER; do
    echo "==== CLANG-FORMAT $ver VERSION ===="
    clang-format-$ver -style=file --dry-run --Werror "$PROJECT"/src/*.c "$PROJECT"/include/*.h
    if [ $? -eq 0 ]; then
        echo "Результат: усі файли відповідають стилю"
    else
        echo "Результат: є розбіжності (див. вище)"
    fi
    echo "================================="
done
