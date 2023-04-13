import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/datetime/datetime_helper.dart';
import 'package:flutter/material.dart';

import '../models/expense_items.dart';

class ExpenseData with ChangeNotifier {
//  creating list of expense
  List<ExpenseItems> expenseList = [];

// getting overall expenses
  List<ExpenseItems> totalExpense() {
    return expenseList;
  }
// getting data form database if exist
  final db = HiveDataBase();
  void getData(){
    if(db.readData().isNotEmpty){
      expenseList = db.readData();
    }
  }
// add new expense in list
  void addExpense(ExpenseItems newExpense) {
    expenseList.add(newExpense);
    notifyListeners();
    db.saveData(expenseList);
  }

// delete expense
  void deleteExpense(ExpenseItems removeExpense) {
    expenseList.remove(removeExpense);
    notifyListeners();
    db.saveData(expenseList);
  }

// add weekDay with dateTime
  String getWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case (1):
        return 'Monday';
      case (2):
        return 'Tuesday';
      case (3):
        return 'Wednesday';
      case (4):
        return 'Thursday';
      case (5):
        return 'Friday';
      case (6):
        return 'Saturday';
      case (7):
        return 'Sunday';
      default:
        return '';
    }
  }

// get the date for start of the week (Sunday)
  DateTime StartofWeek() {
    DateTime? startofWeek;

    // Present time
    DateTime today = DateTime.now();

    // Go backwards to find sunday
    for (int i = 0; i < 7; i++) {
      if (getWeekday(today.subtract(Duration(days: i))) == 'Sunday') {
        startofWeek = today.subtract(Duration(days: i));
      }
    }
    return startofWeek!;
  }

// Calculating daily expense summary
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // 'date' : 'amount'
    };

    for (var index in expenseList) {
      var date = ConvertDateTimeToString(index.time);
      double amount = double.parse(index.amount);
      if (dailyExpenseSummary.containsKey(date)) {
        double addtionalAmount = dailyExpenseSummary[date]!;
        addtionalAmount += amount;
        dailyExpenseSummary[date] = addtionalAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
