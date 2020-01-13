import 'package:digital_clock/constants/_constants.dart';
import 'package:digital_clock/utils/percentage.dart';
import 'package:digital_clock/wigets/minute_lines.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  accentColor,
}

final _lightTheme = {
  _Element.background: ColorPalette.white,
  _Element.accentColor: ColorPalette.lynch,
};

final _darkTheme = {
  _Element.background: ColorPalette.black,
  _Element.accentColor: ColorPalette.white,
};

class ClockContainer extends StatelessWidget {
  ClockContainer({
    this.dateTime,
    this.is24HourFormat,
  });

  final DateTime dateTime;
  final bool is24HourFormat;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation != Orientation.landscape) {
      return Container();
    }

    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    final hourFrom = DateFormat(is24HourFormat ? 'HH' : 'h a').format(dateTime);

    final hourTo = DateFormat(is24HourFormat ? 'HH' : 'h a')
        .format(dateTime.add(Duration(hours: 1)))
        .toString();

    final minute = DateFormat('mm').format(dateTime);

    var canvasWidth = MediaQuery.of(context).size.width;

    final fontSize = is24HourFormat
        ? percentOfNumber(20, canvasWidth)
        : percentOfNumber(9, canvasWidth);

    final defaultStyle = TextStyle(
      color: colors[_Element.accentColor],
      fontFamily: 'AllertaStencil',
      fontSize: fontSize,
    );

    final gradientWidth = is24HourFormat
        ? percentOfNumber(35, canvasWidth)
        : percentOfNumber(40, canvasWidth);

    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        ColorPalette.cerise,
        ColorPalette.denim,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, gradientWidth, 70.0));

    return Container(
      color: colors[_Element.background],
      child: DefaultTextStyle(
        style: defaultStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              hourFrom,
              textScaleFactor: 1.0,
              semanticsLabel: 'Current hour',
              style: TextStyle(
                foreground: Paint()..shader = linearGradient,
              ),
            ),
            MinuteLines(
              minute: minute,
              accentColor: colors[_Element.accentColor],
            ),
            Text(
              hourTo,
              semanticsLabel: 'Next hour',
              textScaleFactor: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
