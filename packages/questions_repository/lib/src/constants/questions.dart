import 'package:questions_repository/src/models/models.dart';

/// The list of `Question`s used in the repository.
const List<Question> kQuestions = [
  Question(
    id: 0,
    question: 'What are the main building blocks of Flutter UIs?',
    answer: 'Widgets',
    invalidAnswers: ['Components', 'Blocks', 'Functions'],
    points: 1,
  ),
  Question(
    id: 1,
    question: 'How are Flutter UIs built?',
    answer: 'By combining widgets in code',
    invalidAnswers: [
      'By combining widgets in a visual editor',
      'By defining widgets in config files',
      'By using XCode for iOS and Android Studio for Android',
    ],
    points: 1,
  ),
  Question(
    id: 2,
    question: "What's the purpose of a StatefulWidget?",
    answer: 'Update UI as data changes',
    invalidAnswers: [
      'Update data as UI changes',
      'Ignore data changes',
      'Render UI that does not depend on data',
    ],
    points: 1,
  ),
  Question(
    id: 3,
    question:
        'Which widget should you try to use more often: '
        'StatelessWidget or StatefulWidget?',
    answer: 'StatelessWidget',
    invalidAnswers: [
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
    points: 1,
  ),
  Question(
    id: 4,
    question: 'What happens if you change data in a StatelessWidget?',
    answer: 'The UI is not updated',
    invalidAnswers: [
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
    points: 1,
  ),
  Question(
    id: 5,
    question: 'How should you update data inside of StatefulWidgets?',
    answer: 'By calling setState()',
    invalidAnswers: [
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
    points: 1,
  ),
];
