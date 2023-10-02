import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PieChartData extends StatelessWidget {
  const PieChartData({Key? key}) : super(key: key);

  _getData() async {
    late Map<String, String> _mainHeader;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer $token',
    };

    final response = await http.post(Uri.parse(
            'http://54.179.225.22:6150/api/v1/simpleSurveyDashboard/getQADetailsByProjectIdAndVisitMonth/')
        .replace(queryParameters: {
      "projectId": "120",
      "visitMonth": "Quota Testing",
      "recordStatus": ["pass", "pending"]
    }),headers: _mainHeader);
    Map<String, dynamic> map = json.decode(response.body);
    print(map['data'].length);
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return new charts.PieChart(dataList(snapshot.data),
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcRendererDecorators: [new charts.ArcLabelDecorator()]));
            else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  static List<charts.Series<LinearSales, int>> dataList(
      Map<String, dynamic> apiData) {
    List<LinearSales> list = [];

    for (int i = 0; i < apiData.length; i++)
      list.add(new LinearSales(i, apiData[i]));

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: list,
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
