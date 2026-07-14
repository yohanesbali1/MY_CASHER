import 'package:my_casher/feature/pos/data/datasource/transaction_local_datasource.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/transaction/data/model/transaction_model.dart';

class TransactionRepository {
  TransactionRepository(this._datasource);

  final TransactionLocalDatasource _datasource;

  Future<int> checkout({
    required double total,
    required double payment,
    required double change,
    required String payment_method,
    required List<CartItemModel> cartItems,
  }) async {
    final num_truncation = await _datasource.generateInvoiceNumber();
    return await _datasource.checkout(
      invoice: num_truncation,
      total: total,
      payment: payment,
      change: change,
      cartItems: cartItems,
      payment_method: payment_method,
    );
  }

  Future<List<TransactionModel>> getData({page, startDate, endDate}) async {
    final data = await _datasource.getData(
      page: page,
      startDate: startDate,
      endDate: endDate,
    );
    return data;
  }

  Future<TransactionModel?> getById(int id) async {
    return await _datasource.getById(id);
  }

  Future<void> delete(int transactionId) async {
    await _datasource.delete(transactionId);
  }

  Future<void> clear() async {
    await _datasource.clear();
  }

  Future<TransactionSummaryModel> getSummary({
    String search = '',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _datasource.getSummary(
      search: search,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
