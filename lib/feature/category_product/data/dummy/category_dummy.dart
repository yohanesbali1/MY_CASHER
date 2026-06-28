import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';

class CategoryDummy {
  static List<CategoryProductModel> category_data = [
    CategoryProductModel(id: 1, name: 'Makanan', isEdit: true),
    CategoryProductModel(id: 2, name: 'Minuman', isEdit: true),
    CategoryProductModel(id: 3, name: 'Snack', isEdit: true),
    CategoryProductModel(id: 4, name: 'Peralatan', isEdit: true),
    CategoryProductModel(id: 5, name: 'Lainnya', isEdit: false),
  ];
}
