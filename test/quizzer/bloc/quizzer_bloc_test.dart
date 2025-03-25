// Ignore for consise and understandable testing
// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_quizzer/quizzer/quizzer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:questions_repository/questions_repository.dart';

class MockQuestionsRepository extends Mock implements QuestionsRepository {}

void main() {
  group('QuizzerBloc', () {
    late QuestionsRepository questionsRepository;
    late List<Question> questionBank;

    setUp(() {
      questionsRepository = MockQuestionsRepository();
      questionBank = List.from(kQuestions);
    });

    QuizzerBloc buildBloc() {
      return QuizzerBloc(questionRepository: questionsRepository);
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });
      test('has correct initial state', () {
        expect(buildBloc().state, QuizzerState());
      });
    });

    blocTest<QuizzerBloc, QuizzerState>(
      'totalQuestions returns questions left in repositor',
      build: buildBloc,
      setUp:
          () => when(() => questionsRepository.questionsTotal).thenReturn(10),
      verify: (bloc) => expect(bloc.totalQuestions, equals(10)),
    );

    group('getProgress()', () {
      late double expectedProgress;
      late double progress;
      blocTest<QuizzerBloc, QuizzerState>(
        'returns correct progress during first question',
        setUp: () {
          when(() => questionsRepository.questionsTotal).thenReturn(10);
          when(() => questionsRepository.questionsRemaining).thenReturn(9);
          expectedProgress = 0; // 1 question is dispensed but none answered
        },
        build: buildBloc,
        act: (bloc) => progress = bloc.getProgress(),
        verify: (bloc) {
          verify(() => bloc.getProgress()).called(1);
          expect(progress, expectedProgress);
        },
      );

      blocTest<QuizzerBloc, QuizzerState>(
        'returns correct progress during last question',
        setUp: () {
          when(() => questionsRepository.questionsTotal).thenReturn(10);
          when(() => questionsRepository.questionsRemaining).thenReturn(0);
          expectedProgress = 9 / 10; // all questions dispensed, 1 is unanswered
        },
        build: buildBloc,
        act: (bloc) => progress = bloc.getProgress(),
        verify: (bloc) {
          // BAD: should fail (but doesn't) because bloc isn't a mocktail object
          // verify(() => bloc.getProgress()).called(1);
          expect(progress, expectedProgress);
        },
      );

      blocTest<QuizzerBloc, QuizzerState>(
        'returns correct progress when quiz status is done',
        setUp: () {
          when(() => questionsRepository.questionsTotal).thenReturn(10);
          when(() => questionsRepository.questionsRemaining).thenReturn(0);
          expectedProgress = 10 / 10; // all questions r dispensed and answered
        },
        seed: () => QuizzerState(status: QuizzerStatus.done),
        build: buildBloc,
        act: (bloc) => progress = bloc.getProgress(),
        verify: (bloc) {
          expect(progress, expectedProgress);
        },
      );
    });

    group('getNumberCorrectAnswers()', () {
      late List<QuestionAnswer> history;
      late int numCorrectAnswers;
      late int expectedNumCorrectAnswers;

      blocTest<QuizzerBloc, QuizzerState>(
        'returns correct progress during last question',
        setUp: () {
          final question = questionBank.first;
          history = [
            QuestionAnswer(
              question: question.question,
              points: question.points,
              correctAnswer: question.answer,
              userAnswer: question.answer,
            ),
          ];
          expectedNumCorrectAnswers = 1;
        },
        build: buildBloc,
        seed: () => QuizzerState(history: history),
        act: (bloc) => numCorrectAnswers = bloc.getNumberCorrectAnswers(),
        verify: (bloc) {
          // BAD: failed because bloc is not a mocktail object
          // verify(() => bloc.getNumberCorrectAnswers()).called(1);
          expect(numCorrectAnswers, expectedNumCorrectAnswers);
        },
      );
    });

    group('QuizzerFirstQuestionRequested', () {
      blocTest<QuizzerBloc, QuizzerState>(
        'emits state with first question from repository '
        'and quiz in-progress status '
        'when QuizzerFirstQuestionRequested is added.',
        setUp: () {
          when(
            questionsRepository.getFirstQuestion,
          ).thenReturn(questionBank.first);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(QuizzerFirstQuestionRequested()),
        expect:
            () => <QuizzerState>[
              QuizzerState(
                status: QuizzerStatus.inProgress,
                score: 0,
                question: kQuestions.first,
              ),
            ],
        verify: (bloc) {
          verify(() => questionsRepository.getFirstQuestion()).called(1);
        },
      );
    });

    group('QuizzerNextQuestionRequested', () {
      late Question question1;
      late Question question2;
      late String answer1;
      late String answer2;

      late int initScore;
      late int newScore;

      setUp(() {
        question1 = questionBank.first;
        answer1 = questionBank.first.answer;
        question2 = questionBank.last;
        answer2 = questionBank.last.answer;
      });

      blocTest<QuizzerBloc, QuizzerState>(
        'emits state with next question from repository '
        'and updates ongoing quiz score if answer is correct '
        'when QuizzerNextQuestionRequested is added.',
        setUp: () {
          when(
            () => questionsRepository.getNextQuestion(),
          ).thenReturn(question2);

          initScore = 0;
          newScore = initScore + question1.points; // expect right answer
        },
        build: buildBloc,
        seed: // state after getting first question
            () => QuizzerState(
              status: QuizzerStatus.inProgress,
              score: initScore,
              question: question1,
            ),
        act: (bloc) => bloc.add(QuizzerNextQuestionRequested(answer: answer1)),
        expect:
            () => <QuizzerState>[
              QuizzerState(
                status: QuizzerStatus.inProgress,
                score: newScore,
                question: question2,
                history: [
                  QuestionAnswer(
                    question: question1.question,
                    points: question1.points,
                    correctAnswer: answer1,
                    userAnswer: answer1,
                  ),
                ],
              ),
            ],
        verify: (bloc) {
          verify(() => questionsRepository.getNextQuestion()).called(1);
        },
      );

      blocTest<QuizzerBloc, QuizzerState>(
        'emits state  when repository is empty '
        'and updates ongoing quiz score if answer NOT correct '
        'when QuizzerNextQuestionRequested is added.',
        setUp: () {
          when(
            () => questionsRepository.getNextQuestion(),
          ).thenReturn(question2);

          initScore = 0;
          newScore = initScore; // expect wrong answer
        },
        build: buildBloc,
        seed: // state after getting first question
            () => QuizzerState(
              status: QuizzerStatus.inProgress,
              score: initScore,
              question: question1,
            ),
        act: (bloc) => bloc.add(QuizzerNextQuestionRequested(answer: 'wrong')),
        expect:
            () => <QuizzerState>[
              QuizzerState(
                status: QuizzerStatus.inProgress,
                score: newScore,
                question: question2,
                history: [
                  QuestionAnswer(
                    question: question1.question,
                    points: 0,
                    correctAnswer: question1.answer,
                    userAnswer: 'wrong',
                  ),
                ],
              ),
            ],
        verify: (bloc) {
          verify(() => questionsRepository.getNextQuestion()).called(1);
        },
      );

      blocTest<QuizzerBloc, QuizzerState>(
        'emits state with quiz is finished status '
        'and updated final quiz score '
        'when QuizzerNextQuestionRequested is added '
        'and when repository is out of questions ',
        setUp: () {
          when(
            () => questionsRepository.getNextQuestion(),
          ).thenReturn(Question.empty);

          initScore = question1.points; // made up score
          newScore = initScore + question2.points; // expect right answer
        },
        build: buildBloc,
        seed: // state after getting last question
            () => QuizzerState(
              status: QuizzerStatus.inProgress,
              score: initScore,
              question: question2,
              history: [
                QuestionAnswer(
                  question: question1.question,
                  points: question1.points,
                  correctAnswer: question1.answer,
                  userAnswer: question1.answer,
                ),
              ],
            ),
        act: (bloc) => bloc.add(QuizzerNextQuestionRequested(answer: answer2)),
        expect:
            () => <QuizzerState>[
              QuizzerState(
                status: QuizzerStatus.done, // quiz is over
                score: newScore,
                question: Question.empty,
                history: [
                  QuestionAnswer(
                    question: question1.question,
                    points: question1.points,
                    correctAnswer: question1.answer,
                    userAnswer: question1.answer,
                  ),
                  QuestionAnswer(
                    question: question2.question,
                    points: question2.points,
                    correctAnswer: question2.answer,
                    userAnswer: question2.answer,
                  ),
                ],
              ),
            ],
        verify: (bloc) {
          verify(() => questionsRepository.getNextQuestion()).called(1);
        },
      );
    });
  });
}
