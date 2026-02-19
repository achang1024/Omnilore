import 'package:flutter/material.dart';
import 'package:omnilore_scheduler/io/file_io_exceptions.dart';

class Utils {
  static String getErrorMessage(Object error) {
    if (error is UnsupportedFileIoException) {
      return error.userMessage;
    }
    return error.toString();
  }

  /// creates an error popup
  static Future<void> showPopUp(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // must be dismissed
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
