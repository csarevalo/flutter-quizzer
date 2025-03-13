import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:questions_repository/questions_repository.dart';

part 'quizzer_event.dart';
part 'quizzer_state.dart';

/// {@template quizzer_bloc}
/// Bloc that manages the quiz flow.
/// {@endtemplate}
class QuizzerBloc extends Bloc<QuizzerEvent, QuizzerState> {
  ///{@macro quizzer_bloc}
  QuizzerBloc({QuestionsRepository? questionRepository})
    : _questionsRepository = questionRepository ?? QuestionsRepository(),
      super(const QuizzerState()) {
    on<QuizzerFirstQuestionRequested>(onFirstQuestionRequested);
    on<QuizzerNextQuestionRequested>(onNextQuestionRequested);
  }

  /// The repository which interfaces with question bank.
  final QuestionsRepository _questionsRepository;

  /// Get first question from repository, then begin quiz.
  void onFirstQuestionRequested(
    QuizzerFirstQuestionRequested event,
    Emitter<QuizzerState> emit,
  ) {
    // Get first question from repository
    final firstQuestion = _questionsRepository.getFirstQuestion();
    // Begin quiz
    emit(
      state.copyWith(
        status: QuizzerStatus.inProgress,
        score: 0,
        question: firstQuestion,
      ),
    );
  }

  /// Update quiz score, then get next question or finish quiz.
  void onNextQuestionRequested(
    QuizzerNextQuestionRequested event,
    Emitter<QuizzerState> emit,
  ) {
    // Determine if user selected the correct answer
    final correctAnswer = event.answer;
    final selectedAnswer = state.question.answer;
    final isCorrect = correctAnswer == selectedAnswer;
    // Determine new score
    final oldScore = state.score;
    final newScore = isCorrect ? oldScore + state.question.points : oldScore;
    // Get next question from repository
    final nextQuestion = _questionsRepository.getNextQuestion();
    if (nextQuestion == Question.empty) {
      // The quiz is finished
      emit(
        state.copyWith(
          status: QuizzerStatus.done,
          score: newScore,
          question: Question.empty,
        ),
      );
    } else {
      // Continue quiz with next question
      emit(state.copyWith(score: newScore, question: nextQuestion));
    }
  }
}
