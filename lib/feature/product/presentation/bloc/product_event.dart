part of 'product_bloc.dart';

enum ProductField { quantity, price, name, icon, categoryId }

@immutable
sealed class ProductEvent {
  const ProductEvent();
}

class ProductLoad extends ProductEvent {}

class ProductReset extends ProductEvent {}

class ProductModeChange extends ProductEvent {
  final FormMode? mode;
  const ProductModeChange(this.mode);
}

class ProductFieldChanged extends ProductEvent {
  final ProductField field;
  final dynamic value;

  const ProductFieldChanged({required this.field, required this.value});
}

class ProductCreate extends ProductEvent {
  const ProductCreate();
}

class ProductShowData extends ProductEvent {
  final int id;
  const ProductShowData({required this.id});
}

class ProductUpdate extends ProductEvent {
  const ProductUpdate();
}

class ProductDelete extends ProductEvent {
  final int id;
  const ProductDelete({required this.id});
}
