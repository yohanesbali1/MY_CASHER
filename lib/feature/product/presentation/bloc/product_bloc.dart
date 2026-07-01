import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._repository) : super(ProductState()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductLoad) {
        await _onGetData(event, emit);
      }
      if (event is ProductFieldChanged) {
        await _onFieldChanged(event, emit);
      }
      if (event is ProductUpdate) {
        await _onUpdate(event, emit);
      }
      if (event is ProductShowData) {
        await _onShowData(event, emit);
      }
      if (event is ProductModeChange) {
        await _onChangeMode(event, emit);
      }
      if (event is ProductDelete) {
        await _onDelete(event, emit);
      }
    });
  }
  final ProductRepository _repository;

  Future<void> _onChangeMode(
    ProductModeChange event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: event.mode));
    _resetField(emit);
  }

  Future<void> _onGetData(ProductLoad event, Emitter<ProductState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    final data = await _repository.getData();
    emit(state.copyWith(products_data: data));
  }

  Future<void> _onFieldChanged(
    ProductFieldChanged event,
    Emitter<ProductState> emit,
  ) async {
    switch (event.field) {
      case ProductField.quantity:
        emit(
          state.copyWith(
            quantity: int.tryParse(event.value) ?? 0,
            quantityError: event.value.trim().isEmpty
                ? 'Stok wajib diisi'
                : null,
          ),
        );
        break;

      case ProductField.price:
        emit(
          state.copyWith(
            price: double.tryParse(event.value) ?? 0,
            priceError: event.value.trim().isEmpty ? 'Harga wajib diisi' : null,
          ),
        );
        break;
      default:
        break;
    }
  }

  Future<void> _onShowData(
    ProductShowData event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      Future.delayed(const Duration(seconds: 10));
      final data = await _repository.show(event.id);
      emit(
        state.copyWith(
          isLoading: false,
          quantity: data.quantity,
          price: data.price,
          status: FormMode.update,
          id: event.id,
          show_product_data: data,
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUpdate(
    ProductUpdate event,
    Emitter<ProductState> emit,
  ) async {
    try {
      _validateForm(emit);
      emit(state.copyWith(isLoading: true));
      Future.delayed(const Duration(seconds: 10));
      final payload = {'price': state.price, 'quantity': state.quantity};
      await _repository.update(state.id!, payload!);
      emit(state.copyWith(status: FormMode.list));
      _resetField(emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDelete(
    ProductDelete event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      Future.delayed(const Duration(seconds: 10));
      await _repository.delete(event.id);
      emit(state.copyWith(status: FormMode.list));
      _resetField(emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  bool _validateForm(Emitter<ProductState> emit) {
    final quantityError = state.quantity.toString().trim().isEmpty
        ? 'Stok wajib diisi'
        : null;
    final priceError = state.price.toString().trim().isEmpty
        ? 'Harga wajib diisi'
        : null;

    emit(state.copyWith(quantityError: quantityError, priceError: priceError));

    return quantityError == null && priceError == null;
  }

  void _resetField(Emitter<ProductState> emit) {
    emit(
      state.copyWith(
        quantity: 0,
        price: 0,
        quantityError: null,
        priceError: null,
      ),
    );
  }
}
