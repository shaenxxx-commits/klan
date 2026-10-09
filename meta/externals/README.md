# EXTERNALS — KLAN

Каталог зовнішніх прогонів. Один файл на один прогін
однієї моделі.

Ім'я файлу: `YYYY-MM-DD-<slug>.md`

Зовнішні — незалежні аналітичні вузли. Вони не є
частиною KLAN і не ухвалюють рішень. Їхній висновок —
вхідні дані для рішень оператора.

## Правило представлення

Кожен зовнішній на кожному прогоні починає відповідь
блоком:

    IDENT: <slug моделі на дату прогону>
    VERSION: <якщо відома>
    PLATFORM: web / api / cli
    ACCESS: free / paid / subscription
    DATE: <YYYY-MM-DD>

Без цього блоку прогін не враховується.

## Правило нумерації

Кожне повідомлення зовнішнього починається з
наскрізного номера MS<N> на першому рядку. Лічильник
локальний для кожного зовнішнього, стартує з MS1,
монотонний, не перезапускається.

## Доступ до матеріалів

Репозиторії (навігація):
- KLAN: https://github.com/shaenxxx-commits/klan
- LAB: https://github.com/shaenxxx-commits/nova-cortex-lab
- Envoy: https://github.com/shaenxxx-commits/envoy

Файли у форматі raw (прямий текст, без JS-обгортки):

KLAN:
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/README.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/docs/AGENT.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/docs/CONCEPT.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/docs/CURRENT_STATE.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/docs/ONTOLOGY.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/docs/DECISIONS.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/docs/REDACTIONS.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/meta/operator-preferences.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/meta/handoff-current.md
- https://raw.githubusercontent.com/shaenxxx-commits/klan/main/meta/open-questions.md

LAB:
- https://raw.githubusercontent.com/shaenxxx-commits/nova-cortex-lab/main/README.md
- https://raw.githubusercontent.com/shaenxxx-commits/nova-cortex-lab/main/METHOD.md
- https://raw.githubusercontent.com/shaenxxx-commits/nova-cortex-lab/main/CONCEPT.md

Envoy:
- https://raw.githubusercontent.com/shaenxxx-commits/envoy/main/README.md
- https://raw.githubusercontent.com/shaenxxx-commits/envoy/main/docs/DDA-v0.1.md
- https://raw.githubusercontent.com/shaenxxx-commits/envoy/main/docs/FIELD-SELECTION-v0.1.md

Дані KLAN (raw/, sensitive/, evidence/) зовнішнім
не передаються ніколи.

## Рамка питань (стандартна)

1. Що в KLAN незрозуміло без LAB/envoy?
2. Де KLAN суперечить методам LAB/envoy або дублює їх?
3. Які рішення виглядають прийнятими до появи
   практичної потреби?
4. Що в KLAN пропущено, але обов'язкове на цій стадії?
5. Де термінологія розходиться між трьома гілками?

Рамка може розширюватись окремим рішенням.

## Формат запису

Після прогону у файл `YYYY-MM-DD-<slug>.md` пишеться:
- блок IDENT;
- рамка питань;
- повний текст відповіді зовнішнього;
- нотатка ведучого (за потреби).

Файл append-only. Наступний прогін — новий файл.

## Правила

- Ведучий не редагує текст зовнішнього.
- Ведучий не видає свій текст за текст зовнішнього.
- Якщо зовнішній дав суперечливі висновки — обидва
  фіксуються як є.
