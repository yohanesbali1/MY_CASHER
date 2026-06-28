import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/feature/product/data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._repository) : super(ProductState()) {
    on<ProductEvent>((event, emit) {
      if (event is ProductLoad) {
        _onGetData(event, emit);
      }
    });
  }
  final ProductRepository _repository;

  Future<void> _onGetData(ProductLoad event, Emitter<ProductState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    final data = await _repository.getCategories();
    emit(state.copyWith(products: data));
  }
}
