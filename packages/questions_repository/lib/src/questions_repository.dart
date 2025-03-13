import 'package:questions_repository/src/constants/constants.dart';
import 'package:questions_repository/src/models/models.dart';

/// {@template questions_repository}
/// A repository of questions for Flutter Quizzer.
/// {@endtemplate}
class QuestionsRepository {
  /// {@macro questions_repository}
  QuestionsRepository({List<Question>? questionBank})
    : _questionBank = questionBank ?? List.from(kQuestions);

  /// The internal question bank within the repository.
  final List<Question> _questionBank;

  /// The number of questions remaining in the repository question bank.
  int get questionsRemaining => _questionBank.length;

  /// The total net points available for all questions.
  int get totalPoints => _getTotalPoints();

  /// Calculate the total points for all questions.
  int _getTotalPoints() {
    var totalPoints = 0;
    for (final question in kQuestions) {
      totalPoints += question.points;
    }
    return totalPoints;
  }

  /// Get the first `Question` from the `QuestionsRepository`
  /// and remove it from the *question bank*.
  Question getFirstQuestion() {
    // If question bank is exhausted, replenish questions.
    if (_questionBank.isEmpty) _questionBank.addAll(kQuestions);

    final questions = List<Question>.from(_questionBank)..shuffle();
    final firstQuestion = questions.first;
    _questionBank.remove(firstQuestion);
    return firstQuestion;
  }

  /// Get the next `Question` from the `QuestionsRepository`
  /// and remove it from the question bank.
  /// After exhausting the *question bank*, the repository returns
  /// `Question.empty` as the *next question*.
  Question getNextQuestion() {
    // If question bank is exhausted, return an empty question.
    if (_questionBank.isEmpty) return Question.empty;

    final questions = List<Question>.from(_questionBank)..shuffle();
    final nextQuestion = questions.first;
    _questionBank.remove(nextQuestion);
    return nextQuestion;
  }
}
