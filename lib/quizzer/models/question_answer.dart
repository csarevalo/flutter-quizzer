import 'package:equatable/equatable.dart';

///{@template question_answer}
/// The model for the a question and answer provided by the user.
/// Used to maintain a history of how questions were answered.
/// {@endtemplate}
class QuestionAnswer extends Equatable {
  ///{@macro question_answer}
  const QuestionAnswer({
    required this.question,
    required this.points,
    required this.correctAnswer,
    required this.userAnswer,
  });

  /// The question text.
  final String question;

  /// Points received for answering the question.
  final int points;

  ///The  answer to the question.
  final String correctAnswer;

  ///The user selected selected answer.
  final String userAnswer;

  @override
  List<Object> get props => [question, points, correctAnswer, userAnswer];
}
