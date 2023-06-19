# Description of your result

## Description
Разработана функция фильтрации, позволяющая фильтровать базу данных по указанным критериям.

## How to

Создана функция фильтрации, принимающая список фильтруемых товаров и интерфейс IFilter, реализующий механизм фильтрации. Интрерфейс IFilter<T> использует Generics, поетому второй параметр функции apply (его тип) зависит от выбранного типа при имплементации интерфейса. 
Данная реализация обеспечивает бОльшую типобезопасность, чем, например, использование dynamic в качестве типа аргумента функции bool apply(Good good, T _filterField) в классе IFilter.
## Problems

Как лучше:

class FilterCategory implements IFilter<GoodCategories> {
  final GoodCategories _filterField;

  FilterCategory(this._filterField);
  @override
  bool apply(Good good, _filterField) {
    return good.type == _filterField;
  }
}
или передавать параметр как в способе ниже:
class FilterPrice implements IFilter<double> {
  final double maximalPrice;

  FilterPrice({required this.maximalPrice});
  @override
  bool apply(Good good, double maximalPrice) {
    if (good.price != null && good.price! <= maximalPrice) {
      return true;
    } else {
      return false;
    }
  }

  @override
  double get _filterField => maximalPrice;
}
## More

[Here you can brag about what you managed to implement or do something beyond the task]

