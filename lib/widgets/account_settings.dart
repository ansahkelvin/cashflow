import 'package:budget/pages/add_money.dart';
import 'package:budget/pages/create_budget.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your balance",
            style: TextStyle(
              color: Color(0xffB2B2B2),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "GHC ${provider.balance}",
            style: const TextStyle(
              color: Color(0xff181818),
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddMoney(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xff174123),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Deposit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TrackExpense(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xff174123),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Account Expense",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
