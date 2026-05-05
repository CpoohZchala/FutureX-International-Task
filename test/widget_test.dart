import 'package:flutter_test/flutter_test.dart';
import 'package:mytask/main.dart';

void main() {
  testWidgets('Splash screen shows app title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is present on the splash screen.
    expect(find.text('FutureX International'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);

    // Advance time by 5 seconds to trigger the timer
    await tester.pump(const Duration(seconds: 5));
    // Wait for the asynchronous _checkStatus to complete its initial parts
    await tester.pump();
  });
}
