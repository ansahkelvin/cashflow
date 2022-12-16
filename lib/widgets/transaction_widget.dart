import 'package:budget/model/transaction.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:budget/widgets/transaction_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  late Future<TransactionModel> transaction;
  @override
  void initState() {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    transaction = provider.fetchTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);
    return FutureBuilder(
        future: transaction,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return provider.transactionList.isEmpty
                ? const Center(
                    child: Text("No transactions"),
                  )
                : ListView(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(132, 234, 234, 234),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Transactions",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.transactionList.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TransactionTile(
                                    transaction:
                                        provider.transactionList[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
