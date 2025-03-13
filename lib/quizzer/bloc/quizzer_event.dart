part of 'quizzer_bloc.dart';

@immutable
/// {@template quizzer_event}
/// Event added during the quiz flow.
/// {@endtemplate}
sealed class QuizzerEvent extends Equatable {
  ///{@macro quizzer_event}
  const QuizzerEvent();

  @override
  List<Object> get props => [];
}

/// {@template first_question_requested}
/// First question requested event
/// {@endtemplate}
final class QuizzerFirstQuestionRequested extends QuizzerEvent {}

/// {@template next_question_requested}
/// Next question requested event
/// {@endtemplate}
final class QuizzerNextQuestionRequested extends QuizzerEvent {
  ///{@macro next_question_requested}
  const QuizzerNextQuestionRequested({required this.answer});

  /// The answer selected by the user.
  final String answer;

  @override
  List<Object> get props => [answer];
}
