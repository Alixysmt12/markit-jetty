import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:markit_jetty/controller/first_day_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/firsr_day_achievement.dart';

class BarChartVertical extends StatefulWidget {
  const BarChartVertical({Key? key}) : super(key: key);

  @override
  State<BarChartVertical> createState() => _BarChartVerticalState();
}

class _BarChartVerticalState extends State<BarChartVertical> {
  late List<MyData> _firstDay;

  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _firstDay = getFieldAchievementData();

    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _firstDay = getFieldAchievementData();
        }),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
      body:
          MyHorizontalChart() /*SfCartesianChart(
            title: ChartTitle(
                text: 'Monthly expenses of a family \n (in U.S. Dollars)'),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              StackedColumnSeries<ExpenseData, String>(
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.father,
                  name: 'Father',
                  markerSettings: MarkerSettings(
                    isVisible: true,
                  )),
              StackedColumnSeries<ExpenseData, String>(
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.mother,
                  name: 'Mother',
                  markerSettings: MarkerSettings(
                    isVisible: true,
                  )),
              StackedColumnSeries<ExpenseData, String>(
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.son,
                  name: 'Son',
                  markerSettings: MarkerSettings(
                    isVisible: true,
                  )),
              StackedColumnSeries<ExpenseData, String>(
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.daughter,
                  name: 'Daughter',
                  markerSettings: MarkerSettings(
                    isVisible: true,
                  )),
            ],
            primaryXAxis: CategoryAxis(),
          )*/
      ,
    ));
  }

  SfCartesianChart MyHorizontalChart() {
    return SfCartesianChart(
      title: ChartTitle(text: "First Day Achievement"),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        BarSeries<MyData, String>(
            // name: 'QA Pass',
            dataSource: _firstDay,
            xValueMapper: (MyData data, _) => data.legend,
            yValueMapper: (MyData data, _) => data.value,
            pointColorMapper: (MyData data, _) => data.color,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            name: "First Day Achv."),
      ],
      primaryXAxis: CategoryAxis(),
      /*primaryYAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
        //title: AxisTitle(text: "QA"),
      ),*/
    );
  }

  List<MyData> getFieldAchievementData() {
    var field = Get.find<FirstDayController>();
    //field.fieldAchievementData();

    // if(field.firstDayAchievementList.length != null )
    print("printf " + field.firstDayAchievementList.toString());
    field.firstDayAchievementList.length;
    List<MyData> chartData = [];
    if (field.firstDayAchievementList.length > 0) {
      chartData = [

        MyData('Fail', field.firstDayAchievementList[0].fail ?? 0,
            Colors.redAccent),
        MyData(
            'Pass', field.firstDayAchievementList[0].pass ?? 0, Colors.green),
        MyData(
            'TotalQAAchv.',
            field.firstDayAchievementList[0].totalQaAchievement ?? 0,
            Colors.deepPurple),
        MyData(
            'TotalAchv.',
            field.firstDayAchievementList[0].totalAchievement ?? 0,
            Colors.deepPurple),

      ];
    } else {
      chartData = [
        MyData('TotalAchv.', 0, Colors.deepPurple),
        MyData('TotalQAAchv.', 0, Colors.deepPurple),
        MyData('Pass', 0, Colors.green),
        MyData('Fail', 0, Colors.redAccent),




      ];
    }
    return chartData;
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData('Food', 55, 40, 45, 48),
      ExpenseData('Transport', 33, 45, 54, 28),
      ExpenseData('Medical', 43, 23, 20, 34),
      ExpenseData('Clothes', 32, 54, 23, 54),
      ExpenseData('Books', 56, 18, 43, 55),
      ExpenseData('Others', 23, 54, 33, 56),
      ExpenseData('Bills', 23, 54, 33, 56),
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

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class MyData {
  final String legend;
  final int value;
  final Color color;

  MyData(this.legend, this.value, this.color);
}
