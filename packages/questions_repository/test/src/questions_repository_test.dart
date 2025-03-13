import 'package:questions_repository/questions_repository.dart';
import 'package:test/test.dart';

void main() {
  group('QuestionsRepository', () {
    late QuestionsRepository questionsRepository;
    setUp(() {
      questionsRepository = QuestionsRepository();
    });
    test('can be instantiated', () {
      expect(QuestionsRepository(), isNotNull);
    });

    group('getFirstQuestion()', () {
      test('executes normally', () {
        expect(() => questionsRepository.getFirstQuestion(), returnsNormally);
      });
      test('decrements questions in question bank', () {
        final startNumQs = questionsRepository.questionsRemaining;
        questionsRepository.getFirstQuestion();
        final endNumQs = questionsRepository.questionsRemaining;
        expect(startNumQs == endNumQs + 1, isTrue);
      });
      test('replenishes empty question bank', () {
        questionsRepository = QuestionsRepository(questionBank: <Question>[])
          ..getFirstQuestion();
        expect(questionsRepository.questionsRemaining > 0, isTrue);
      });
    });
    group('getNextQuestion()', () {
      test('executes normally', () {
        expect(() => questionsRepository.getNextQuestion(), returnsNormally);
      });
      test('decrements questions in question bank', () {
        final startNumQs = questionsRepository.questionsRemaining;
        questionsRepository.getNextQuestion();
        final endNumQs = questionsRepository.questionsRemaining;
        expect(startNumQs == endNumQs + 1, isTrue);
      });
      test('returns Question.empty when question bank is empty', () {
        questionsRepository = QuestionsRepository(questionBank: <Question>[]);
        expect(questionsRepository.getNextQuestion(), Question.empty);
      });
    });
  });
}
