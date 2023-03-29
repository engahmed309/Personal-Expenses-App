import 'package:flutter/material.dart';

import '/widgets/chart.dart';
import '/widgets/new_transaction.dart';
import './models/transaction.dart';
import 'widgets/transactions_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: TextStyle(
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold),
              )
              .titleLarge,
        ),
        fontFamily: "Quicksand",
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //   Transaction(
    //       id: "tx1", title: "New Shoes", date: DateTime.now(), amount: 65.99),
    //   Transaction(
    //       id: "tx1", title: "New Shirt", date: DateTime.now(), amount: 25.99),
    //
  ];
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime ChoosenDate) {
    final newTX = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: ChoosenDate);
    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void deleteTransaction(id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainAppBar = AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddingNewTransaction(context),
        ),
      ],
      title: const Text("Personal Expenses"),
    );
    return Scaffold(
      appBar: mainAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        mainAppBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    .3,
                child: Chart(_recentTransaction),),
            Container(
                height: (MediaQuery.of(context).size.height -
                        mainAppBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    .7      ,
                child: TransactionsList(_userTransactions, deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddingNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
