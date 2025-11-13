import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        useMaterial3: true, // opcional, se quiser seguir o padrão Material
        fontFamily: 'Roboto',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextInt(99999).toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFromModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );

    // showCupertinoModalPopup(
    //   context: context,
    //   builder: (_) {
    //     return TransactionForm(_addTransaction);
    //   }
    // );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date?.isAfter(DateTime.now().subtract(Duration(days: 7))) ?? false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas pessoais"),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFromModal(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            Column(children: <Widget>[TransactionList(_transactions)]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFromModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
