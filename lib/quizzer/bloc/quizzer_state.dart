part of 'quizzer_bloc.dart';

/// The current status of the quiz.
enum QuizzerStatus {
  /// Quiz initial (not started) status.
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
    this.history = const <QuestionAnswer>[],
  });

  /// The status of the quiz.
  final QuizzerStatus status;

  /// The ongoing score of the quiz.
  final int score;

  /// The latest question in the quiz.
  final Question question;

  /// A quiz history of questions and answers.
  final List<QuestionAnswer> history;

  /// Copy [QuizzerState] with new values.
  QuizzerState copyWith({
    QuizzerStatus? status,
    int? score,
    Question? question,
    List<QuestionAnswer>? history,
  }) {
    return QuizzerState(
      status: status ?? this.status,
      score: score ?? this.score,
      question: question ?? this.question,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [status, score, question, history];
}
