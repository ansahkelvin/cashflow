import 'package:budget/pages/check_user_logged_In.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:budget/widgets/syncfusion_chart.dart';
import 'package:budget/widgets/transaction_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        automaticallyImplyLeading: false,
        title: const Text("Cashflow"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed(CheckUser.routeName);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        child: RefreshIndicator(
          onRefresh: () {
            return Provider.of<FirebaseProvider>(context, listen: false)
                .fetchTransactions()
                .then((_) =>
                    Provider.of<FirebaseProvider>(context, listen: false)
                        .fetchExpense());
          },
          child: ListView(
            children: const [
              AccountSettings(),
              SizedBox(
                height: 40,
              ),
              SFChart(),
              SizedBox(
                height: 40,
              ),
              TransactionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
