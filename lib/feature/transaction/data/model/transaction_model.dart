class TransactionModel {
  final int? id;
  final String invoice;
  final double total;
  final double payment;
  final double change;
  final DateTime createdAt;

  const TransactionModel({
    this.id,
    required this.invoice,
    required this.total,
    required this.payment,
    required this.change,
    required this.createdAt,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      invoice: map['invoice'] as String,
      total: (map['total'] as num).toDouble(),
      payment: (map['payment'] as num).toDouble(),
      change: (map['change'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice': invoice,
      'total': total,
      'payment': payment,
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
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      invoice: invoice ?? this.invoice,
      total: total ?? this.total,
      payment: payment ?? this.payment,
      change: change ?? this.change,
      createdAt: createdAt ?? this.createdAt,
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
