import 'package:flutter_quizzer/app/app.dart';
import 'package:flutter_quizzer/quizzer/quizzer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(QuizzerScreen), findsOneWidget);
    });
  });
}
