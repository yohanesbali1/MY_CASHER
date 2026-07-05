import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._repository, this._categoryRepository)
    : super(ProductState()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductLoad) {
        await _onGetData(event, emit);
      }
      if (event is ProductReset) {
        _resetField(emit);
        _onGetCategory(event, emit);
      }
      if (event is ProductFieldChanged) {
        await _onFieldChanged(event, emit);
      }
      if (event is ProductCreate) {
        await _onCreate(event, emit);
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
  final CategoryProductRepository _categoryRepository;

  Future<void> _onChangeMode(
    ProductModeChange event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: event.mode));
    _resetField(emit);
  }

  Future<void> _onGetCategory(
    ProductReset event,
    Emitter<ProductState> emit,
  ) async {
    final data = await _categoryRepository.getCategories();
    emit(state.copyWith(category_data: data));
  }

  Future<void> _onGetData(ProductLoad event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, status: FormMode.list));
    await Future.delayed(const Duration(seconds: 1));
    final data = await _repository.getData();
    emit(state.copyWith(products_data: data, isLoading: false));
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
            price: int.tryParse(event.value) ?? 0,
            priceError: event.value.trim().isEmpty ? 'Harga wajib diisi' : null,
          ),
        );
        break;

      case ProductField.icon:
        emit(
          state.copyWith(
            icon: event.value,
            iconError: event.value.isEmpty ? 'Icon wajib diisi' : null,
          ),
        );
        break;

      case ProductField.name:
        emit(
          state.copyWith(
            name: event.value,
            nameError: event.value.isEmpty ? 'Nama wajib diisi' : null,
          ),
        );
        break;

      case ProductField.categoryId:
        emit(
          state.copyWith(
            categoryId: event.value?.id as int ?? null,
            category: event.value ?? null,
            categoryError: event.value == null ? 'Kategori wajib diisi' : null,
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

  Future<void> _onCreate(
    ProductCreate event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final isValid = _validateForm(emit, FormMode.create);
      if (!isValid) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      final product = ProductModels(
        name: state.name,
        price: state.price,
        quantity: state.quantity,
        category_id: state.categoryId,
        icon: state.icon,
      );
      await _repository.create(product);
      await _onGetData(ProductLoad(), emit);
      emit(state.copyWith(status: FormMode.list));
      Future.delayed(const Duration(seconds: 10));
      _resetField(emit);
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
      _validateForm(emit, FormMode.update);
      emit(state.copyWith(isLoading: true));
      final payload = ProductModels(
        id: state.id,
        price: state.price,
        quantity: state.quantity,
      );
      await _repository.update(payload);
      await _onGetData(ProductLoad(), emit);
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
      await _repository.delete(event.id);
      await _onGetData(ProductLoad(), emit);
      emit(state.copyWith(status: FormMode.list));
      _resetField(emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  bool _validateForm(Emitter<ProductState> emit, FormMode mode) {
    final quantityError = state.quantity <= 0 ? 'Stok wajib diisi' : null;

    final priceError = state.price <= 0 ? 'Harga wajib diisi' : null;

    final nameError = (state.name?.trim().isEmpty ?? true)
        ? 'Nama wajib diisi'
        : null;

    final categoryError = state.categoryId == null || state.categoryId == 0
        ? 'Kategori wajib diisi'
        : null;

    final iconError = (state.icon?.trim().isEmpty ?? true)
        ? 'Icon wajib diisi'
        : null;
    if (FormMode.create == mode) {
      emit(
        state.copyWith(
          nameError: nameError,
          iconError: iconError,
          categoryError: categoryError,
          quantityError: quantityError,
          priceError: priceError,
        ),
      );
      return nameError == null &&
          iconError == null &&
          categoryError == null &&
          quantityError == null &&
          priceError == null;
    }

    emit(state.copyWith(quantityError: quantityError, priceError: priceError));

    return quantityError == null && priceError == null;
  }

  void _resetField(Emitter<ProductState> emit) {
    emit(
      state.copyWith(
        quantity: 0,
        price: 0,
        name: null,
        icon: null,
        categoryId: null,
        quantityError: null,
        priceError: null,
        nameError: null,
        iconError: null,
        categoryError: null,
        category: null,
      ),
    );
  }
}
