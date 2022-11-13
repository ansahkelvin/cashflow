import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SFChart extends StatefulWidget {
  const SFChart({super.key});

  @override
  State<SFChart> createState() => _SFChartState();
}

class _SFChartState extends State<SFChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 40),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: SfCartesianChart(),
    );
  }
}
