part of 'quizzer_bloc.dart';

/// The current status of the quiz.
enum QuizzerStatus {
  /// Quizzer app initial status.
  initial,

  /// Quiz in progress status.
  inProgress,

  /// Quiz is done status.
  done,
}

/// {@template quizzer_state}
/// Represents the state of the quiz flow.
/// {@endtemplate}
final class QuizzerState extends Equatable {
  ///{@macro quizzer_state}
  const QuizzerState({
    this.status = QuizzerStatus.initial,
    this.score = 0,
    this.question = Question.empty,
  });

  /// The status of the quiz.
  final QuizzerStatus status;

  /// The ongoing score of the quiz.
  final int score;

  /// The latest question in the quiz.
  final Question question;

  /// Copy [QuizzerState] with new values.
  QuizzerState copyWith({
    QuizzerStatus? status,
    int? score,
    Question? question,
  }) {
    return QuizzerState(
      status: status ?? this.status,
      score: score ?? this.score,
      question: question ?? this.question,
    );
  }

  @override
  List<Object> get props => [status, score, question];
}
