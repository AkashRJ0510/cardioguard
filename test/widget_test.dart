import 'package:flutter_test/flutter_test.dart';
import 'package:cardioguard/app.dart';

void main() {
  testWidgets('Smoke test for CardioGuardApp', (WidgetTester tester) async {
    await tester.pumpWidget(const CardioGuardApp());
    expect(find.text('Welcome to CardioGuard'), findsOneWidget);
  });
}

