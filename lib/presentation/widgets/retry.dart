import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const Retry({
    super.key,
    required this.onRetry,
    this.error = "An unexpected error occurred.",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.red, size: 48),
            Text(
              "Error: $error",
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                onRetry();
              },
              child: Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
