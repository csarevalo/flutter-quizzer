import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quizzer/l10n/l10n.dart';
import 'package:flutter_quizzer/quizzer/bloc/quizzer_bloc.dart';

class QuizzerInitialView extends StatelessWidget {
  const QuizzerInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final logoHeight = 350 < screenHeight * 0.5 ? 350.0 : null;
    late final double? logoWidth;
    if (logoHeight == null) {
      logoWidth = 300 < screenWidth * 0.75 ? 300.0 : screenWidth * 0.75;
    } else {
      logoWidth = null;
    }
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const double spacing = 24;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: spacing,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: logoWidth,
            height: logoHeight,
            color: colorScheme.primary,
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(height: spacing),
          Text(
            l10n.initialLearnFlutterMessage,
            style: textTheme.titleMedium!.copyWith(color: colorScheme.primary),
          ),
          FilledButton(
            onPressed:
                () => context.read<QuizzerBloc>().add(
                  QuizzerFirstQuestionRequested(),
                ),
            child: Text(l10n.initialStartQuizText),
          ),
          const SizedBox(height: spacing * 1.5),
        ],
      ),
    );
  }
}
