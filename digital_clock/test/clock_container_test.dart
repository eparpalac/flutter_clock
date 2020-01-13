import 'package:digital_clock/screens/clock_container.dart';
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

  Finder findTextBySemanticsLabel(String label) {
    return find.ancestor(
      of: find.bySemanticsLabel(label),
      matching: find.byType(Text),
    );
  }

  testWidgets('sets current and next hours when 24-hour format',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(2560, 1800));

    final clockContainer = ClockContainer(
      dateTime: DateTime.parse('2020-01-10 23:36:29.078697'),
      is24HourFormat: true,
    );

    await tester.pumpWidget(makeTestableWidget(child: clockContainer));

    Text textFrom =
        tester.firstWidget(findTextBySemanticsLabel('Current hour'));
    Text textTo = tester.firstWidget(findTextBySemanticsLabel('Next hour'));

    expect(textFrom.data, '23');
    expect(textTo.data, '00');
  });

  testWidgets('sets current and next hours when 12-hour format',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(2560, 1800));

    final clockContainer = ClockContainer(
      dateTime: DateTime.parse('2020-01-10 11:10:29.078697'),
      is24HourFormat: false,
    );

    await tester.pumpWidget(makeTestableWidget(child: clockContainer));

    Text textFrom =
        tester.firstWidget(findTextBySemanticsLabel('Current hour'));
    Text textTo = tester.firstWidget(findTextBySemanticsLabel('Next hour'));

    expect(textFrom.data, '11 AM');
    expect(textTo.data, '12 PM');
  });
}
