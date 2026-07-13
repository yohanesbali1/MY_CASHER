part of 'pos_bloc.dart';

@immutable
sealed class PosEvent {
  const PosEvent();
}

class PosStarted extends PosEvent {
  const PosStarted();
}

class PosTabChanged extends PosEvent {
  final int index;
  const PosTabChanged({required this.index});
}

class GetProducts extends PosEvent {
  final int? category_id;
  final String? search;
  const GetProducts({this.category_id, this.search});
}

class SelectCategory extends PosEvent {
  final int? category_id;
  const SelectCategory({required this.category_id});
}

class SearchProduct extends PosEvent {
  final String search;
  const SearchProduct({required this.search});
}

class GetCategories extends PosEvent {
  const GetCategories();
}

class CartStarted extends PosEvent {
  const CartStarted();
}

class AddProductToCart extends PosEvent {
  final ProductModels product;
  const AddProductToCart({required this.product});
}

class RemoveProductFromCart extends PosEvent {
  final int cart_id;
  const RemoveProductFromCart({required this.cart_id});
}

class ChangeQuantityCart extends PosEvent {
  final int cart_id;
  final String type;
  const ChangeQuantityCart({required this.cart_id, required this.type});
}

class SyncCart extends PosEvent {
  final int cartId;
  const SyncCart(this.cartId);
}

class ChangeMethod extends PosEvent {
  final PaymentMethod method;
  const ChangeMethod({required this.method});
}

class SubmitPayment extends PosEvent {
  final double cash;
  final double change;
  const SubmitPayment({required this.cash, required this.change});
}

class ResetPos extends PosEvent {
  const ResetPos();
}
