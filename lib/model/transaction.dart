class TransactionModel {
  TransactionModel({
    required this.amount,
    required this.date,
    required this.source,
    required this.time,
    required this.type,
  });

  TransactionModel.fromJson(Map<String, Object?> json)
      : this(
          date: json['date']! as String,
          amount: json['amount']! as double,
          time: json['time'] as String,
          type: json['type'] as String,
          source: json['source'] as String,
        );

  final double amount;
  final String date;
  final String source;
  final String time;
  final String type;

  Map<String, Object?> toJson() {
    return {
      'amount': amount,
      'time': time,
      'type': type,
      'source': source,
      'date': date,
    };
  }
}
