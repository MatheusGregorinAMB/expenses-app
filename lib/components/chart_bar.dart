import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String Label;
  final double Value;
  final double Percentage;

  const ChartBar(this.Label, this.Value, this.Percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          FittedBox(child: Text('R\$${Value.toStringAsFixed(2)}')),
          SizedBox(height: 5),
          SizedBox(
            height: 60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: Percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(Label),
        ],
      ),
    );
  }
}
