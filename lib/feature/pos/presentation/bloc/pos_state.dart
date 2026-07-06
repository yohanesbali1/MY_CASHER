part of 'pos_bloc.dart';

@immutable
class PosState {
  final List<ProductModels> products_data;
  final List<CategoryProductModel> category_data;
  final List<CartItemModel> cartItems;

  final int currentIndex;

  final bool isLoading;

  static const _unset = Object();

  final double total;

  final int totalItem;

  const PosState({
    this.products_data = const [],
    this.category_data = const [],
    this.cartItems = const [],
    this.isLoading = false,
    this.currentIndex = 0,
    this.total = 0,
    this.totalItem = 0,
  });

  PosState copyWith({
    List<ProductModels>? products_data,
    List<CategoryProductModel>? category_data,
    bool? isLoading,
    List<CartItemModel>? cartItems,
    int? currentIndex,
    double? total,
    int? totalItem,
  }) {
    return PosState(
      products_data: products_data ?? this.products_data,
      category_data: category_data ?? this.category_data,
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      currentIndex: currentIndex ?? 0,
      total: total ?? this.total,
      totalItem: totalItem ?? this.totalItem,
    );
  }
}
