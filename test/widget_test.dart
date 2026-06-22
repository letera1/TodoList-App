import 'package:flutter_test/flutter_test.dart';
import 'package:simple_app/main.dart';

void main() {
  testWidgets('body content opens the demo page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Body Content'), findsOneWidget);
    expect(find.text('Demo Lab'), findsNothing);

    await tester.tap(find.text('Body Content'));
    await tester.pumpAndSettle();

    expect(find.text('Demo Lab'), findsOneWidget);
    expect(find.text('Welcome to Flutter'), findsOneWidget);
  });
}
