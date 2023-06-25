# Description of your result

## Description

Создан интерактор, который возвращает map согласно требованиям:

Выходные данные представлены словарем (мапой), где:

в роли ключа — название категории типа `String`;
в роли значения — словарь подкатегорий, которые входят в данную категорию.
В свою очередь для мапы подкатегорий:

в роли ключа — название подкатегории типа `String`;
в роли значения — список названий товаров, входящих в подкатегорию, являющуюся ключом.

Ваша цель — структурировать товары по подкатегориям, а подкатегории — по категориям. При этом в конечную подборку не должны попасть товары, которые:

уже просрочены;
закончились на складе.
Подкатегории, содержащие только товары, подпадающие под условия выше, должны отсутствовать в финальной выборке, равно как и категории, состоящие из таких подкатегорий.


## How to

Реализация состоит из 3 етапов:
1. Фильтрация просроченных и отсутсвующих товаров (используя where)
2. Объединение товаров по типу (Фрукты: [Персик, Яблоко, Груша]...), для хранения испольуется map, елементы составляющие value могут повторяться
3. Объединение типов по категориям (Растительная пища: {Фрукты, Овощи, Крупы }...), для хранения испольуется map, елементы составляющие value не могут повторяться (используется Set)
4. Map из п.3 преобразуется в результирующую map.

## Problems

Наверное лучше я бы использовал package collection? https://pub.dartlang.org/packages/collection
Моё решение кажется мне непонятным, а Вам?
## More

