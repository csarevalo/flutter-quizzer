import 'package:flutter/material.dart';
import 'package:flutter_quizzer/quizzer/models/question_answer.dart';

class QASummaryTile extends StatelessWidget {
  const QASummaryTile({
    super.key,
    required this.number,
    required this.questionAnswer,
  });

  final int number;
  final QuestionAnswer questionAnswer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final pointLabel = questionAnswer.points == 1 ? 'pt' : 'pts';
    return ListTile(
      isThreeLine: true,
      leading: Container(
        alignment: Alignment.center,
        width: 28,
        height: 28,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: questionAnswer.points > 0 ? Colors.lightBlue : Colors.red[100],
          shape: BoxShape.circle,
        ),
        child: Text(
          number.toString(),
          style: textTheme.bodySmall!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        '${questionAnswer.question} (${questionAnswer.points} $pointLabel)',
        style: textTheme.bodyLarge!.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Correct Answer: ${questionAnswer.correctAnswer}',
            style: textTheme.bodyMedium!.copyWith(color: colorScheme.tertiary),
          ),
          Text(
            'Actual Answer: ${questionAnswer.userAnswer}',
            style: textTheme.bodyMedium!.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
