import 'package:hive/hive.dart';

import '../models/expense_items.dart';

class HiveDataBase {
//    reference our box
  final myBox = Hive.box('Expense_Database');
// write data
  void saveData(List<ExpenseItems> allExpenses) {
//   Hive can store primitive data types like string and DateTime so we can't store custom
//   data type like object like ExpenseItems in it so we are converting its objects in the
//   primitive data type first then we store in it.

// we are creating a list inside a list
    List<List<dynamic>> allExpenseFormatted = [];
    for (var expense in allExpenses) {
//  convert each Expense Item into a list of storable type[string,datetime]
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.time
      ];
// now store this list in allExpensesFormatted
      allExpenseFormatted.add(expenseFormatted);
    }
// now put it in database
    myBox.put('All_Expenses', allExpenseFormatted);
  }

// read data
  List<ExpenseItems> readData() {
    // now we are converting the string , datetime value to expense item again

    List savedExpenses = myBox.get('All_Expenses') ?? [];
    List<ExpenseItems> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime time = savedExpenses[i][2];

      ExpenseItems expenses =
          ExpenseItems(name: name, amount: amount, time: time);
      allExpenses.add(expenses);
    }
    return allExpenses;
  }
}
