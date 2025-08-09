import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SnackbarType { success, error, warning, info, loading, custom }

enum SnackbarPosition { top, bottom }

enum SnackbarStyle { filled, outlined, minimal, elevated }

class SnacklyTheme {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? actionColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;

  const SnacklyTheme({
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.actionColor,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.gradient,
  });
}

class SnacklyConfig {
  static Duration defaultDuration = const Duration(seconds: 4);
  static Duration shortDuration = const Duration(seconds: 2);
  static Duration longDuration = const Duration(seconds: 6);

  static String? defaultFontFamily;
  static bool enableHapticFeedback = true;
  static bool enableAutoHide = true;
  static bool showCloseButton = false;
  static bool enableSwipeToClose = true;
  static bool enableBounceAnimation = true;

  static double defaultBorderRadius = 16.0;
  static EdgeInsets defaultMargin = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static EdgeInsets defaultPadding = const EdgeInsets.all(20);

  static SnackbarPosition defaultPosition = SnackbarPosition.bottom;
  static SnackbarStyle defaultStyle = SnackbarStyle.filled;

  // الألوان المحسنة مع درجات أفضل
  static const Map<SnackbarType, SnacklyTheme> themes = {
    SnackbarType.success: SnacklyTheme(
      backgroundColor: Color(0xFF10B981),
      textColor: Colors.white,
      iconColor: Colors.white,
      shadows: [
        BoxShadow(
          color: Color(0x4010B981),
          offset: Offset(0, 8),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ],
    ),
    SnackbarType.error: SnacklyTheme(
      backgroundColor: Color(0xFFEF4444),
      textColor: Colors.white,
      iconColor: Colors.white,
      shadows: [
        BoxShadow(
          color: Color(0x40EF4444),
          offset: Offset(0, 8),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ],
    ),
    SnackbarType.warning: SnacklyTheme(
      backgroundColor: Color(0xFFF59E0B),
      textColor: Colors.white,
      iconColor: Colors.white,
      shadows: [
        BoxShadow(
          color: Color(0x40F59E0B),
          offset: Offset(0, 8),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ],
    ),
    SnackbarType.info: SnacklyTheme(
      backgroundColor: Color(0xFF3B82F6),
      textColor: Colors.white,
      iconColor: Colors.white,
      shadows: [
        BoxShadow(
          color: Color(0x403B82F6),
          offset: Offset(0, 8),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ],
    ),
    SnackbarType.loading: SnacklyTheme(
      backgroundColor: Color(0xFF6B7280),
      textColor: Colors.white,
      iconColor: Colors.white,
      shadows: [
        BoxShadow(
          color: Color(0x406B7280),
          offset: Offset(0, 8),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ],
    ),
  };
}

class Snackly {
  static OverlayEntry? _currentOverlay;
  static bool _isShowing = false;

  /// عرض رسالة نجاح
  static void success({
    required BuildContext context,
    required String title,
    String? message,
    Duration? duration,
    SnackbarPosition? position,
    SnackbarStyle? style,
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = false,
  }) {
    show(
      context: context,
      title: title,
      message: message ?? '',
      type: SnackbarType.success,
      duration: duration,
      position: position,
      style: style,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      showCloseButton: showCloseButton,
    );
  }

  /// عرض رسالة خطأ
  static void error({
    required BuildContext context,
    required String title,
    String? message,
    Duration? duration,
    SnackbarPosition? position,
    SnackbarStyle? style,
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = true,
  }) {
    show(
      context: context,
      title: title,
      message: message ?? '',
      type: SnackbarType.error,
      duration: duration ?? SnacklyConfig.longDuration,
      position: position,
      style: style,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      showCloseButton: showCloseButton,
    );
  }

  /// عرض رسالة تحذير
  static void warning({
    required BuildContext context,
    required String title,
    String? message,
    Duration? duration,
    SnackbarPosition? position,
    SnackbarStyle? style,
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = false,
  }) {
    show(
      context: context,
      title: title,
      message: message ?? '',
      type: SnackbarType.warning,
      duration: duration,
      position: position,
      style: style,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      showCloseButton: showCloseButton,
    );
  }

  /// عرض رسالة معلومات
  static void info({
    required BuildContext context,
    required String title,
    String? message,
    Duration? duration,
    SnackbarPosition? position,
    SnackbarStyle? style,
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = false,
  }) {
    show(
      context: context,
      title: title,
      message: message ?? '',
      type: SnackbarType.info,
      duration: duration,
      position: position,
      style: style,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      showCloseButton: showCloseButton,
    );
  }

  /// عرض رسالة تحميل
  static void loading({
    required BuildContext context,
    required String title,
    String? message,
    bool showProgressIndicator = true,
    double? progressValue,
    VoidCallback? onTap,
  }) {
    show(
      context: context,
      title: title,
      message: message ?? '',
      type: SnackbarType.loading,
      duration: const Duration(minutes: 1), // مدة طويلة للتحميل
      showProgressIndicator: showProgressIndicator,
      progressValue: progressValue,
      onTap: onTap,
    );
  }

  /// إخفاء الرسالة الحالية
  static void hide() {
    if (_currentOverlay != null && _isShowing) {
      _currentOverlay!.remove();
      _currentOverlay = null;
      _isShowing = false;
    }
  }

  /// الدالة الرئيسية لعرض الـ Snackbar
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    SnackbarPosition? position,
    SnackbarStyle? style,
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
    bool showProgressIndicator = false,
    double? progressValue,
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Color? actionColor,
    List<BoxShadow>? boxShadows,
    bool enableHapticFeedback = true,
    Gradient? backgroundGradient,
    bool showCloseButton = false,
    Widget? customIcon,
    Widget? leading,
    Widget? trailing,
  }) {
    // إخفاء أي رسالة حالية
    hide();

    final effectivePosition = position ?? SnacklyConfig.defaultPosition;
    final effectiveStyle = style ?? SnacklyConfig.defaultStyle;
    final effectiveDuration = duration ?? SnacklyConfig.defaultDuration;
    final effectiveFontFamily = fontFamily ?? SnacklyConfig.defaultFontFamily;
    final effectiveBorderRadius =
        borderRadius ?? SnacklyConfig.defaultBorderRadius;
    final effectiveMargin = margin ?? SnacklyConfig.defaultMargin;
    final effectivePadding = padding ?? SnacklyConfig.defaultPadding;

    final theme = SnacklyConfig.themes[type] ?? const SnacklyTheme();
    final typeData = _getTypeData(type, icon);

    if (enableHapticFeedback && SnacklyConfig.enableHapticFeedback) {
      _performHapticFeedback(type);
    }

    final overlay = Overlay.of(context);
    _currentOverlay = OverlayEntry(
      builder: (context) => _SnackbarWidget(
        title: title,
        message: message,
        type: type,
        theme: theme,
        style: effectiveStyle,
        position: effectivePosition,
        duration: effectiveDuration,
        icon: typeData.icon,
        customIcon: customIcon,
        backgroundColor: backgroundColor,
        textColor: textColor,
        iconColor: iconColor,
        fontFamily: effectiveFontFamily,
        fontSize: fontSize,
        titleFontSize: titleFontSize,
        fontWeight: fontWeight,
        titleFontWeight: titleFontWeight,
        borderRadius: effectiveBorderRadius,
        margin: effectiveMargin,
        padding: effectivePadding,
        showProgressIndicator: showProgressIndicator,
        progressValue: progressValue,
        onTap: onTap,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        actionColor: actionColor,
        boxShadows: boxShadows,
        backgroundGradient: backgroundGradient,
        showCloseButton: showCloseButton,
        leading: leading,
        trailing: trailing,
        onDismiss: hide,
      ),
    );

    overlay.insert(_currentOverlay!);
    _isShowing = true;

    // إخفاء تلقائي
    if (SnacklyConfig.enableAutoHide && type != SnackbarType.loading) {
      Future.delayed(effectiveDuration, () {
        hide();
      });
    }
  }

  static _SnackbarTypeData _getTypeData(
    SnackbarType type,
    IconData? customIcon,
  ) {
    final iconMap = {
      SnackbarType.success: customIcon ?? Icons.check_circle_rounded,
      SnackbarType.error: customIcon ?? Icons.error_rounded,
      SnackbarType.warning: customIcon ?? Icons.warning_rounded,
      SnackbarType.info: customIcon ?? Icons.info_rounded,
      SnackbarType.loading: customIcon ?? Icons.hourglass_empty_rounded,
      SnackbarType.custom: customIcon ?? Icons.notifications_rounded,
    };

    return _SnackbarTypeData(icon: iconMap[type]);
  }

  static void _performHapticFeedback(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
      case SnackbarType.info:
        HapticFeedback.lightImpact();
        break;
      case SnackbarType.warning:
        HapticFeedback.mediumImpact();
        break;
      case SnackbarType.error:
        HapticFeedback.heavyImpact();
        break;
      case SnackbarType.loading:
        HapticFeedback.selectionClick();
        break;
      case SnackbarType.custom:
        HapticFeedback.selectionClick();
        break;
    }
  }
}

class _SnackbarWidget extends StatefulWidget {
  final String title;
  final String message;
  final SnackbarType type;
  final SnacklyTheme theme;
  final SnackbarStyle style;
  final SnackbarPosition position;
  final Duration duration;
  final IconData? icon;
  final Widget? customIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final String? fontFamily;
  final double? fontSize;
  final double? titleFontSize;
  final FontWeight? fontWeight;
  final FontWeight? titleFontWeight;
  final double borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool showProgressIndicator;
  final double? progressValue;
  final VoidCallback? onTap;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Color? actionColor;
  final List<BoxShadow>? boxShadows;
  final Gradient? backgroundGradient;
  final bool showCloseButton;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onDismiss;

  const _SnackbarWidget({
    required this.title,
    required this.message,
    required this.type,
    required this.theme,
    required this.style,
    required this.position,
    required this.duration,
    required this.borderRadius,
    required this.margin,
    required this.padding,
    required this.showProgressIndicator,
    required this.showCloseButton,
    required this.onDismiss,
    this.icon,
    this.customIcon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.fontFamily,
    this.fontSize,
    this.titleFontSize,
    this.fontWeight,
    this.titleFontWeight,
    this.progressValue,
    this.onTap,
    this.actionLabel,
    this.onActionPressed,
    this.actionColor,
    this.boxShadows,
    this.backgroundGradient,
    this.leading,
    this.trailing,
  });

  @override
  State<_SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<_SnackbarWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _progressController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // تحديد اتجاه الحركة حسب الموضع
    final begin = widget.position == SnackbarPosition.top
        ? const Offset(0, -1)
        : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    if (widget.type != SnackbarType.loading) {
      _progressController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == SnackbarPosition.top
          ? MediaQuery.of(context).padding.top + 16
          : null,
      bottom: widget.position == SnackbarPosition.bottom
          ? MediaQuery.of(context).padding.bottom + 16
          : null,
      left: widget.margin.left,
      right: widget.margin.right,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              color: Colors.transparent,
              child: _buildSnackbarContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSnackbarContent() {
    final finalBgColor =
        widget.backgroundColor ??
        (widget.backgroundGradient == null
            ? widget.theme.backgroundColor
            : null);
    final finalTextColor =
        widget.textColor ?? widget.theme.textColor ?? Colors.white;
    final finalIconColor =
        widget.iconColor ?? widget.theme.iconColor ?? finalTextColor;

    return GestureDetector(
      onTap: widget.onTap,
      onPanUpdate: SnacklyConfig.enableSwipeToClose ? _handlePanUpdate : null,
      child: Container(
        decoration: _buildDecoration(finalBgColor),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Stack(
            children: [
              // محتوى الـ Snackbar
              Padding(
                padding: widget.padding,
                child: _buildContent(finalTextColor, finalIconColor),
              ),
              // شريط التقدم في الأسفل
              if (widget.showProgressIndicator &&
                  widget.type != SnackbarType.loading)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value:
                            widget.progressValue ??
                            (1 - _progressController.value),
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          finalTextColor,
                        ),
                        minHeight: 3,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(Color? backgroundColor) {
    switch (widget.style) {
      case SnackbarStyle.filled:
        return BoxDecoration(
          color: backgroundColor,
          gradient: widget.backgroundGradient ?? widget.theme.gradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: widget.boxShadows ?? widget.theme.shadows,
        );
      case SnackbarStyle.outlined:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: widget.theme.borderColor ?? backgroundColor ?? Colors.grey,
            width: widget.theme.borderWidth ?? 2,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: widget.boxShadows,
        );
      case SnackbarStyle.minimal:
        return BoxDecoration(
          color: backgroundColor?.withOpacity(0.1),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        );
      case SnackbarStyle.elevated:
        return BoxDecoration(
          color: backgroundColor,
          gradient: widget.backgroundGradient ?? widget.theme.gradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 16),
              blurRadius: 24,
              spreadRadius: 0,
            ),
          ],
        );
    }
  }

  Widget _buildContent(Color finalTextColor, Color finalIconColor) {
    return Row(
      children: [
        // Leading widget أو الأيقونة
        if (widget.leading != null) ...[
          widget.leading!,
          const SizedBox(width: 16),
        ] else if (widget.customIcon != null || widget.icon != null) ...[
          _buildIcon(finalIconColor),
          const SizedBox(width: 16),
        ],

        // النصوص
        Expanded(child: _buildTextContent(finalTextColor)),

        // زر الإجراء
        if (widget.actionLabel != null && widget.onActionPressed != null) ...[
          const SizedBox(width: 16),
          _buildActionButton(),
        ],

        // زر الإغلاق
        if (widget.showCloseButton) ...[
          const SizedBox(width: 8),
          _buildCloseButton(finalIconColor),
        ],

        // Trailing widget
        if (widget.trailing != null) ...[
          const SizedBox(width: 16),
          widget.trailing!,
        ],
      ],
    );
  }

  Widget _buildIcon(Color iconColor) {
    if (widget.customIcon != null) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: widget.customIcon!,
      );
    }

    if (widget.type == SnackbarType.loading) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(iconColor),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(widget.icon, color: iconColor, size: 24),
    );
  }

  Widget _buildTextContent(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          textDirection: _getTextDirection(widget.title),
          style: TextStyle(
            fontSize: widget.titleFontSize ?? 16,
            color: textColor,
            fontWeight: widget.titleFontWeight ?? FontWeight.w600,
            fontFamily: widget.fontFamily,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (widget.message.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            widget.message,
            textDirection: _getTextDirection(widget.message),
            style: TextStyle(
              fontSize: widget.fontSize ?? 14,
              color: textColor.withOpacity(0.9),
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              fontFamily: widget.fontFamily,
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (widget.showProgressIndicator &&
            widget.type == SnackbarType.loading &&
            widget.progressValue != null) ...[
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: widget.progressValue,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
            minHeight: 4,
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton() {
    return TextButton(
      onPressed: widget.onActionPressed,
      style: TextButton.styleFrom(
        foregroundColor: widget.actionColor ?? Colors.white,
        backgroundColor: Colors.white.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        widget.actionLabel!,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  Widget _buildCloseButton(Color iconColor) {
    return GestureDetector(
      onTap: () {
        _animationController.reverse().then((_) {
          widget.onDismiss();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(Icons.close, color: iconColor, size: 18),
      ),
    );
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    // السماح بالسحب للأعلى أو الأسفل لإخفاء الـ Snackbar
    if (details.delta.dy.abs() > 2) {
      _animationController.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  TextDirection _getTextDirection(String text) {
    final arabicRegex = RegExp(
      r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
    );
    return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}

class _SnackbarTypeData {
  final IconData? icon;
  _SnackbarTypeData({this.icon});
}
