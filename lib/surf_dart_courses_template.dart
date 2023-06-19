void main(List<String> args) {
  final goods = parseDB(articles);
  final filtered = applyFilter(
    goods,
    FilterPrice(maximalPrice: 100),
  );
  printGoodsTable(filtered);
}

//Требуемая функция
List<Good> applyFilter(List<Good> goods, IFilter filter) {
  final result = <Good>[];
  for (final good in goods) {
    if (filter.apply(good, filter._filterField)) {
      result.add(good);
    }
  }
  return result;
}

// Печать результатов
void printGoodsTable(List<Good> goods) {
  int i = 1;
  for (final element in goods) {
    print(
        "${i++}\t${element.type.label}\t${element.name}\t${element.price} Руб\t${element.count} шт");
  }
}

//Вспомогателная функция для парсинга базы в строковом представлении
List<Good> parseDB(String db) {
  final strings = db.split('\n')..removeLast();
  final goods = <Good>[];
  for (final element in strings) {
    final fields = element.split(',');
    GoodCategories category = GoodCategories.values.firstWhere((element) {
      return element.label.toUpperCase() == fields[1].toUpperCase();
    });

    goods.add(
      Good(
        type: category,
        name: fields[2],
        count: double.parse(fields[4]),
        price: double.parse(fields[3]),
      ),
    );
  }
  return goods;
}

// Интерфейс фильтра, Интерфейс Filter — абстрактный класс с методом `apply`,
// принимает товар и возвращает `true`, если товар подходит под требования фильтра, иначе `false`.
abstract class IFilter<T> {
  final T _filterField;

  IFilter(this._filterField);
  bool apply(Good good, T _filterField);
}

// Фильтрация товаров по категориям
class FilterCategory implements IFilter<GoodCategories> {
  final GoodCategories _filterField;

  FilterCategory(this._filterField);
  @override
  bool apply(Good good, _filterField) {
    return good.type == _filterField;
  }
}

// Фильтрация товаров по по цене (не больше указанной);
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

// Фильтрация товаров по количеству остатков на складе (меньше указанной).
class FilterCount implements IFilter<double> {
  final double minimalCount;

  FilterCount({required this.minimalCount});

  @override
  bool apply(Good good, double _filterField) {
    if (good.count != null && good.count! >= _filterField) {
      return true;
    } else {
      return false;
    }
  }

  @override
  double get _filterField => minimalCount;
}

class Good {
  final GoodCategories type;
  final String name;
  double? price;
  double? count;

  Good({required this.type, required this.name, this.price, this.count});
  factory Good.bread({required name, price, count}) {
    return Good(
        type: GoodCategories.bread, name: name, price: price, count: count);
  }
  factory Good.milk({required name, price, count}) {
    return Good(
        type: GoodCategories.milk, name: name, price: price, count: count);
  }
  factory Good.water({required name, price, count}) {
    return Good(
        type: GoodCategories.water, name: name, price: price, count: count);
  }
}

final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

enum GoodCategories {
  bread("Хлеб"),
  milk("Молоко"),
  water("Вода");

  const GoodCategories(this.label);
  final String label;
}
