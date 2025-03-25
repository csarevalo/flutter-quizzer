import 'package:flutter/material.dart';
import 'package:flutter_quizzer/l10n/l10n.dart';
import 'package:flutter_quizzer/quizzer/view/view.dart';

///{@template app}
/// The material app.
/// {@endtemplate}
class App extends StatelessWidget {
  ///{@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          // dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          // dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const QuizzerScreen(),
    );
  }
}
