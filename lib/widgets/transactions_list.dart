import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transaction;
  Function deleteTx ;
  TransactionsList(this.transaction,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Container(
          child: Column(
              children: [
                Text(
                  "No Transactions Added yet !",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  
                  "assets/image/waiting.png",
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ],
            ),
        )
        : Container(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              )),
                              child: Text(
                                "\$${transaction[index].amount.toStringAsFixed(2)} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    transaction[index].title,
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    DateFormat()
                                        .add_yMMMd()
                                        .format(transaction[index].date),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed:()=> deleteTx(transaction[index].id),
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                      ),
                    ],
                  ),
                );
              },
              itemCount: transaction.length,
            ),
          );
  }
}
