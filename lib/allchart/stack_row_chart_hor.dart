import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartHorizontal extends StatefulWidget {
  const BarChartHorizontal({Key? key}) : super(key: key);

  @override
  State<BarChartHorizontal> createState() => _BarChartHorizontalState();
}

class _BarChartHorizontalState extends State<BarChartHorizontal> {


  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
         // body: BarChartHorizontal(),
        body: Center(child: Container(child: Text("Map"),)),
        ));
  }

  SfCartesianChart BarChartHorizontal() {
    return SfCartesianChart(
          title: ChartTitle(
              text: 'Monthly expenses of a family \n (in U.S. Dollars)'),
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            StackedBarSeries<ExpenseData, String>(
                dataSource: _chartData,
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.father,
                name: 'Father',
                markerSettings: MarkerSettings(
                  isVisible: true,
                )),
            StackedBarSeries<ExpenseData, String>(
                dataSource: _chartData,
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.mother,
                name: 'Mother',
                markerSettings: MarkerSettings(
                  isVisible: true,
                )),
            StackedBarSeries<ExpenseData, String>(
                dataSource: _chartData,
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.son,
                name: 'Son',
                markerSettings: MarkerSettings(
                  isVisible: true,
                )),
            StackedBarSeries<ExpenseData, String>(
                dataSource: _chartData,
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.daughter,
                name: 'Daughter',
                markerSettings: MarkerSettings(
                  isVisible: true,
                )),
          ],
          primaryXAxis: CategoryAxis(),
        );
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData('Food', 55, 40, 45, 48),
      ExpenseData('Transport', 33, 45, 54, 28),
      ExpenseData('Medical', 43, 23, 20, 34),
      ExpenseData('Clothes', 32, 54, 23, 54),
      ExpenseData('Books', 56, 18, 43, 55),
      ExpenseData('Others', 23, 54, 33, 56),
    ];
    return chartData;
  }
}

class ExpenseData {
  ExpenseData(
      this.expenseCategory, this.father, this.mother, this.son, this.daughter);
  final String expenseCategory;
  final num father;
  final num mother;
  final num son;
  final num daughter;
}
