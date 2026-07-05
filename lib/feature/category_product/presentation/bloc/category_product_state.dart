part of 'category_product_bloc.dart';

enum FormMode { create, update, list }

@immutable
class CategoryProductState {
  final List<CategoryProductModel> data;
  final bool isLoading;
  final FormMode? status;

  final int? id;

  final String name;
  final String? nameError;

  static const _unset = Object();

  const CategoryProductState({
    this.data = const [],
    this.isLoading = false,
    this.status = FormMode.list,
    this.name = '',
    this.nameError,
    this.id,
  });

  CategoryProductState copyWith({
    List<CategoryProductModel>? data,
    bool? isLoading,
    Object? status = _unset,
    String? name,
    Object? nameError = _unset,
    int? id,
  }) {
    return CategoryProductState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      status: identical(status, _unset) ? this.status : status as FormMode?,
      name: name ?? this.name,
      nameError: identical(nameError, _unset)
          ? this.nameError
          : nameError as String?,
      id: id ?? this.id,
    );
  }
}
