import 'package:flutter_test/flutter_test.dart';
import 'package:agro_sphere_project/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app with seen = false (first time open)
    await tester.pumpWidget(const MyApp(seen: false));

    // Verify that the WelcomeScreen is shown (look for text from your welcome.dart)
    expect(find.text('Skip'), findsOneWidget);  // Example check
    expect(find.text('Next'), findsOneWidget);
  });
}
