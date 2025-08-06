import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error, warning, info }

enum SnackbarPosition { top, bottom }

class Snackly {
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    SnackbarPosition position = SnackbarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    IconData? icons,
    Color? backgroundColor,
    Color? textColor,
    final String? fontFamily,
  }) {
    final Color defaultTextColor = Colors.white;

    // تحديد الألوان والأيقونات حسب النوع
    final typeData = _getTypeData(type);
    final icon = icons ?? typeData.icon;
    final bgColor = backgroundColor ?? typeData.backgroundColor;
    final txtColor = textColor ?? defaultTextColor;

    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        textDirection: getTextDirection(title),
        style: TextStyle(
          fontSize: 18,
          color: txtColor,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
      ),
      messageText: Text(
        message,
        textDirection: getTextDirection(message),
        style: TextStyle(fontSize: 18, color: txtColor, fontFamily: fontFamily),
      ),
      backgroundColor: bgColor,
      icon: Icon(icon, color: txtColor),
      snackPosition: position == SnackbarPosition.top
          ? SnackPosition.TOP
          : SnackPosition.BOTTOM,
      duration: duration,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      boxShadows: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 8),
      ],
    );
  }

  static _SnackbarTypeData _getTypeData(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFF78A083),
          icon: Icons.check_circle,
        );
      case SnackbarType.error:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFFF7374F),
          icon: Icons.error,
        );
      case SnackbarType.warning:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFFDCA06D),
          icon: Icons.warning,
        );
      case SnackbarType.info:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFF535C91),
          icon: Icons.info,
        );
    }
  }
}

class _SnackbarTypeData {
  final Color backgroundColor;
  final IconData icon;

  _SnackbarTypeData({required this.backgroundColor, required this.icon});
}

TextDirection getTextDirection(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}
