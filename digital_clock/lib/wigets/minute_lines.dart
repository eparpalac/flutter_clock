import 'package:digital_clock/models/line.dart';
import 'package:digital_clock/utils/percentage.dart';
import 'package:digital_clock/wigets/line_item.dart';
import 'package:flutter/material.dart';

class MinuteLines extends StatelessWidget {
  MinuteLines({
    this.minute,
    this.accentColor,
  });

  final String minute;
  final Color accentColor;

  final minutes = 60;
  final interval = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildLines(context)
          .map(
            (line) => LineItem(
              line: line,
              minute: minute,
              accentColor: accentColor,
            ),
          )
          .toList(),
    );
  }

  List<Line> buildLines(BuildContext context) {
    var canvasHeight = MediaQuery.of(context).size.height;
    var canvasWidth = MediaQuery.of(context).size.width;

    final smallLineHeight = percentOfNumber(10, canvasHeight);
    final mediumLineHeight = percentOfNumber(20, canvasHeight);
    final largeLineHeight = percentOfNumber(35, canvasHeight);
    final lineWidth = percentOfNumber(1, canvasWidth);

    var lines = List<Line>();

    for (var i = interval; i < minutes; i += interval) {
      var lineSize = smallLineHeight;
      if (i % 10 == 0) {
        if (i == minutes / 2) {
          lineSize = largeLineHeight;
        } else {
          lineSize = mediumLineHeight;
        }
      }
      lines.add(
        Line(
          minute: i,
          height: lineSize,
          width: lineWidth,
        ),
      );
    }

    return lines;
  }
}
