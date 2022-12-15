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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);
    return FutureBuilder(
        future: provider.fetchTransactions(),
        builder: (context, snapshot) {
          // final data = snapshot.data!.docs as Map<String, dynamic>;
          return Container(
              margin: const EdgeInsets.only(top: 40, bottom: 40),
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const PieChart(dataMap: {"Food": 21}));
        });
  }
}
