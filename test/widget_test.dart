import 'package:flutter_test/flutter_test.dart';
import 'package:bookshelf/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BookShelfApp());

    // Verify that the app title exists.
    expect(find.text('BOOKSHELF'), findsOneWidget);
  });
}
