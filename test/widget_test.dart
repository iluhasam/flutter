import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manager_flutter/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Manager Flutter'), findsOneWidget);
  });
}
