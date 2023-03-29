import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double sepndingAmount;
  final double sepndingAmountpst;
  ChartBar(this.label, this.sepndingAmount, this.sepndingAmountpst);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        children: [
          FittedBox(
            child: Text(
              '\$${sepndingAmount.toStringAsFixed(0)}',
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: 10,
            height: 60,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: sepndingAmountpst,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 6,
          ),
          Text(label),
        ],
      ),
    );
  }
}
