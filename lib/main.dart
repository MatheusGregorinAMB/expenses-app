import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import './second.dart';
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
        useMaterial3: true,
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
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tênis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de água',
      value: 65.32,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't4',
      title: 'Novo notebook',
      value: 3500.00,
      date: DateTime.now().subtract(Duration(days: 8)),
    ),
    Transaction(
      id: 't5',
      title: 'Curso de Flutter',
      value: 199.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't6',
      title: 'Makita',
      value: 199.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't7',
      title: 'Chocolate',
      value: 199.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

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
      return tr.date?.isAfter(DateTime.now().subtract(Duration(days: 7))) ??
          false;
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
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(child: Text('Menu')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                print("Settings tapped");
                null;
              },
            ),
          ],
        ),
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
