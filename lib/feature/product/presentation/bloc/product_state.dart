part of 'product_bloc.dart';

enum FormMode { update, list }

@immutable
class ProductState {
  final List<ProductModels> products_data;
  final ProductModels? show_product_data;
  final bool isLoading;

  final double price;
  final String? priceError;

  final int quantity;
  final String? quantityError;

  final FormMode? status;

  final int? id;

  const ProductState({
    this.products_data = const [],
    this.show_product_data,
    this.isLoading = false,
    this.price = 0,
    this.priceError,
    this.quantity = 0,
    this.quantityError,
    this.status,
    this.id,
  });

  ProductState copyWith({
    List<ProductModels>? products_data,
    ProductModels? show_product_data,
    bool? isLoading,
    double? price,
    String? priceError,
    int? quantity,
    String? quantityError,
    FormMode? status,
    int? id,
  }) {
    return ProductState(
      products_data: products_data ?? this.products_data,
      show_product_data: show_product_data ?? this.show_product_data,
      isLoading: isLoading ?? this.isLoading,
      price: price ?? this.price,
      priceError: priceError ?? this.priceError,
      quantity: quantity ?? this.quantity,
      quantityError: quantityError ?? this.quantityError,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }
}
