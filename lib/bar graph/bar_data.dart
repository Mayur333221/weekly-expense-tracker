import 'package:demo/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  //initialize bar data
  void initializeBarData() {
    barData = [
      //sun amount
      IndividualBar(x: 0, y: sunAmount),

      //mon amount
      IndividualBar(x: 1, y: monAmount),

      //tue amount
      IndividualBar(x: 2, y: tueAmount),

      //wed amount
      IndividualBar(x: 3, y: wedAmount),

      //thur amount
      IndividualBar(x: 4, y: thurAmount),

      //fri amount
      IndividualBar(x: 5, y: friAmount),

      //sat amount
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
