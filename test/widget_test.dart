// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:brain_rise/services/local_storage_service.dart';

import 'package:brain_rise/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    // Initialize Hive for testing
    await LocalStorageService.init();
    final storage = LocalStorageService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(BrainRiseApp(storage: storage));

    // Verify that splash screen is shown
    expect(find.text('BrainRise'), findsOneWidget);
    expect(find.text('Learn Smarter, Rise Higher'), findsOneWidget);
  });
}
