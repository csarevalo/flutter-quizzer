import 'package:flutter/material.dart';

class ExcellentSnackbarContent extends StatelessWidget {
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

class GoodTrySnackbarContent extends StatelessWidget {
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
