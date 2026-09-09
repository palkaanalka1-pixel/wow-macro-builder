# Как опубликовать WoW Macro Builder в интернет

Сайт полностью статический (HTML + JS), сервер не нужен. Подойдёт любой бесплатный хостинг для статики.

---

## Способ 1: GitHub Pages (рекомендуется)

**Бесплатно, постоянная ссылка вида** `https://ваш-логин.github.io/wow-macro-builder/`

### Шаги

1. **Создайте аккаунт** на [github.com](https://github.com), если его ещё нет.

2. **Установите Git** — [git-scm.com/download/win](https://git-scm.com/download/win)

3. **Создайте репозиторий** на GitHub:
   - New repository → имя `wow-macro-builder` → Public → Create

4. **Загрузите файлы** из папки проекта в терминале:

```powershell
cd "C:\Users\Никита\wow-macro-builder"
git init
git add index.html spells-database.js wow-i18n.js README.md
git commit -m "Initial commit: WoW Macro Builder"
git branch -M main
git remote add origin https://github.com/ВАШ-ЛОГИН/wow-macro-builder.git
git push -u origin main
```

5. **Включите GitHub Pages:**
   - Репозиторий → **Settings** → **Pages**
   - Source: **Deploy from a branch**
   - Branch: **main** → папка **/ (root)** → Save

6. Через 1–2 минуты сайт будет доступен по адресу из пункта 1.

> `start.bat` на GitHub Pages не нужен — открывается сразу `index.html`.

---

## Способ 2: Netlify (перетащить папку)

**Без Git, за 2 минуты.**

1. Зайдите на [app.netlify.com/drop](https://app.netlify.com/drop)
2. Перетащите папку `wow-macro-builder` в окно браузера
3. Netlify выдаст ссылку вида `https://random-name.netlify.app`
4. В аккаунте можно задать своё имя: **Domain settings** → **Edit site name**

---

## Способ 3: Cloudflare Pages

1. Аккаунт на [dash.cloudflare.com](https://dash.cloudflare.com)
2. **Workers & Pages** → **Create** → **Pages** → **Upload assets**
3. Загрузите содержимое папки `wow-macro-builder`
4. Deploy → получите ссылку `https://wow-macro-builder.pages.dev`

---

## Способ 4: Vercel

1. [vercel.com](https://vercel.com) → Sign up
2. **Add New Project** → **Import** (через GitHub) или drag-and-drop
3. Root Directory: `wow-macro-builder`
4. Deploy

---

## Что загружать

Минимальный набор файлов:

| Файл | Обязателен |
|------|------------|
| `index.html` | да |
| `spells-database.js` | да |
| `wow-i18n.js` | да |
| `README.md` | нет |
| `start.bat` | нет (только для локального запуска) |

---

## Свой домен (опционально)

На GitHub Pages / Netlify / Cloudflare можно привязать домен (например `wow-macros.ru`):

- Купить домен у регистратора (Reg.ru, Namecheap и т.д.)
- В настройках хостинга добавить DNS-записи, которые покажет панель
- Включить HTTPS (обычно автоматически)

---

## Обновление сайта после изменений

**GitHub Pages:**
```powershell
cd "C:\Users\Никита\wow-macro-builder"
git add .
git commit -m "Update spells and UI"
git push
```

**Netlify Drop:** перетащите папку заново.

---

## Локальная проверка перед публикацией

Откройте `index.html` в браузере или запустите простой сервер:

```powershell
cd "C:\Users\Никита\wow-macro-builder"
python -m http.server 8080
```

Откройте [http://localhost:8080](http://localhost:8080)
