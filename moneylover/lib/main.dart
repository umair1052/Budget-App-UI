import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneylover/_widgets/add_date.dart';

// import 'package:moneylover/_widgets/bottom_navigation.dart';

import 'add_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddateAdapter());
  await Hive.openBox<Add_date>('data');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Add_Screen(),
    );
  }
}
