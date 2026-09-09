# Скрипт публикации WoW Macro Builder на GitHub
# Запуск: правый клик → "Выполнить с PowerShell" или в терминале:
#   cd "C:\Users\Никита\wow-macro-builder"
#   powershell -ExecutionPolicy Bypass -File .\publish-github.ps1

$ErrorActionPreference = "Stop"

$git = "C:\Program Files\Git\bin\git.exe"
$gh  = "C:\Program Files\GitHub CLI\gh.exe"
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Test-Path $git)) {
    Write-Host "Git не найден. Установите: winget install Git.Git" -ForegroundColor Red
    exit 1
}
if (-not (Test-Path $gh)) {
    Write-Host "GitHub CLI не найден. Установите: winget install GitHub.cli" -ForegroundColor Red
    exit 1
}

Set-Location $projectDir

Write-Host ""
Write-Host "=== WoW Macro Builder → GitHub ===" -ForegroundColor Cyan
Write-Host ""

# --- Шаг 1: имя и email для коммита (только локально, git config не меняется) ---
$userName  = Read-Host "Ваше имя для Git (например: Nikita)"
$userEmail = Read-Host "Email для Git (лучше noreply от GitHub: ID+login@users.noreply.github.com)"

if ([string]::IsNullOrWhiteSpace($userName))  { $userName = "Nikita" }
if ([string]::IsNullOrWhiteSpace($userEmail)) { $userEmail = "user@example.com" }

$env:GIT_AUTHOR_NAME     = $userName
$env:GIT_COMMITTER_NAME  = $userName
$env:GIT_AUTHOR_EMAIL    = $userEmail
$env:GIT_COMMITTER_EMAIL = $userEmail

# --- Шаг 2: git init / commit ---
if (-not (Test-Path ".git")) {
    & $git init
    & $git branch -M main
}

$status = & $git status --porcelain
if ($status) {
    & $git add .
    & $git commit -m "Initial commit: WoW Macro Builder with RU/EN locale support."
    Write-Host "Коммит создан." -ForegroundColor Green
} else {
    $commits = & $git rev-parse HEAD 2>$null
    if (-not $commits) {
        & $git add .
        & $git commit -m "Initial commit: WoW Macro Builder with RU/EN locale support."
    }
    Write-Host "Файлы уже закоммичены." -ForegroundColor Yellow
}

# --- Шаг 3: вход в GitHub ---
Write-Host ""
Write-Host "Сейчас откроется вход в GitHub (браузер или код)." -ForegroundColor Cyan
Write-Host "Выберите: GitHub.com → HTTPS → Login with a web browser" -ForegroundColor Cyan
Write-Host ""
& $gh auth login

# --- Шаг 4: создать репозиторий и отправить ---
$repoName = Read-Host "Имя репозитория на GitHub [wow-macro-builder]"
if ([string]::IsNullOrWhiteSpace($repoName)) { $repoName = "wow-macro-builder" }

Write-Host ""
Write-Host "Создаю репозиторий $repoName и загружаю файлы..." -ForegroundColor Cyan

& $gh repo create $repoName --public --source=. --remote=origin --push

Write-Host ""
Write-Host "=== Готово! ===" -ForegroundColor Green
Write-Host ""

$login = (& $gh api user -q .login 2>$null)
if ($login) {
    Write-Host "Репозиторий:  https://github.com/$login/$repoName" -ForegroundColor White
    Write-Host ""
    Write-Host "Чтобы включить сайт (GitHub Pages):" -ForegroundColor Cyan
    Write-Host "  1. Откройте https://github.com/$login/$repoName/settings/pages"
    Write-Host "  2. Source: Deploy from a branch"
    Write-Host "  3. Branch: main → / (root) → Save"
    Write-Host ""
    Write-Host "Сайт будет здесь (через 1-2 мин):" -ForegroundColor Cyan
    Write-Host "  https://$login.github.io/$repoName/" -ForegroundColor White
}

Write-Host ""
Read-Host "Нажмите Enter для выхода"
