import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quizzer/quizzer/bloc/quizzer_bloc.dart';
import 'package:flutter_quizzer/quizzer/widgets/widgets.dart';

class QuizzerResultsView extends StatelessWidget {
  const QuizzerResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    final quizzer = context.read<QuizzerBloc>();
    final quizSummary = quizzer.state.history;
    final numCorrectAnswers = quizzer.getNumberCorrectAnswers();
    final numTotalQuestions = quizzer.totalQuestions;
    final score = quizzer.state.score;
    final scoreLabel = score == 1 ? 'pt' : 'pts';

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: screenHeight * 0.75,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(56, 16, 24, 4),
                child: Text(
                  'You answered $numCorrectAnswers out of $numTotalQuestions '
                  'questions correctly! (+$score $scoreLabel)',
                  style: textTheme.headlineSmall!.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              ...List<Widget>.generate(
                quizSummary.length,
                (i) => QASummaryTile(
                  number: i + 1,
                  questionAnswer: quizSummary[i],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: FilledButton(
            onPressed: () => quizzer.add(QuizzerFirstQuestionRequested()),
            child: const Text('Restart Quiz'),
          ),
        ),
      ],
    );
  }
}
