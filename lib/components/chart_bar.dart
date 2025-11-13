import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String Label;
  final double Value;
  final double Percentage;

  const ChartBar(this.Label, this.Value, this.Percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('R\$${Value.toStringAsFixed(2)}'),
        SizedBox(height: 5),
        SizedBox(
          height: 60,
          width: 10,
          child: null,
        ),
        SizedBox(height: 5),
        Text(Label)
      ],
    );
  }
}
