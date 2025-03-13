import 'package:equatable/equatable.dart';

/// {@template question}
/// A model for a question in Flutter Quizzer.
/// {@endtemplate}
class Question extends Equatable {
  /// {@macro question}
  const Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.invalidAnswers,
    required this.points,
  });

  /// Empty question which represents no question found.
  static const empty = Question(
    id: -1,
    question: '',
    answer: '',
    invalidAnswers: [],
    points: 0,
  );

  /// An id for quick identification.
  final int id;

  /// The question text.
  final String question;

  /// The answer text.
  final String answer;

  /// A list of invalid answers to the [question] text.
  final List<String> invalidAnswers;

  /// How many points the question is worth.
  final int points;

  @override
  List<Object> get props => [id, question, answer, invalidAnswers, points];
}
