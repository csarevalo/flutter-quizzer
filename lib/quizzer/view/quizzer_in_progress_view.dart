import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quizzer/quizzer/bloc/quizzer_bloc.dart';
import 'package:flutter_quizzer/quizzer/widgets/widgets.dart';

class QuizzerInProgressView extends StatelessWidget {
  const QuizzerInProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final question = context.watch<QuizzerBloc>().state.question;
    final answers = [question.answer, ...question.invalidAnswers]..shuffle();

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    const spacing = 18.0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spacing,
        children: [
          Text(
            question.question,
            style: textTheme.headlineSmall!.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          AnswerTiles(
            answers: answers,
            spacing: spacing,
            onTap:
                (answer) => context.read<QuizzerBloc>().add(
                  QuizzerNextQuestionRequested(answer: answer),
                ),
          ),
        ],
      ),
    );
  }
}
