import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/category_product/data/models/category_product_model.dart';
import 'package:my_casher/feature/category_product/data/repository/category_product_repository.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc({required this._repository, required this._categoryRepository})
    : super(PosState()) {
    on<PosEvent>((event, emit) async {
      if (event is PosStarted) {
        await _onGetData(event, emit);
      }
    });
  }
  final ProductRepository _repository;
  final CategoryProductRepository _categoryRepository;

  Future<void> _onGetData(PosStarted event, Emitter<PosState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final data = await _repository.getData();
    final data_categoru = await _categoryRepository.getCategories();
    emit(state.copyWith(products_data: data, category_data: data_categoru));
  }

  Future<void> _onAddCart(PosStarted event, Emitter<PosState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));

    // emit(state.copyWith(category_data: data));
  }
}
