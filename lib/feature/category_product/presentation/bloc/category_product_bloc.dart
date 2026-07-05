import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  CategoryProductBloc(this._repository) : super(CategoryProductState()) {
    on<CategoryProductEvent>((event, emit) {
      if (event is CategoryProductStarted) {
        _onGetData(event, emit);
      }
      if (event is CategoryModeChange) {
        _onChangeMode(event, emit);
      }
      if (event is CategoryFieldChanged) {
        _onFieldChanged(event, emit);
      }
      if (event is CategoryProductCreate) {
        _onCreate(event, emit);
      }
      if (event is CategoryShowData) {
        _onShowData(event, emit);
      }
      if (event is CategoryProductUpdate) {
        _onUpdate(event, emit);
      }
      if (event is CategoryProductDelete) {
        _onDelete(event, emit);
      }
    });
  }
  final CategoryProductRepository _repository;

  Future<void> _onGetData(
    CategoryProductStarted event,
    Emitter<CategoryProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, data: [], status: FormMode.list));
    final categories = await _repository.getCategories();

    emit(state.copyWith(isLoading: false, data: categories));
  }

  Future<void> _onChangeMode(
    CategoryModeChange event,
    Emitter<CategoryProductState> emit,
  ) async {
    emit(state.copyWith(status: event.mode));
    _resetField(emit);
  }

  Future<void> _onFieldChanged(
    CategoryFieldChanged event,
    Emitter<CategoryProductState> emit,
  ) async {
    switch (event.field) {
      case CategoryField.name:
        emit(
          state.copyWith(
            name: event.value,
            nameError: event.value.trim().isEmpty ? 'Nama wajib diisi' : null,
          ),
        );
        break;
      default:
        break;
    }
  }

  Future<void> _onCreate(
    CategoryProductCreate event,
    Emitter<CategoryProductState> emit,
  ) async {
    try {
      final isValid = _validateForm(emit);
      if (isValid == false) return;

      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));
      final payload = {'name': state.name, 'isEdit': false};
      await _repository.create(payload);
      emit(state.copyWith(status: FormMode.list));
      _resetField(emit);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onShowData(
    CategoryShowData event,
    Emitter<CategoryProductState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final categories = await _repository.show(event.id);
      emit(
        state.copyWith(
          isLoading: false,
          name: categories.name,
          status: FormMode.update,
          id: event.id,
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUpdate(
    CategoryProductUpdate event,
    Emitter<CategoryProductState> emit,
  ) async {
    try {
      final isValid = _validateForm(emit);
      if (isValid == false) return;
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));
      final payload = {'name': state.name, 'isEdit': false};
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
    CategoryProductDelete event,
    Emitter<CategoryProductState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));
      await _repository.delete(event.id);
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  bool _validateForm(Emitter<CategoryProductState> emit) {
    final nameError = state.name.trim().isEmpty ? 'Nama wajib diisi' : null;
    emit(state.copyWith(nameError: nameError));

    return nameError == null;
  }

  void _resetField(Emitter<CategoryProductState> emit) {
    emit(state.copyWith(name: '', nameError: null));
  }
}
