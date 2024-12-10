import 'package:flutter/material.dart';
import 'package:moneylover/_widgets/add_date.dart';
import 'package:moneylover/_widgets/chart.dart';
import 'package:moneylover/_widgets/utlity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(), week(), month(), year()];
  List<Add_date> a = [];
  int index_color = 0;
  ValueNotifier kj = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: kj,
              builder: (context, dynamic value, child) {
                a = f[value];
                return custom();
              })),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                              kj.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_color == index
                                    ? Color.fromARGB(255, 47, 125, 121)
                                    : Colors.white),
                            alignment: Alignment.center,
                            child: Text(
                              day[index],
                              style: TextStyle(
                                color: index_color == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Chart(
                indexx: index_color,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Expenses',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_downward_sharp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <SplineSeries<SalesData, String>>[
                    SplineSeries<SalesData, String>(
                      color: Color.fromARGB(255, 47, 125, 121),
                      width: 3,
                      dataSource: <SalesData>[
                        SalesData(100, 'mon'),
                        SalesData(20, 'Tue'),
                        SalesData(40, 'Wed'),
                        SalesData(15, 'Sat'),
                        SalesData(5, 'Sun'),
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Spending',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assest/images/${a[index].name}.png',
                  height: 40,
                ),
              ),
              title: Text(
                a[index].name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${day[a[index].dateTime.weekday - 1]}  ${a[index].dateTime.year}-${a[index].dateTime.day}-${a[index].dateTime.month}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                a[index].amount,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                ),
              ),
            );
          },
          childCount: a.length,
        ))
      ],
    );
  }
}

class SalesData {
  SalesData(this.sales, this.year);

  final String year;
  final int sales;
}
