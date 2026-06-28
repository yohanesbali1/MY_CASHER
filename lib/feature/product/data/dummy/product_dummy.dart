import 'package:my_casher/feature/product/data/models/product_models.dart';

class ProductDummy {
  static List<ProductModels> product_data = [
    ProductModels(
      id: 1,
      name: 'Mineral Water 600ml',
      price: 3500,
      quantity: 10,
      category_id: 1,
      image:
          "https://images.unsplash.com/photo-1616118132534-381148898bb4?w=120&h=120&fit=crop&auto=format",
    ),
  ];
}
