import 'package:flutter/material.dart';

class OperationButton extends StatelessWidget {
  final String operation;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const OperationButton({
    required this.operation,
    required this.onPressed,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      child: Text(operation),
    );
  }
}