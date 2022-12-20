import 'package:budget/model/expense.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class SFChart extends StatefulWidget {
  const SFChart({super.key});

  @override
  State<SFChart> createState() => _SFChartState();
}

class _SFChartState extends State<SFChart> {
  late Future<Expense> fetchExpense;

  @override
  void initState() {
    fetchExpense =
        Provider.of<FirebaseProvider>(context, listen: false).fetchExpense();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expenseList = Provider.of<FirebaseProvider>(context).expenseList;
    return FutureBuilder<Expense>(
        future: fetchExpense,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return expenseList.isEmpty
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PieChart(
                      dataMap: {
                        for (var e in expenseList)
                          e.title: double.parse(e.amount)
                      },
                    ),
                  );
          }
          return Container();
        });
  }
}
