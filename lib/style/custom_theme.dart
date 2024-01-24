import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/custom_colors.dart';

class AppTheme {
  static final defaultAppTheme = ThemeData(
    primaryColor: CustomColors.blackColor,
    scaffoldBackgroundColor: CustomColors.whiteColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: CustomColors.blackColor,
    ),
    appBarTheme: const AppBarTheme(
      color: CustomColors.whiteColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: CustomColors.blackColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        fontFamily: 'PhantomSans',
      ),
      iconTheme: IconThemeData(color: CustomColors.blackColor),
      actionsIconTheme: IconThemeData(color: CustomColors.blackColor),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 0.5,
      space: 0.5,
      indent: 10,
      endIndent: 10,
    ),
    fontFamily: 'PhantomSans',
  );
}
