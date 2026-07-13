import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/data/repository/cart_repository.dart';
import 'package:my_casher/feature/pos/data/repository/transaction_repository.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc({
    required this._repository,
    required this._categoryRepository,
    required this._cartRepository,
    required this._transactionRepository,
  }) : super(PosState()) {
    on<PosEvent>((event, emit) async {
      if (event is PosTabChanged) {
        await _onChangeTab(event, emit);
      }

      if (event is PosStarted) {
        await _onGetData(event, emit);
      }

      if (event is GetProducts) {
        await _onGetProducts(event, emit);
      }

      if (event is GetCategories) {
        await _onGetCategories(event, emit);
      }

      if (event is SelectCategory) {
        await _onChangeCategory(event, emit);
      }

      if (event is SearchProduct) {
        await _onSearchProduct(event, emit);
      }

      if (event is CartStarted) {
        await _onGetCart(event, emit);
      }

      if (event is AddProductToCart) {
        await _onAddCart(event, emit);
      }
      if (event is RemoveProductFromCart) {
        await _onRemoveCart(event, emit);
      }
      if (event is ChangeQuantityCart) {
        await _onChangeQuantity(event, emit);
      }
      if (event is ChangeMethod) {
        await _onChangeMethod(event, emit);
      }
      if (event is SubmitPayment) {
        await _onSubmitPayment(event, emit);
      }
    });

    on<SyncCart>(_onSyncCart);
  }
  final ProductRepository _repository;
  final CategoryProductRepository _categoryRepository;
  final CartRepository _cartRepository;
  final TransactionRepository _transactionRepository;

  Timer? _searchDebounce;

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onChangeTab(PosTabChanged event, Emitter<PosState> emit) async {
    emit(state.copyWith(currentIndex: event.index));
    switch (event.index) {
      case 0:
        await _onGetData(PosStarted(), emit);
        break;
      case 1:
        await _onGetCart(CartStarted(), emit);
        break;
    }
  }

  Future<void> _onGetData(PosStarted event, Emitter<PosState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _onGetProducts(GetProducts(), emit);
    await _onGetCategories(GetCategories(), emit);
    await Future.delayed(const Duration(seconds: 10));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onGetCategories(
    GetCategories event,
    Emitter<PosState> emit,
  ) async {
    final data = await _categoryRepository.getData();
    emit(state.copyWith(category_data: data));
  }

  Future<void> _onGetProducts(GetProducts event, Emitter<PosState> emit) async {
    final data = await _repository.getData(
      category_id: event.category_id,
      search: event.search,
    );
    emit(state.copyWith(products_data: data));
  }

  Future<void> _onGetCart(CartStarted event, Emitter<PosState> emit) async {
    emit(state.copyWith(isLoading: true));
    final cart = await _cartRepository.getData();

    final total = cart.fold<double>(0, (s, e) => s + e.subtotal);
    final totalItem = cart.fold<int>(0, (s, e) => s + e.quantity);
    emit(state.copyWith(cartItems: cart, total: total, totalItem: totalItem));
  }

  Future<void> _onChangeCategory(
    SelectCategory event,
    Emitter<PosState> emit,
  ) async {
    emit(state.copyWith(selectedCategory: event.category_id));
    await _onGetProducts(
      GetProducts(category_id: event.category_id, search: state.searchProduct),
      emit,
    );
  }

  Future<void> _onSearchProduct(
    SearchProduct event,
    Emitter<PosState> emit,
  ) async {
    emit(state.copyWith(searchProduct: event.search));
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      add(
        GetProducts(category_id: state.selectedCategory, search: event.search),
      );
    });
  }

  Future<void> _onAddCart(
    AddProductToCart event,
    Emitter<PosState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _cartRepository.addProduct(event.product);
      await _onGetCart(CartStarted(), emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onRemoveCart(
    RemoveProductFromCart event,
    Emitter<PosState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _cartRepository.delete(event.cart_id);
      await _onGetCart(CartStarted(), emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onChangeQuantity(
    ChangeQuantityCart event,
    Emitter<PosState> emit,
  ) async {
    try {
      final carts = [...state.cartItems];

      final index = carts.indexWhere((e) => e.id == event.cart_id);

      if (index == -1) return;

      final item = carts[index];

      int qty = item.quantity;

      switch (event.type) {
        case 'increase':
          qty++;
          break;

        case 'decrease':
          if (qty > 1) {
            qty--;
          }
          break;
      }

      carts[index] = item.copyWith(quantity: qty, subtotal: qty * item.price);

      emit(state.copyWith(cartItems: carts));

      _searchDebounce?.cancel();

      _searchDebounce = Timer(const Duration(milliseconds: 500), () {
        add(SyncCart(event.cart_id));
      });
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSyncCart(SyncCart event, Emitter<PosState> emit) async {
    final item = state.cartItems.firstWhere((e) => e.id == event.cartId);

    await _cartRepository.updateQuantity(item.id!, item.quantity, item.price);

    await _onGetCart(CartStarted(), emit);
  }

  Future<void> _onChangeMethod(
    ChangeMethod event,
    Emitter<PosState> emit,
  ) async {
    emit(state.copyWith(method: event.method));
  }

  Future<void> _onSubmitPayment(
    SubmitPayment event,
    Emitter<PosState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _transactionRepository.checkout(
        total: state.total,
        payment: event.cash,
        change: event.change,
        cartItems: state.cartItems,
      );
      await _onResetPos(ResetPos(), emit);
      emit(state.copyWith(isLoading: false, status: PosStatus.success));
    } catch (e) {
      emit(state.copyWith(isLoading: false, status: PosStatus.error));
    }
  }

  Future<void> _onResetPos(ResetPos event, Emitter<PosState> emit) async {
    emit(state.copyWith(status: PosStatus.initial));
    await _cartRepository.clear();
    await _onGetCart(CartStarted(), emit);
  }
}
