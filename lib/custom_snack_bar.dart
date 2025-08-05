library custom_snackbar;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error, warning, info }

enum SnackbarPosition { top, bottom }

class CustomSnackBar {
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    SnackbarPosition position = SnackbarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final Color defaultTextColor = Colors.white;

    // تحديد الألوان والأيقونات حسب النوع
    final _typeData = _getTypeData(type);
    final _icon = icon ?? _typeData.icon;
    final _bgColor = backgroundColor ?? _typeData.backgroundColor;
    final _txtColor = textColor ?? defaultTextColor;

    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: _txtColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 14, color: _txtColor),
      ),
      backgroundColor: _bgColor,
      icon: Icon(_icon, color: _txtColor),
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
          backgroundColor: Color(0xFF4CAF50),
          icon: Icons.check_circle,
        );
      case SnackbarType.error:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFFF44336),
          icon: Icons.error,
        );
      case SnackbarType.warning:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFFFFC107),
          icon: Icons.warning,
        );
      case SnackbarType.info:
      default:
        return _SnackbarTypeData(
          backgroundColor: Color(0xFF2196F3),
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
