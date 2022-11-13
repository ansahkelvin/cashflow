import 'package:budget/widgets/syncfusion_chart.dart';
import 'package:budget/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/account_settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AccountSettings(),
              SFChart(),
              TransactionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
