part of 'pos_bloc.dart';

@immutable
sealed class PosEvent {
  const PosEvent();
}

class PosStarted extends PosEvent {
  const PosStarted();
}

class AddProductToCart extends PosEvent {
  final ProductModels product;
  const AddProductToCart({required this.product});
}
