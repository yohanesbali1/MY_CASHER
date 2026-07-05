import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';

part 'iventory_event.dart';
part 'iventory_state.dart';

class IventoryBloc extends Bloc<IventoryEvent, IventoryState> {
  IventoryBloc({required this.productBloc, required this.categoryBloc})
    : super(IventoryState()) {
    on<IventoryStarted>(_onStarted);
    on<IventoryTabChanged>(_onChanged);
  }

  final ProductBloc productBloc;
  final CategoryProductBloc categoryBloc;

  Future<void> _onStarted(
    IventoryStarted event,
    Emitter<IventoryState> emit,
  ) async {
    emit(state.copyWith(currentIndex: 0));
    productBloc.add(ProductLoad());
  }

  Future<void> _onChanged(
    IventoryTabChanged event,
    Emitter<IventoryState> emit,
  ) async {
    emit(state.copyWith(currentIndex: event.index));
    switch (event.index) {
      case 0:
        productBloc.add(ProductLoad());
        break;
      case 1:
        categoryBloc.add(CategoryProductStarted());
        break;
    }
  }
}
