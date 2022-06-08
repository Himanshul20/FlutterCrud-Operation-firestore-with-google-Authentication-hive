import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static void showTopSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) =>
      showSimpleNotification(
        Center(child: Text('Network Status')),
        subtitle: Center(child: Text(message)),
        background: color,
        duration: Duration(seconds: 10),

      );
}