
## Порівняння версій clang-format (17 vs 23)

- clang-format-17 на неформатованому коді: 2522 знайдені порушення стилю (`check_format.sh`), виправлено автоформатуванням (`make_format_17.sh`) — 1405 insertions / 1219 deletions.
- clang-format-23 поверх уже відформатованого версією 17 коду: лише 2 insertions / 2 deletions.
- Висновок: між версіями 17 і 23 форматування практично ідентичне — стиль детермінований `.clang-format`-файлом, версія самого інструменту впливає мінімально.

## Фінальна валідація

- До форматування: 2522 порушення (check_format.sh на сирих файлах ядра).
- Після make_format_17.sh + make_format_23.sh: 4 залишкові діагностики.
- Усі 4 — в одному файлі, `dummy/include/raid56.h`, рядки 267-268:
dummy/include/raid56.h:267:30: error: code should be clang-formatted
dummy/include/raid56.h:267:32: error: code should be clang-formatted
dummy/include/raid56.h:268:30: error: code should be clang-formatted
dummy/include/raid56.h:268:32: error: code should be clang-formatted

- Причина: clang-format-17 не погоджується з clang-format-23 щодо пробілів усередині виразу `((u64)-2)` / `((u64)-1)` (макроси `RAID5_P_STRIPE` / `RAID6_Q_STRIPE`) — граничний випадок, де правила форматування castів відрізняються між версіями. Не реальна помилка стилю, а різниця версій інструменту.
