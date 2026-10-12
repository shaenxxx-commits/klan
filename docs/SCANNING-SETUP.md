# SCANNING-SETUP.md — KLAN

Інфраструктура сканування. Опис розділення Windows
і Ubuntu в конвеєрі сканів. Не метод (CONCEPT.md),
не конвеєр файлів (SCANS.md) — міст між ними.

Створено: 2026-10-11
Статус: WORKING BASELINE

## Причина розділення

Сканер Canon i-SENSYS MF3228 не підтримується
в Linux. Діагностика 2026-10-11:
- SANE: бекенд `pixma` не має профілю MF3228,
  `hwdb` помилково мапить USB `04a9:2684` на MF3240,
  бекенд застосовує чужий протокол → EIO.
- PPA sane-backends 1.3.1: не вирішує.
- VueScan: бачить сканер, але не має CLI-режиму.
- Офіційний драйвер Canon scangearmp2: недоступний
  для MF3228 у Ubuntu 24.04.
- Мережевий скан (eSCL/AirScan): MF3228 не має
  мережевого інтерфейсу.

Висновок: сканер працює тільки під Windows.

## Архітектура

    Windows                         Ubuntu
    -------                         ------
    MF3228                          ~/lch  (ext4, repo,
       │                                    git, sensitive/,
       ↓                                    pipeline, backup)
    D:\KLAN\scan-inbox\<class>\         ↑
    (drop zone, NTFS)                    │
                       ─── import-scan.sh ───┘
                       (mount rw, copy, verify,
                        move original, mount ro)

- Репозиторій KLAN живе **тільки** в Ubuntu на ext4.
  На NTFS не переноситься (аргументи: Unix-права,
  symlink pre-commit, git-корупція, CRLF,
  systemd paths, sensitive/ без chmod, периметр
  приватності).
- Windows-сторона виконує єдину роль: скан → файл
  у drop zone. Більше нічого не торкається KLAN.
- NTFS — транзитна зона. Файл живе там лічені
  години: скан під Windows → вимкнення → Ubuntu
  → import → оригінал переміщено в `.imported/`.

## Машина

- ASUS, dual-boot Windows + Ubuntu 24.04. Одна ОС
  за раз, не VM.
- Спільний диск: `/dev/sda2`, NTFS, label SHARED,
  UUID `64D60B1ED60AEFDA`. Використовується також
  під ігри/Steam/службові теки Windows.
- Windows Fast Startup: перевірено `ntfsfix -n`
  — диск чистий, rw доступний.

## Точка монтування (Ubuntu)

`/etc/fstab`:

    UUID=64D60B1ED60AEFDA /mnt/shared ntfs-3g ro,nofail,uid=1000,gid=1000,umask=0022,big_writes 0 0

- `ro` за замовчуванням — щоб при dual-boot
  випадкове вимкнення не пошкодило NTFS.
- `nofail` — Ubuntu завантажиться без диска.
- `ntfs-3g` (FUSE) не підтримує `remount`.
  Перехід ro↔rw — тільки `umount` + `mount`.

## Drop zone (NTFS)

Windows-літера: `D:\` (у ТЗ було `S:\`; фактично диск
у Windows змонтовано як `D:\`, мітка SHARED). Ubuntu
монтує `/dev/sda2` незалежно від літери — для конвеєра
різниці немає. Рішення 2026-10-12: у документах
використовуємо `D:\`; літеру `S:` не створюємо.

    D:\KLAN\scan-inbox\
      identity\
      civil\
      medical\
      property\
      financial\
      legal\
      correspondence\
      other\

Класи — з Q10.1. Розширення переліку не
передбачено; сумнівне — у `other`.

Windows-сторона кладе скан у підкаталог класу.
Клас обирається вручну при збереженні — це єдине
ручне рішення в усьому конвеєрі.

## Import (Ubuntu)

`meta/import-scan.sh`:
1. `umount /mnt/shared` → `mount -o rw`.
2. Для кожного файлу в `scan-inbox/<class>/`:
   - ID за Q10.4 (`YYYYMMDD-<class>-<NNN>`,
     дата = mtime файлу);
   - `cp` → `~/lch/sensitive/scans/_originals/<class>/<ID>/page-01.<ext>`;
   - перевірка розміру (`stat -c %s`);
   - `mv` оригіналу → `/mnt/shared/KLAN/.imported/<class>/`.
3. `umount` → `mount` (ro з fstab).
4. `trap EXIT` гарантує повернення в ro, навіть
   при помилці.

Прапор `--dry-run` — перегляд без змін.

Import запускається **вручну**. Автоматичний timer
не ставимо, поки конвеєр не перевірено на живому
матеріалі (принаймні один місяць).

## Межа відповідальності

- Windows: скан + клас + drop.
- Ubuntu: ID, перенос, EXIF-очищення (A8,
  відкладено), PDF/A, OCR, картка, маскування.
- Маскування — тільки Ubuntu (MASKING.md).
  Windows-сторона маскування не торкається.

## Що не робить ця архітектура

- Не дає CLI-скан під Ubuntu.
- Не прибирає ручний крок вибору класу.
- Не замінює повноцінний SANE-конвеєр, якщо
  колись MF3228 отримає підтримку.

## Ревізія

При появі:
- підтримки MF3228 у SANE → переглянути
  необхідність Windows-сторони;
- нового сканера → переглянути архітектуру.
