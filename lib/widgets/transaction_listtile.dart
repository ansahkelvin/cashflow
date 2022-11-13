import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Upwork",
                      style: TextStyle(color: Colors.black87),
                    ),
                    Text(
                      "Work 15 Feb",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            const Text(
              "+\$10,00",
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
