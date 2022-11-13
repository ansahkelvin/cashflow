import 'package:flutter/material.dart';

import 'Transaction_list_tile.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(132, 234, 234, 234),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Transaction",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const TransactionListTile(),
            const TransactionListTile(),
            const TransactionListTile()
          ],
        ),
      ),
    );
  }
}
