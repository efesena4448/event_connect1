import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:event_connect/main.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

void main() {
  testWidgets('MyApp has a title', (WidgetTester tester) async {
    final mockDatabase = MockAppDatabase();

    await tester.pumpWidget(MyApp(database: mockDatabase));

    final titleFinder = find.text('Event Connect');

    expect(titleFinder, findsOneWidget);
  });
}
