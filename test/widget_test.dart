import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diety/features/Onboarding/view/onbording_screan.dart';

void main() {
  testWidgets('Onboarding screen smoke test', (WidgetTester tester) async {
    // Build our onboarding screen in a MaterialApp shell.
    await tester.pumpWidget(const MaterialApp(
      home: OnboardingScreen(),
    ));

    // Verify that the 'Skip' button text is present.
    expect(find.text('Skip'), findsOneWidget);

    // Verify that the navigation arrow button icon is present.
    expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
  });
}
