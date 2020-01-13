import 'package:digital_clock/wigets/minute_lines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('finds all visible minute labels', (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(2560, 1800));

    final minuteLines = MinuteLines(
      minute: '10',
      accentColor: Colors.black,
    );

    await tester.pumpWidget(makeTestableWidget(child: minuteLines));

    final labelsFinder = find.byKey(Key('line label'));
    final actualLabels = labelsFinder.evaluate().map((element) {
      return (element.widget as Text).data;
    });
    final expectedLabels = [
      '',
      '10',
      '',
      '20',
      '',
      '30',
      '',
      '40',
      '',
      '50',
      ''
    ];

    expect(actualLabels, expectedLabels);
  });
  testWidgets('finds all minute lines', (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(2560, 1800));

    final minuteLines = MinuteLines(
      minute: '55',
      accentColor: Colors.black,
    );

    await tester.pumpWidget(makeTestableWidget(child: minuteLines));

    expect(find.byKey(Key('line container')), findsNWidgets(11));
  });
}
