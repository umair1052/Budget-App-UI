import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneylover/_widgets/add_date.dart';

int totals = 0;

final box = Hive.box<Add_date>('data');
int total() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int income() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int expenses() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<Add_date> today() {
  List<Add_date> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_date> week() {
  List<Add_date> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].dateTime.day &&
        history2[i].dateTime.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_date> month() {
  List<Add_date> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_date> year() {
  List<Add_date> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int total_chart(List<Add_date> history2) {
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<Add_date> history2, bool hour) {
  List<Add_date> a = [];
  List total = [0, 0];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].dateTime.hour == history2[c].dateTime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].dateTime.day == history2[c].dateTime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  return total;
}
