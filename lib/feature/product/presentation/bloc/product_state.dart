part of 'product_bloc.dart';

@immutable
class ProductState {
  final List<ProductModels> products_data;
  final bool isLoading;
  const ProductState({this.products_data = const [], this.isLoading = false});

  ProductState copyWith({List<ProductModels>? products_data, bool? isLoading}) {
    return ProductState(
      products_data: products_data ?? this.products_data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
