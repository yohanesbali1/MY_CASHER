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
  const SubmitPayment({required this.cash});
}

class ResetPos extends PosEvent {
  const ResetPos();
}
