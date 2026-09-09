# WoW Macro Builder

Генератор макросов для World of Warcraft с выбором цели: **target**, **focus** и комбинированные режимы.

## Запуск

Дважды кликните `start.bat` или откройте `index.html` в браузере.

## Локаль клиента (RU / EN)

В правом верхнем углу переключатель **RU / EN**:
- **RU** — названия скиллов как в русском клиенте WoW
- **EN** — названия для английского клиента

Выбор сохраняется в браузере.

## База скиллов

В `spells-database.js` — способности всех классов Retail по специализациям.
Переводы EN — в `wow-i18n.js`.

1. Выберите **класс** → **спек** → **скилл** из списка
2. Название подставится автоматически, вместе с рекомендуемыми настройками (target/focus, harm/help)
3. Скиллы сгруппированы: прерывания, контроль, исцеление, баффы, урон, защита, утилита
4. Есть **поиск** по названию и типу способности

Выбор класса и спека сохраняется между сессиями.

## Режимы цели

| Режим | Описание | Пример |
|-------|----------|--------|
| **Target** | Только текущая цель | `/cast [@target,exists,nodead] Polymorph` |
| **Focus** | Только фокус | `/cast [@focus,exists,nodead] Polymorph` |
| **Focus → Target** | Сначала фокус, если нет — цель | `/cast [@focus,…][@target,…] Polymorph` |
| **Target → Focus** | Сначала цель, если нет — фокус | `/cast [@target,…][@focus,…] Polymorph` |
| **Mouseover** | Юнит под курсором | `/cast [@mouseover,…] Rejuvenation` |
| **Self** | На себя | `/cast [@player] Power Word: Shield` |
| **Mouseover → Focus → Target** | Для хила с рейд-фреймов | `/cast [@mouseover,…][@focus,…][@target,…] Flash Heal` |

## Условия

- `exists` — цель существует
- `nodead` — цель жива
- `harm` — враждебная цель (для дпс/контроля)
- `help` — дружественная цель (для хила/баффов)
- `combat` / `nocombat` — в бою / вне боя

## Как вставить в WoW

1. Нажмите `Esc` → **Макросы**
2. **Создать** → выберите иконку и имя
3. Вставьте сгенерированный текст (`Ctrl+V`)
4. Перетащите макрос на панель действий

## Примеры

**Полиморф на фокус (arena):**
```
#showtooltip
/cast [@focus,exists,harm,nodead] Polymorph
```

**Хил: mouseover → focus → target:**
```
#showtooltip
/cast [@mouseover,exists,help,nodead][@focus,exists,help,nodead][@target,exists,help,nodead] Flash Heal
```

**Kick на фокус с Shift:**
```
#showtooltip
/cast [shift,@focus,exists,harm,nodead] Kick
```

## Публикация в интернет

Подробная инструкция — в файле [DEPLOY.md](DEPLOY.md).

Кратко: загрузите папку на **GitHub Pages**, **Netlify Drop** или **Cloudflare Pages** — сайт статический, бэкенд не нужен.
