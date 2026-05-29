import 'dart:io';
import 'package:flutter/material.dart';
import '../presentation/resources/custom_elevated_button.dart';

class NavigationUtils {
  static Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app?'),
        actions: <Widget>[
          CustomElevatedButton(
            text: 'No',
            onTap: () {
              Navigator.of(context).pop(); // Close the dialog
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomePage()),
              // );
            },
          ),

          CustomElevatedButton(
            text: 'Yes',
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    )) ?? false;
  }
}
