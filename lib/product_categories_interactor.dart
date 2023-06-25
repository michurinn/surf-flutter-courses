import 'product_repository.dart';
import 'raw_product_item.dart';

// Класс для преобразования входного списка товаров
class ProductCategoriesInteractor {
  final ProductsRepository productsRepository;
  ProductCategoriesInteractor({required this.productsRepository});

  Categories get avaibleCategories {
    // Получим список продуктов, которые имеются в наличии с походящим сроком
    final Iterable<RawProductItem> products = productsRepository.productList
        .where((element) =>
            element.expirationDate.isAfter(DateTime.now()) && element.qty > 0);
    // Получим map подкатегорий вида
    // {Фрукты: [Персик, Яблоко, Груша], Напитки: [Молоко, Кефир], Сыры: [Гауда, Маасдам]...
    final SubCategories subcategories = Map.fromIterable(
      products.map((e) => e.subcategoryName),
      key: (category) => category.toString(),
      value: (subcategoryName) => products
          .where((product) => product.subcategoryName == subcategoryName)
          .map(
            (e) => e.name,
          )
          .toList(),
    );

    // Получим map категорий вида
    // {Растительная пища: {Фрукты, Овощи, Крупы}, Молочные продукты: {Напитки, Сыры}, Мясо: {Птица, Не птица}}...
    final categories = Map.fromIterable(
      products.map((e) => e.categoryName),
      key: (category) => category.toString(),
      value: (subcategoryName) => products
          .where((product) => product.categoryName == subcategoryName)
          .map(
            (e) => e.subcategoryName,
          )
          .toSet(),
    );
    // Подставим в categories подходящие subcategories
    final Categories result = categories.map(
      (key, value) {
        return MapEntry(
          key,
          Map.fromIterable(
            value,
            value: (element) {
              final key =
                  subcategories.keys.firstWhere((item) => item == element);
              return subcategories[key] ?? [];
            },
          ),
        );
      },
    );
    return result;
  }
}

typedef SubCategories = Map<String, List<String>>;
typedef Categories = Map<String, SubCategories>;
