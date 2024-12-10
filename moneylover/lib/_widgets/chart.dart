import 'package:flutter/material.dart';
import 'package:moneylover/_widgets/add_date.dart';
import 'package:moneylover/_widgets/utlity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int indexx;
  Chart({Key? key, required this.indexx}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Add_date>? a;
  bool b = true;
  bool j = true;
  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        a = today();
        b = true;
        j = true;
        break;
      case 1:
        a = week();
        b = false;
        j = true;
        break;
      case 2:
        a = month();
        b = false;
        j = true;
        break;
      case 3:
        a = year();
        j = false;
        break;
      default:
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 300,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <SplineSeries<SalesData, String>>[
            SplineSeries<SalesData, String>(
              dataSource: <SalesData>[
                ...List.generate(time(a!, b ? true : false).length, (index) {
                  return SalesData(
                      j
                          ? b
                              ? a![index].dateTime.hour.toString()
                              : a![index].dateTime.day.toString()
                          : a![index].dateTime.month.toString(),
                      b
                          ? index > 0
                              ? time(a!, true)[index] +
                                  time(a!, true)[index - 1]
                              : time(a!, true)[index]
                          : index > 0
                              ? time(a!, false)[index] +
                                  time(a!, false)[index - 1]
                              : time(a!, false)[index]);
                })
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
            )
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
