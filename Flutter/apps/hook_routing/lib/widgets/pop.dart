import 'package:flutter/material.dart';

class popWidget extends StatelessWidget {
  const popWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {Navigator.of(context).pop()},
      child: Text(
        '戻る',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
