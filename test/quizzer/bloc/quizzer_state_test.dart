// Ignore for consise and understandable testing
// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_quizzer/quizzer/quizzer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:questions_repository/questions_repository.dart';

void main() {
  group('QuizzerState', () {
    test('can be instantiated', () {
      expect(QuizzerState(), isNotNull);
    });

    QuizzerState createSubject({
      QuizzerStatus status = QuizzerStatus.initial,
      int score = 0,
      Question question = Question.empty,
    }) {
      return QuizzerState(status: status, score: score, question: question);
    }

    test('supports value equality', () {
      expect(createSubject(), equals(createSubject()));
    });

    test('props are correct', () {
      expect(
        createSubject(
          status: QuizzerStatus.inProgress,
          score: 1,
          question: Question.empty,
        ).props,
        equals(<Object>[QuizzerStatus.inProgress, 1, Question.empty]),
      );
    });

    group('copyWith()', () {
      test('returns the same object when no arguments are provided', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });
      test(
        'returns the same value for every parameter if null is provided',
        () {
          expect(
            createSubject().copyWith(status: null, score: null, question: null),
            equals(createSubject()),
          );
        },
      );
      test('replaces every non-null value', () {
        expect(
          createSubject().copyWith(
            status: QuizzerStatus.done,
            score: 2,
            question: kQuestions.first,
          ),
          equals(
            createSubject(
              status: QuizzerStatus.done,
              score: 2,
              question: kQuestions.first,
            ),
          ),
        );
      });
    });
  });
}
