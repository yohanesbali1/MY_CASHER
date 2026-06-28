part of 'category_product_bloc.dart';

enum CategoryField { name, isEdit }

@immutable
sealed class CategoryProductEvent {
  const CategoryProductEvent();
}

class CategoryProductStarted extends CategoryProductEvent {
  const CategoryProductStarted();
}

class CategoryModeChange extends CategoryProductEvent {
  final FormMode? mode;
  const CategoryModeChange(this.mode);
}

class CategoryFieldChanged extends CategoryProductEvent {
  final CategoryField field;
  final dynamic value;

  const CategoryFieldChanged({required this.field, required this.value});
}

class CategoryProductCreate extends CategoryProductEvent {
  const CategoryProductCreate();
}

class CategoryShowData extends CategoryProductEvent {
  final int id;
  const CategoryShowData(this.id);
}

class CategoryProductUpdate extends CategoryProductEvent {
  const CategoryProductUpdate();
}

class CategoryProductDelete extends CategoryProductEvent {
  final int id;
  const CategoryProductDelete(this.id);
}
