import 'package:flutter/material.dart';

class FinancialNews extends StatelessWidget {
  const FinancialNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 3,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: ((context, index) => SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                        "https://images.unsplash.com/photo-1661956601349-f61c959a8fd4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2942&q=80"),
                  ),
                  const Text("Mailchimp"),
                ],
              ),
            )),
      ),
    );
  }
}
