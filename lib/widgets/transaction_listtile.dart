import 'package:budget/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatefulWidget {
  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  final TransactionModel transaction;

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.transaction.source,
        style: const TextStyle(color: Colors.black87),
      ),
      subtitle: Text(
        widget.transaction.date,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        "GHC ${widget.transaction.type == "deduct" ? "-" : "+"}${widget.transaction.amount}",
        style: TextStyle(
          color:
              widget.transaction.type == "deduct" ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
