import 'package:flutter/material.dart';

///{@template excellent_snackbar_content}
/// Widget that contains a congratulatory snackbar message for user.
/// {@endtemplate}
class ExcellentSnackbarContent extends StatelessWidget {
  ///{@macro excellent_snackbar_content}
  const ExcellentSnackbarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        const Icon(Icons.check, color: Colors.green),
        Text(
          'Great Job!',
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

///{@template good_try_snackbar_content}
/// Widget that contains an encouraging snackbar message for user.
/// {@endtemplate}
class GoodTrySnackbarContent extends StatelessWidget {
  ///{@macro good_try_snackbar_content}
  const GoodTrySnackbarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        const Icon(Icons.check, color: Colors.red),
        Text(
          'Good Try!',
          style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
