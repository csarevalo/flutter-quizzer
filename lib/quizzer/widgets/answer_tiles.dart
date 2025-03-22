import 'package:flutter/material.dart';

class AnswerTiles extends StatelessWidget {
  const AnswerTiles({
    required this.answers,
    required this.onTap,
    super.key,
    this.spacing = 32,
  });

  final List<String> answers;
  final double spacing;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: spacing,
      children: [
        ...List<Widget>.generate(answers.length, (i) {
          final answer = answers[i];
          return _AnswerTile(
            key: ValueKey(i),
            answer: answer,
            onPressed: () => onTap(answer),
            textPadding: 11,
          );
        }),
      ],
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.answer,
    required this.onPressed,
    super.key,
    this.textPadding = 8,
  });

  final String answer;
  final VoidCallback onPressed;
  final double textPadding;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(textPadding),
          child: Text(answer),
        ),
      ),
    );
  }
}
