import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/pos/data/repository/cart_repository.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc({
    required this._repository,
    required this._categoryRepository,
    required this._cartRepository,
  }) : super(PosState()) {
    on<PosEvent>((event, emit) async {
      if (event is PosTabChanged) {
        await _onChangeTab(event, emit);
      }

      if (event is PosStarted) {
        await _onGetData(event, emit);
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
    });
  }
  final ProductRepository _repository;
  final CategoryProductRepository _categoryRepository;
  final CartRepository _cartRepository;

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
    await Future.delayed(const Duration(seconds: 1));
    final data = await _repository.getData();
    final data_category = await _categoryRepository.getData();
    await _cartRepository.clear();

    emit(state.copyWith(products_data: data, category_data: data_category));
  }

  Future<void> _onGetCart(CartStarted event, Emitter<PosState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final cart = await _cartRepository.getData();

    final total = cart.fold<double>(0, (s, e) => s + e.subtotal);
    final totalItem = cart.fold<int>(0, (s, e) => s + e.quantity);
    emit(state.copyWith(cartItems: cart, total: total, totalItem: totalItem));
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
      await Future.delayed(const Duration(seconds: 1));
      await _cartRepository.delete(event.cart_id);
      await _onGetCart(CartStarted(), emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
