import 'product_categories_interactor.dart';
import 'product_repository.dart';

void main(List<String> args) {
  final ProductCategoriesInteractor productCategoriesInteractor =
      ProductCategoriesInteractor(productsRepository: ProductsRepository());
  final result = productCategoriesInteractor.avaibleCategories;
  print(result);
}
