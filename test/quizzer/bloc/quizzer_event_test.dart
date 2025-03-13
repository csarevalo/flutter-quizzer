import 'package:flutter_quizzer/quizzer/bloc/quizzer_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizzerFirstQuestionRequested', () {
    test('supports value equality', () {
      expect(
        QuizzerFirstQuestionRequested(),
        equals(QuizzerFirstQuestionRequested()),
      );
    });
    test('props are correct', () {
      expect(QuizzerFirstQuestionRequested().props, equals(<Object>[]));
    });
  });

  group('QuizzerNextQuestionRequested', () {
    late String answer;
    setUpAll(() {
      answer = 'answer';
    });
    test('supports value equality', () {
      expect(
        QuizzerNextQuestionRequested(answer: answer),
        equals(QuizzerNextQuestionRequested(answer: answer)),
      );
    });
    test('props are correct', () {
      expect(
        QuizzerNextQuestionRequested(answer: answer).props,
        equals(<Object>[answer]),
      );
    });
  });
}
