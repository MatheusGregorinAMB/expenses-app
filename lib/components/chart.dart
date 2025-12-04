import 'package:expenses/components/chart_bar.dart';
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
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransaction;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ChartBar(
                tr['day'] as String,
                tr['value'] as double,
                _weekTotalValue == 0 ? 0.00 : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
