import 'package:flutter/material.dart';
class NoDataScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Record found',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}