import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart(this.transactions, {super.key});

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        bool sameDay = transactions[i].date?.day == weekDay.day;
        bool sameMonth = transactions[i].date?.month == weekDay.month;
        bool sameYear = transactions[i].date?.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transactions[i].value ?? 0.0;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransaction;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransaction.map((tr) {
          return Text('${tr['day']} : ${tr['value']}');
        }).toList(),
      ),
    );
  }
}
