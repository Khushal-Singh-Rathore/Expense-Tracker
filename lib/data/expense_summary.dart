import 'package:expense_tracker/Bar%20Graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_items.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startofWeek;
  const ExpenseSummary({Key? key, required this.startofWeek}) : super(key: key);
  // get the custom highest bar graph value
  double calculateMax(
      ExpenseData value,
      String sunday,
      String monday, String tuesday, String wednesday , String thursday , String friday , String saturday
      ){
    double max = 100;
     List<double> maxList = [
       value.calculateDailyExpenseSummary()[sunday] ?? 0,
       value.calculateDailyExpenseSummary()[monday] ?? 0,
       value.calculateDailyExpenseSummary()[tuesday] ?? 0,
       value.calculateDailyExpenseSummary()[wednesday] ?? 0,
       value.calculateDailyExpenseSummary()[thursday] ?? 0,
       value.calculateDailyExpenseSummary()[friday] ?? 0,
       value.calculateDailyExpenseSummary()[saturday] ?? 0,
     ];
     maxList.sort();
     max = maxList.last * 1.1;
     return max == 0 ? 100 : max;
  }
  calculateWeekTotal(
      ExpenseData value,
      String sunday,
      String monday, String tuesday, String wednesday , String thursday , String friday , String saturday
      ){
    List<double> maxList = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for(int i = 0 ; i < maxList.length ; i++){
      total += maxList[i];
    }

    return total;
  }
  @override
  Widget build(BuildContext context) {
    String sunday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 0)));
    String monday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 1)));
    String tuesday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 2)));
    String wednesday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 3)));
    String thursday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 4)));
    String friday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 5)));
    String saturday =
        ConvertDateTimeToString(startofWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(10),
            child:
              Row(
                children: [
                 const Text('Week Total : ',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(' ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}')
                ],
              ),),
            SizedBox(
                  height: 250,
                  child: MyBarGraph(
                    maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
                    sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
                    monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
                    tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                    wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                    thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
                    friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
                    satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
                  ),
                ),
          ],
        ));
  }
}
