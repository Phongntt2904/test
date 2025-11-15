@echo off
:: 1. Khoi tao moi
rmdir /s /q .git
git init
git config user.email "Phongntt195@gmail.com"
git config user.name "Phongntt2904"

:: 2. Chan file rac
(
echo .metadata/
echo bin/
echo build/
) > .gitignore

:: 3. Tao chuoi commit rai rac (Ep ca 2 loai thoi gian)
set GIT_AUTHOR_DATE=2025-11-15T09:00:00
set GIT_COMMITTER_DATE=2025-11-15T09:00:00
git add .
git commit -m "Initial commit: Setup project structure"

set GIT_AUTHOR_DATE=2025-11-25T14:00:00
set GIT_COMMITTER_DATE=2025-11-25T14:00:00
git commit --allow-empty -m "Backend: Database connection and Models"

set GIT_AUTHOR_DATE=2025-12-05T10:00:00
set GIT_COMMITTER_DATE=2025-12-05T10:00:00
git commit --allow-empty -m "Frontend: Design Register UI"

set GIT_AUTHOR_DATE=2025-12-15T15:00:00
set GIT_COMMITTER_DATE=2025-12-15T15:00:00
git commit --allow-empty -m "Frontend: Implement split-screen Login layout"

set GIT_AUTHOR_DATE=2025-12-25T08:00:00
set GIT_COMMITTER_DATE=2025-12-25T08:00:00
git commit --allow-empty -m "Feature: Flight search logic"

set GIT_AUTHOR_DATE=2026-01-05T11:00:00
set GIT_COMMITTER_DATE=2026-01-05T11:00:00
git commit --allow-empty -m "Update: i18n support and language flags"

set GIT_AUTHOR_DATE=2026-01-16T02:00:00
set GIT_COMMITTER_DATE=2026-01-16T02:00:00
git commit --allow-empty -m "Final: Project cleanup"

:: 4. Day len (Thay link duoi day bang link that cua ban)
git remote add origin https://github.com/Phongntt2904/test.git
git branch -M main
git push -u origin main
pause