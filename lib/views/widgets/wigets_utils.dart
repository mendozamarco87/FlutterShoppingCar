import 'package:flutter/material.dart';
import 'package:shopping_car/views/resources/colors.dart';

class WidgetUtils {
  
  static void showSnackbar(BuildContext context, String message, {Color? backgroundColor, IconData? iconData}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          if (iconData != null)
          Icon(iconData, color: Colorss.onSuccess,),
          if (iconData != null)
          SizedBox(width: 16),
          Flexible(child: Text(message, softWrap: true,)),
        ],
      ),
      duration: Duration(milliseconds: 1000),
      backgroundColor: backgroundColor,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  static void showSnackbarSuccess(BuildContext context, String message) {
    showSnackbar(context, message, backgroundColor: Colorss.success, iconData: Icons.check);
  }
  
  static void showSnackbarError(BuildContext context, String message) {
    showSnackbar(context, message, backgroundColor: Colorss.error, iconData: Icons.error);
  }

}
