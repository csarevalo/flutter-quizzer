import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quizzer/l10n/l10n.dart';
import 'package:flutter_quizzer/quizzer/bloc/quizzer_bloc.dart';
import 'package:flutter_quizzer/quizzer/view/view.dart';
import 'package:flutter_quizzer/quizzer/widgets/snackbar_content.dart';
import 'package:questions_repository/questions_repository.dart';

class QuizzerScreen extends StatelessWidget {
  const QuizzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => QuestionsRepository(),
      child: BlocProvider(
        create:
            (context) => QuizzerBloc(
              questionRepository: context.read<QuestionsRepository>(),
            ),
        child: const QuizzerView(),
      ),
    );
  }
}

class QuizzerView extends StatelessWidget {
  const QuizzerView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quizzerAppBarTitle),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 6),
          child: BlocBuilder<QuizzerBloc, QuizzerState>(
            builder: (context, state) {
              final progress = context.read<QuizzerBloc>().getProgress();
              return LinearProgressIndicator(value: progress);
            },
          ),
        ),
      ),
      body: BlocBuilder<QuizzerBloc, QuizzerState>(
        builder: (context, state) {
          return switch (state.status) {
            QuizzerStatus.initial => const QuizzerInitialView(),
            QuizzerStatus.inProgress => BlocListener<QuizzerBloc, QuizzerState>(
              listenWhen: (prev, curr) => prev.status != QuizzerStatus.initial,
              listener: (context, state) {
                final lastUserAns = state.history.last.userAnswer;
                final lastCorrectAns = state.history.last.correctAnswer;
                final wasCorrect = lastCorrectAns == lastUserAns;
                if (wasCorrect) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.tealAccent,
                        duration: Duration(milliseconds: 450),
                        content: ExcellentSnackbarContent(),
                      ),
                    );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.red[100],
                        duration: const Duration(milliseconds: 450),
                        content: const GoodTrySnackbarContent(),
                      ),
                    );
                }
              },
              child: const QuizzerInProgressView(),
            ),
            QuizzerStatus.done => const QuizzerResultsView(),
          };
        },
      ),
    );
  }
}
