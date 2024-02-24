import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  static double averageRating(List<int> rating) {
    if (rating.isEmpty) return 0.0; // Handle the case when the list is empty

    var sumRating = 0;
    for (int i = 0; i < rating.length; i++) {
      sumRating += rating[i];
    }

    // Perform division using double to retain decimal points
    double avgRating = sumRating / rating.length;

    // Return the computed average directly
    return double.parse(avgRating.toStringAsFixed(1));
  }

  static focusNodeChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static flushbarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          backgroundColor: Colors.redAccent,
          messageColor: Colors.black,
          icon: const Icon(
            Icons.error_outline,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 4),
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.decelerate,
        )..show(context));
  }

  static snackBarMessage(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }
}
