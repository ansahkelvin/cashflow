import 'package:flutter/material.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const Text(
            "\$625,000",
            style: TextStyle(
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
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(157, 33, 149, 243),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Deposit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(157, 33, 149, 243),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Create budget",
                    style: TextStyle(color: Colors.white),
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
