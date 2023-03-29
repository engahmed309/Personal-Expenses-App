import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function add;
  NewTransaction(this.add);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
   DateTime? selectedDate;

  void sumbitData() {
    if(amountController.text.isEmpty){return;}
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0||selectedDate==null) {
      return;
    }
    widget.add(
      titleController.text,
      double.parse(amountController.text),
      selectedDate
    );
    Navigator.of(context).pop();
  }

  void selectDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate:DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
              onSubmitted: (_) {
                sumbitData();
              },
            ),
            TextField(
              onSubmitted: (_) {
                sumbitData();
              },
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            SizedBox(height: 10),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? "No Date Is Choosen Yet !"
                          : "Picked Date : ${DateFormat.yMMMd().format(selectedDate!)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      selectDate();
                    },
                    child: Text("Choose Date"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sumbitData();
              },
              child: Text(
                "Add Transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
