import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_quizzer/quizzer/bloc/quizzer_bloc.dart';
import 'package:flutter_quizzer/quizzer/widgets/widgets.dart';

class QuizzerResultsView extends StatefulWidget {
  const QuizzerResultsView({super.key});

  @override
  State<QuizzerResultsView> createState() => _QuizzerResultsViewState();
}

class _QuizzerResultsViewState extends State<QuizzerResultsView> {
  ConfettiController? _controller1;
  ConfettiController? _controller2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => sprinkleConfetti());
  }

  void sprinkleConfetti() {
    const total = 15;
    var progress = 0;
    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      progress++;
      if (progress >= total || !mounted) {
        timer.cancel();
        return;
      }

      final count = ((1 - progress / total) * 50).toInt();

      final confettiOptions = ConfettiOptions(
        particleCount: count,
        startVelocity: 30,
        spread: 360,
        ticks: 60,
        x: 1, //placeholder
        y: 2, //placeholder
      );

      _controller1 = Confetti.launch(
        context,
        options: confettiOptions.copyWith(
          x: randomInRange(0.1, 0.3),
          y: Random().nextDouble() - 0.2,
        ),
      );
      _controller2 = Confetti.launch(
        context,
        options: confettiOptions.copyWith(
          x: randomInRange(0.7, 0.9),
          y: Random().nextDouble() - 0.2,
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller1?.kill();
    _controller2?.kill();
    super.dispose();
  }

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
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(38, 6, 19, 12),
                  child: Text(
                    'You answered $numCorrectAnswers out of $numTotalQuestions '
                    'questions correctly! (+$score $scoreLabel)',
                    style: textTheme.headlineSmall!.copyWith(
                      color: colorScheme.primary,
                    ),
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

double randomInRange(double min, double max) {
  return min + Random().nextDouble() * (max - min);
}
