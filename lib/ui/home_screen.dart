import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/data/expense_summary.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:expense_tracker/ui/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => homeScreenState();
}

class homeScreenState extends State<homeScreen> {
  TextEditingController newnameText = TextEditingController();
  TextEditingController newpriceText = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).getData();
  }

  void addExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add new expense'),
              backgroundColor: Colors.grey[300],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Expense name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    controller: newnameText,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: newpriceText,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Amount',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  )
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: cancel,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: save,
                  child: Text('Save'),
                ),
              ],
            ));
  }

  void save() {
    if (newnameText.text.isNotEmpty && newpriceText.text.isNotEmpty) {
      ExpenseItems newExpense = ExpenseItems(
          name: newnameText.text,
          amount: newpriceText.text,
          time: DateTime.now());
      Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newpriceText.clear();
    newnameText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        backgroundColor: Colors.grey[400],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          elevation: 15,
          onPressed: addExpense,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ExpenseSummary(startofWeek: value.StartofWeek()),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Expenses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.totalExpense().length,
                        itemBuilder: (context, index) => ExpenseTile(
                              name: value.totalExpense()[index].name,
                              amount: value.totalExpense()[index].amount,
                              dateTime: value.totalExpense()[index].time,
                              deleteTapped: (p0) => value
                                  .deleteExpense(value.totalExpense()[index]),
                            )),
                  ],
                )),
              ]),
        ),
      ),
    );
  }
}
