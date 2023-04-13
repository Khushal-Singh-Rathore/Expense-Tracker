import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'ui/home_screen.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();
  // open a hive box
  await Hive.openBox('Expense_Database');
  // our runApp
  runApp(expense_tracker());
}

class expense_tracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
