import 'package:flutter/material.dart';

/// Returns a color based on the counter value:
/// - Green for positive
/// - Red for negative
/// - Grey for zero
Color getCounterColor(int counter) {
  if (counter > 0) return Colors.green;
  if (counter < 0) return Colors.red;
  return Colors.grey;
}
