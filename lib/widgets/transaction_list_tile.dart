import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.credit_card,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Upwork",
                  style: TextStyle(color: Colors.black87),
                )
              ],
            ),
            const Text(
              "\$10,00",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
