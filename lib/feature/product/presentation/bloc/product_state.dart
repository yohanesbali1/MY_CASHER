part of 'product_bloc.dart';

enum FormMode { update, list, create }

@immutable
class ProductState {
  final List<ProductModels> products_data;
  final ProductModels? show_product_data;
  final List<CategoryProductModel> category_data;
  final CategoryProductModel? category;
  final bool isLoading;

  final String? icon;
  final String? iconError;

  final String? name;
  final String? nameError;

  final int? categoryId;
  final String? categoryError;

  final int price;
  final String? priceError;

  final int quantity;
  final String? quantityError;

  final FormMode? status;

  final int? id;

  static const _unset = Object();

  const ProductState({
    this.products_data = const [],
    this.category_data = const [],
    this.show_product_data,
    this.isLoading = false,
    this.price = 0,
    this.priceError,
    this.quantity = 0,
    this.quantityError,
    this.icon,
    this.iconError,
    this.name,
    this.nameError,
    this.categoryId,
    this.categoryError,
    this.status = FormMode.list,
    this.id,
    this.category,
  });

  ProductState copyWith({
    Object? products_data = _unset,
    Object? category_data = _unset,
    Object? show_product_data = _unset,
    bool? isLoading,
    int? price,
    Object? priceError = _unset,
    int? quantity,
    Object? quantityError = _unset,
    Object? icon = _unset,
    Object? iconError = _unset,
    Object? name = _unset,
    Object? nameError = _unset,
    Object? categoryId = _unset,
    Object? categoryError = _unset,
    Object? status = _unset,
    Object? id = _unset,
    Object? category = _unset,
  }) {
    return ProductState(
      products_data: identical(products_data, _unset)
          ? this.products_data
          : products_data as List<ProductModels>,

      category_data: identical(category_data, _unset)
          ? this.category_data
          : category_data as List<CategoryProductModel>,

      show_product_data: identical(show_product_data, _unset)
          ? this.show_product_data
          : show_product_data as ProductModels?,

      isLoading: isLoading ?? this.isLoading,

      price: price ?? this.price,

      priceError: identical(priceError, _unset)
          ? this.priceError
          : priceError as String?,

      quantity: quantity ?? this.quantity,

      quantityError: identical(quantityError, _unset)
          ? this.quantityError
          : quantityError as String?,

      icon: identical(icon, _unset) ? this.icon : icon as String?,

      iconError: identical(iconError, _unset)
          ? this.iconError
          : iconError as String?,

      name: identical(name, _unset) ? this.name : name as String?,

      nameError: identical(nameError, _unset)
          ? this.nameError
          : nameError as String?,

      categoryId: identical(categoryId, _unset)
          ? this.categoryId
          : categoryId as int?,

      categoryError: identical(categoryError, _unset)
          ? this.categoryError
          : categoryError as String?,

      status: identical(status, _unset) ? this.status : status as FormMode?,

      id: identical(id, _unset) ? this.id : id as int?,

      category: identical(category, _unset)
          ? this.category
          : category as CategoryProductModel?,
    );
  }
}
