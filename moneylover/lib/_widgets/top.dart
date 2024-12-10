import 'package:moneylover/data/1.dart';

List<money> geter_top() {
  money snap_food = money();
  snap_food.time = 'jan 30,2022';
  snap_food.image = 'mcdonalds.png';
  snap_food.buy = true;
  snap_food.fee = '- \$ 100';
  snap_food.name = 'mcdonald';
  money snap = money();
  snap.image = 'Transfer.png';
  snap.time = 'Feb 22,2022';
  snap.buy = true;
  snap.fee = '-\$ 60';
  snap.name = 'Transfer';
  return [snap_food, snap];
}
