import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;

   ExpenseTile(
      {Key? key,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.deleteTapped
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion() , children: [
        SlidableAction(backgroundColor: Colors.red ,
        onPressed: deleteTapped,
        icon:Icons.delete,
        borderRadius: BorderRadius.circular(5),)
      ]),
      child: Column(
        children: [
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[500]
            ),
            child: ListTile(

              title: Text(name),
              subtitle: Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
              trailing: Text('Rs ${amount}'),
            ),
          ),
        ],
      ),
    );
  }
}
