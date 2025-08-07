import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error, warning, info, custom }

enum SnackbarPosition { top, bottom }

class SnacklyConfig {
  static Duration defaultDuration = const Duration(seconds: 3);
  static String? defaultFontFamily;
  static bool enableHapticFeedback = true;
  static bool isDismissible = true;
  static double defaultBorderRadius = 12.0;
  static EdgeInsets defaultMargin = const EdgeInsets.all(16);
  static EdgeInsets defaultPadding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );

  // إعدادات الألوان الافتراضية
  static Color successColor = const Color(0xFF4CAF50);
  static Color errorColor = const Color(0xFFF44336);
  static Color warningColor = const Color(0xFFFF9800);
  static Color infoColor = const Color(0xFF2196F3);
}

class Snackly {
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    SnackbarPosition position = SnackbarPosition.bottom,
    Duration? duration,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    String? fontFamily,
    double? fontSize,
    double? titleFontSize,
    FontWeight? fontWeight,
    FontWeight? titleFontWeight,
    double? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool? isDismissible,
    bool showProgressIndicator = false,
    double? progressValue, // للتحكم بقيمة التقدم
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Color? actionColor,
    List<BoxShadow>? boxShadows,
    bool enableHapticFeedback = true,
    Gradient? backgroundGradient,
  }) {
    // إعدادات افتراضية
    final effectiveDuration = duration ?? SnacklyConfig.defaultDuration;
    final effectiveFontFamily = fontFamily ?? SnacklyConfig.defaultFontFamily;
    final effectiveBorderRadius =
        borderRadius ?? SnacklyConfig.defaultBorderRadius;
    final effectiveMargin = margin ?? SnacklyConfig.defaultMargin;
    final effectivePadding = padding ?? SnacklyConfig.defaultPadding;
    final effectiveIsDismissible = isDismissible ?? SnacklyConfig.isDismissible;

    // تحديد بيانات النوع
    final typeData = _getTypeData(type, backgroundColor, icon);
    final finalIcon = icon ?? typeData.icon;
    final finalBgColor = backgroundColor ?? typeData.backgroundColor;
    final finalTextColor = textColor ?? Colors.white;
    final finalIconColor = iconColor ?? finalTextColor;

    // Haptic feedback
    if (enableHapticFeedback && SnacklyConfig.enableHapticFeedback) {
      _performHapticFeedback(type);
    }

    Widget? customSnackbarContent;
    if (showProgressIndicator) {
      customSnackbarContent = _buildCustomSnackbarWithProgress(
        title: title,
        message: message,
        icon: finalIcon,
        iconColor: finalIconColor,
        textColor: finalTextColor,
        fontFamily: effectiveFontFamily,
        titleFontSize: titleFontSize ?? fontSize ?? 18,
        messageFontSize: fontSize ?? 16,
        titleFontWeight: titleFontWeight ?? FontWeight.bold,
        messageFontWeight: fontWeight ?? FontWeight.normal,
        progressValue: progressValue,
        backgroundColor: finalBgColor,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        actionColor: actionColor,
      );
    }

    Get.snackbar(
      '',
      '',
      titleText: customSnackbarContent == null
          ? _buildTitleText(
              title,
              finalTextColor,
              effectiveFontFamily,
              titleFontSize ?? fontSize ?? 18,
              titleFontWeight ?? FontWeight.bold,
            )
          : const SizedBox.shrink(),
      messageText: customSnackbarContent == null
          ? _buildMessageText(
              message,
              finalTextColor,
              effectiveFontFamily,
              fontSize ?? 16,
              fontWeight ?? FontWeight.normal,
            )
          : customSnackbarContent,
      backgroundColor: backgroundGradient != null
          ? Colors.transparent
          : finalBgColor,
      backgroundGradient: backgroundGradient,
      icon: customSnackbarContent == null && finalIcon != null
          ? Icon(finalIcon, color: finalIconColor, size: 28)
          : null,
      snackPosition: position == SnackbarPosition.top
          ? SnackPosition.TOP
          : SnackPosition.BOTTOM,
      duration: effectiveDuration,
      margin: effectiveMargin,
      borderRadius: effectiveBorderRadius,
      padding: customSnackbarContent != null
          ? EdgeInsets.zero
          : effectivePadding,
      isDismissible: effectiveIsDismissible,
      dismissDirection: DismissDirection.horizontal,
      // أنيميشن محسن وسلس
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 350),
      boxShadows: boxShadows ?? _getDefaultBoxShadows(),
      mainButton: customSnackbarContent == null
          ? _buildActionButton(actionLabel, onActionPressed, actionColor)
          : null,
      onTap: onTap != null ? (_) => onTap() : null,
    );
  }

  // دوال مساعدة للعرض السريع
  static void success({
    required String title,
    required String message,
    Duration? duration,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.success,
      duration: duration,
      position: position,
    );
  }

  static void error({
    required String title,
    required String message,
    Duration? duration,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.error,
      duration: duration,
      position: position,
    );
  }

  static void warning({
    required String title,
    required String message,
    Duration? duration,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.warning,
      duration: duration,
      position: position,
    );
  }

  static void info({
    required String title,
    required String message,
    Duration? duration,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    show(
      title: title,
      message: message,
      type: SnackbarType.info,
      duration: duration,
      position: position,
    );
  }

  // إخفاء جميع الـ Snackbars
  static void closeAll() {
    Get.closeAllSnackbars();
  }

  // إخفاء الـ Snackbar الحالي
  static void close() {
    Get.closeCurrentSnackbar();
  }

  // التحقق من وجود Snackbar نشط
  static bool get isSnackbarOpen => Get.isSnackbarOpen;

  // دالة لعرض Snackbar بتحديث تدريجي
  static void showWithProgress({
    required String title,
    required String message,
    required Future<void> future,
    SnackbarType type = SnackbarType.info,
    String? successTitle,
    String? successMessage,
    String? errorTitle,
    String? errorMessage,
    Function(double)? onProgress,
  }) async {
    show(
      title: title,
      message: message,
      type: type,
      showProgressIndicator: true,
      duration: const Duration(hours: 1), // مدة طويلة للانتظار
    );

    try {
      await future;
      close();
      success(
        title: successTitle ?? "نجح",
        message: successMessage ?? "تمت العملية بنجاح",
      );
    } catch (e) {
      close();
      error(
        title: errorTitle ?? "خطأ",
        message: errorMessage ?? "حدث خطأ أثناء العملية",
      );
    }
  }

  // دالة لعرض تقدم بقيمة محددة
  static void showProgressValue({
    required String title,
    required String message,
    required double progressValue,
    SnackbarType type = SnackbarType.info,
    Duration? duration,
  }) {
    show(
      title: title,
      message: message,
      type: type,
      showProgressIndicator: true,
      progressValue: progressValue,
      duration: duration,
    );
  }

  // الدوال المساعدة الخاصة
  static _SnackbarTypeData _getTypeData(
    SnackbarType type,
    Color? customBg,
    IconData? customIcon,
  ) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarTypeData(
          backgroundColor: customBg ?? SnacklyConfig.successColor,
          icon: customIcon ?? Icons.check_circle_rounded,
        );
      case SnackbarType.error:
        return _SnackbarTypeData(
          backgroundColor: customBg ?? SnacklyConfig.errorColor,
          icon: customIcon ?? Icons.error_rounded,
        );
      case SnackbarType.warning:
        return _SnackbarTypeData(
          backgroundColor: customBg ?? SnacklyConfig.warningColor,
          icon: customIcon ?? Icons.warning_rounded,
        );
      case SnackbarType.info:
        return _SnackbarTypeData(
          backgroundColor: customBg ?? SnacklyConfig.infoColor,
          icon: customIcon ?? Icons.info_rounded,
        );
      case SnackbarType.custom:
        return _SnackbarTypeData(
          backgroundColor: customBg ?? Colors.grey[600]!,
          icon: customIcon ?? Icons.notifications_rounded,
        );
    }
  }

  static Widget _buildTitleText(
    String title,
    Color color,
    String? fontFamily,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return Text(
      title,
      textDirection: getTextDirection(title),
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }

  static Widget _buildMessageText(
    String message,
    Color color,
    String? fontFamily,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return Text(
      message,
      textDirection: getTextDirection(message),
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }

  static TextButton? _buildActionButton(
    String? actionLabel,
    VoidCallback? onActionPressed,
    Color? actionColor,
  ) {
    if (actionLabel != null && onActionPressed != null) {
      return TextButton(
        onPressed: onActionPressed,
        child: Text(
          actionLabel,
          style: TextStyle(
            color: actionColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return null;
  }

  static List<BoxShadow> _getDefaultBoxShadows() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }

  // بناء Snackbar مخصص مع شريط التقدم
  static Widget _buildCustomSnackbarWithProgress({
    required String title,
    required String message,
    required IconData? icon,
    required Color iconColor,
    required Color textColor,
    required String? fontFamily,
    required double titleFontSize,
    required double messageFontSize,
    required FontWeight titleFontWeight,
    required FontWeight messageFontWeight,
    required Color backgroundColor,
    double? progressValue,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Color? actionColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // المحتوى الرئيسي
          Row(
            children: [
              // الأيقونة
              if (icon != null) ...[
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 12),
              ],
              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textDirection: getTextDirection(title),
                      style: TextStyle(
                        fontSize: titleFontSize,
                        color: textColor,
                        fontWeight: titleFontWeight,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      textDirection: getTextDirection(message),
                      style: TextStyle(
                        fontSize: messageFontSize,
                        color: textColor.withOpacity(0.9),
                        fontFamily: fontFamily,
                        fontWeight: messageFontWeight,
                      ),
                    ),
                  ],
                ),
              ),
              // زر الإجراء
              if (actionLabel != null && onActionPressed != null)
                TextButton(
                  onPressed: onActionPressed,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    actionLabel,
                    style: TextStyle(
                      color: actionColor ?? Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
          // شريط التقدم في الأسفل
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withOpacity(0.9),
              ),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  static void _performHapticFeedback(SnackbarType type) {
    // يمكنك إضافة مكتبة haptic feedback هنا
    // مثل: HapticFeedback.lightImpact() أو حسب النوع
  }
}

class _SnackbarTypeData {
  final Color backgroundColor;
  final IconData? icon;

  _SnackbarTypeData({required this.backgroundColor, this.icon});
}

// دالة للتحقق من اتجاه النص (عربي/إنجليزي)
TextDirection getTextDirection(String text) {
  final arabicRegex = RegExp(
    r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
  );
  return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}

// Extension لاستخدام أسهل
extension SnacklyExtension on String {
  void showAsSuccess({String? title}) {
    Snackly.success(title: title ?? "نجح", message: this);
  }

  void showAsError({String? title}) {
    Snackly.error(title: title ?? "خطأ", message: this);
  }

  void showAsWarning({String? title}) {
    Snackly.warning(title: title ?? "تحذير", message: this);
  }

  void showAsInfo({String? title}) {
    Snackly.info(title: title ?? "معلومة", message: this);
  }
}
