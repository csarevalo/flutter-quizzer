import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quizzer/quizzer/models/models.dart';
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
        history: [],
      ),
    );
  }

  /// Update quiz score, then get next question or finish quiz.
  void onNextQuestionRequested(
    QuizzerNextQuestionRequested event,
    Emitter<QuizzerState> emit,
  ) {
    // Determine if user selected the correct answer
    final selectedAnswer = event.answer;
    final correctAnswer = state.question.answer;
    final isCorrect = correctAnswer == selectedAnswer;
    // Determine new score
    final oldScore = state.score;
    final newScore = isCorrect ? oldScore + state.question.points : oldScore;
    // Update new history with old question and aswer
    final oldQuestion = state.question;
    final newHistory = List<QuestionAnswer>.from(state.history)..add(
      QuestionAnswer(
        question: oldQuestion.question,
        points: isCorrect ? oldQuestion.points : 0,
        correctAnswer: correctAnswer,
        userAnswer: selectedAnswer,
      ),
    );
    // Get next question from repository
    final nextQuestion = _questionsRepository.getNextQuestion();
    if (nextQuestion == Question.empty) {
      // The quiz is finished
      emit(
        state.copyWith(
          status: QuizzerStatus.done,
          score: newScore,
          question: Question.empty,
          history: newHistory,
        ),
      );
    } else {
      // Continue quiz with next question
      emit(
        state.copyWith(
          score: newScore,
          question: nextQuestion,
          history: newHistory,
        ),
      );
    }
  }

  /// Get progress of questions remaining that need answering
  double getProgress() {
    // If Quiz is done, progres is complete
    if (state.status == QuizzerStatus.done) return 1;
    // Else, progress is questions answered vs total questions
    final questionsTotal = _questionsRepository.questionsTotal;
    final questionsRemaining = _questionsRepository.questionsRemaining;
    return (questionsTotal - questionsRemaining - 1) / questionsTotal;
  }

  /// Get the number of questions answered correctly
  int getNumberCorrectAnswers() {
    var numberCorrectAnswers = 0;
    for (final qa in state.history) {
      if (qa.correctAnswer == qa.userAnswer) numberCorrectAnswers++;
    }
    return numberCorrectAnswers;
  }

  /// Get the number of total questions from repository
  int get totalQuestions => _questionsRepository.questionsTotal;
}
