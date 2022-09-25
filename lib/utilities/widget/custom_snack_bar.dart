import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:flutter/material.dart';

SnackBar customSnackBar({required String title, bool isError = false}) {
  return SnackBar(
      backgroundColor: Colors.grey,
      content: Container(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: VariableUtilities.size.width * 0.045,
              fontWeight: FontWeight.w600),
        ),
      ));
}
