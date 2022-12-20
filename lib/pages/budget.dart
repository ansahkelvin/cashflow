import 'package:budget/model/budget.dart';
import 'package:budget/pages/create_budget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late Future<Budget> fetchBudget;
  @override
  void initState() {
    fetchBudget =
        Provider.of<FirebaseProvider>(context, listen: false).fetchBudget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateBudget(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<Budget>(
          future: fetchBudget,
          builder: (context, snapshot) {
            final budget = Provider.of<FirebaseProvider>(context, listen: false)
                .budgetList;
            if (snapshot.hasData) {
              return budget.isEmpty
                  ? const Center(
                      child: Text(
                        "No budget yet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return Provider.of<FirebaseProvider>(context,
                                listen: false)
                            .fetchBudget();
                      },
                      child: ListView.builder(
                        itemCount: budget.length,
                        itemBuilder: (context, index) => Dismissible(
                          key: Key(
                            budget[index].id,
                          ),
                          background: Container(
                            color: Colors.red,
                            child: const Center(
                                child: Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                          ),
                          onDismissed: (direction) async {
                            await Provider.of<FirebaseProvider>(context,
                                    listen: false)
                                .deleteBudget(budget[index].id);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'budget dismissed',
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              budget[index].title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              budget[index].amount,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            subtitle: Text(
                              budget[index].date,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
