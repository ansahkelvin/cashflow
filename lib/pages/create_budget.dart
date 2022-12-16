import 'package:flutter/material.dart';

class CreateBudget extends StatelessWidget {
  const CreateBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
        centerTitle: false,
      ),
    );
  }
}
