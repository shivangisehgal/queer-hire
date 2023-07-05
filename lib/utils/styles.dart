import 'package:flutter/material.dart';
import '/utils/colors.dart';

ButtonStyle AppButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  backgroundColor: MaterialStateProperty.all(AppColors.primary),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      side: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(50),
    ),
  ),
);
