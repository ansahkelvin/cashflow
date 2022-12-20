import 'package:budget/widgets/financial_news.dart';
import 'package:flutter/material.dart';

class FinancialNewsPage extends StatelessWidget {
  const FinancialNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Finance Blog"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: const [FinancialNews()],
      )),
    );
  }
}
