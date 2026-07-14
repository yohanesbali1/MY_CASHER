class TransactionModel {
  final int? id;
  final String invoice;
  final double total;
  final double payment;
  final double change;
  final String payment_method;
  final DateTime createdAt;
  final List<TransactionDetailModel>? details;

  const TransactionModel({
    this.id,
    required this.invoice,
    required this.total,
    required this.payment,
    required this.payment_method,
    required this.change,
    required this.createdAt,
    this.details,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      invoice: map['invoice'] as String,
      total: (map['total'] as num).toDouble(),
      payment: (map['payment'] as num).toDouble(),
      payment_method: map['payment_method'] as String,
      change: (map['change'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
      details: (map['details'] as List<Map<String, dynamic>>?)
          ?.map((detail) => TransactionDetailModel.fromMap(detail))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice': invoice,
      'total': total,
      'payment': payment,
      'payment_method': payment_method,
      'change': change,
      'created_at': createdAt.toIso8601String(),
    };
  }

  TransactionModel copyWith({
    int? id,
    String? invoice,
    double? total,
    double? payment,
    double? change,
    String? payment_method,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      invoice: invoice ?? this.invoice,
      total: total ?? this.total,
      payment_method: payment_method ?? this.payment_method,
      payment: payment ?? this.payment,
      change: change ?? this.change,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TransactionDetailModel {
  final int? id;
  final int transactionId;
  final String productIcon;
  final String productName;
  final int productId;
  final int quantity;
  final double price;
  final double subtotal;

  const TransactionDetailModel({
    this.id,
    required this.transactionId,
    required this.productIcon,
    required this.productName,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.subtotal,
  });

  factory TransactionDetailModel.fromMap(Map<String, dynamic> map) {
    return TransactionDetailModel(
      id: map['id'] as int?,
      transactionId: map['transaction_id'] as int,
      productIcon: map['product_icon'] as String,
      productName: map['product_name'] as String,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      price: (map['price'] as num).toDouble(),
      subtotal: (map['subtotal'] as num).toDouble(),
    );
  }
}

class TransactionSummaryModel {
  final double totalRevenue;
  final int totalTransaction;
  final int totalItem;

  const TransactionSummaryModel({
    required this.totalRevenue,
    required this.totalTransaction,
    required this.totalItem,
  });
}
