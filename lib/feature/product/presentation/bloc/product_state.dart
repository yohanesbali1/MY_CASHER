part of 'product_bloc.dart';

@immutable
class ProductState {
  final List<ProductModels> products;
  final bool isLoading;
  const ProductState({this.products = const [], this.isLoading = false});

  ProductState copyWith({List<ProductModels>? products, bool? isLoading}) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
