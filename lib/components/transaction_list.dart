import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: transactions.isEmpty ?
      Column(
        children: <Widget>[
          Text("Nenhuma transação cadastrada!"),
          SizedBox(height: 30,),
          Container(height: 200, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))
        ],
      ) :
      ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text('R\$${tr.value?.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              title: Text(
                tr.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(tr.date ?? DateTime.now()),
              ),
            ),
          );
        },
      ),
    );
  }
}
