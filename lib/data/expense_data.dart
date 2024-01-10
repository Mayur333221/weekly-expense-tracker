import 'package:demo/data/hive_database.dart';
import 'package:demo/datetime/date_time_helper.dart';
import 'package:demo/models/expense_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //list all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //prepare data to display
  final db = HiveDatabase();
  void prepareData() {
    //if there exists data, get it
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //get weekday (mon, tue, etc) from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  //get the date for the start of the week ( sunday )

  DateTime startOfWeekDate() {
    DateTime startOfWeek = DateTime.now();

    //get today's date
    DateTime today = DateTime.now();

    //go backwards from today to find Sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek;
  }

  /*
  convert overall list of expenses into a daily expense summary

  e.g.

  overallExpenseList =
  [
    [food, 20230130, ₹10],
    [hat, 20230130, ₹15],
    [drinks, 20230131, ₹1],
    [food, 20230101, ₹36],
    [food, 20230101, ₹16],
    [food, 20230103, ₹92],
    [food, 20230105, ₹11],
    [food, 20230105, ₹12],


  ]
  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date (yyyymmdd) : amountTodayofDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
