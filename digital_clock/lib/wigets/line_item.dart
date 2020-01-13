import 'package:digital_clock/constants/_constants.dart';
import 'package:digital_clock/models/line.dart';
import 'package:digital_clock/utils/percentage.dart';
import 'package:flutter/material.dart';

class LineItem extends StatelessWidget {
  LineItem({
    this.line,
    this.minute,
    this.accentColor,
  });

  final Line line;
  final String minute;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final canvasHeight = MediaQuery.of(context).size.height;
    final labelFontSize = percentOfNumber(7, canvasHeight);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: labelFontSize,
        ),
        Container(
          key: Key('line container'),
          width: line.width,
          height: line.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ViewSpacing.small,
            ),
            color: int.parse(minute) >= line.minute
                ? ColorPalette.denim
                : accentColor,
          ),
        ),
        SizedBox(
          height: line.width,
        ),
        Text(
          line.minute % 10 == 0 ? line.minute.toString() : '',
          key: Key('line label'),
          style: TextStyle(
            fontSize: labelFontSize,
          ),
        )
      ],
    );
  }
}
