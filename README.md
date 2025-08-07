<p align="center">
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/logo.png" width="120" alt="Snackly Logo" />
</p>

<h1 align="center">Snackly ❤️</h1>

<p align="center">
  <strong>Smart • Beautiful • Customizable Flutter Snackbar</strong>
</p>

<p align="center">
  <a href="https://pub.dev/packages/snackly"><img src="https://img.shields.io/pub/v/snackly.svg" alt="Pub Version"></a>
  <a href="https://pub.dev/packages/snackly"><img src="https://img.shields.io/pub/points/snackly" alt="Pub Points"></a>
  <a href="https://pub.dev/packages/snackly"><img src="https://img.shields.io/pub/likes/snackly" alt="Pub Likes"></a>
  <a href="https://github.com/EnadAbulawi/snackly/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
</p>

---

## 🌟 What's New in v0.0.6

- 🎯 **Enhanced Progress Indicators** - Beautiful, smooth progress bars at the bottom
- 🎨 **Gradient Backgrounds** - Support for stunning gradient backgrounds
- ⚡ **Smooth Animations** - Fixed animation stuttering issues
- 🔧 **Global Configuration** - Set app-wide defaults with `SnacklyConfig`
- 🎮 **Quick Access Methods** - `Snackly.success()`, `Snackly.error()`, etc.
- 📱 **Haptic Feedback** - Enhanced user experience with haptic responses
- 🔄 **Progress Tracking** - Built-in async operations with progress tracking
- 🎭 **String Extensions** - Show snackbars directly from strings
- 🌍 **Improved RTL Support** - Better Arabic/Persian text handling

---

## 🖼️ Screenshots

<p float="left">
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/screenshots/success.png" width="22%" />
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/screenshots/error.png" width="22%" />
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/screenshots/warning.png" width="22%" />
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/screenshots/info.png" width="22%" />
</p>

<p float="left">
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/screenshots/progress.png" width="45%" />
  <!-- <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/screenshots/gradient.png" width="45%" /> -->
</p>

---

## ✨ Features

### 🎯 **Easy to Use**
- One-line usage for common scenarios
- Quick access methods for all types
- String extensions for ultra-fast implementation

### 🌐 **Smart Text Direction**
- Automatic RTL/LTR detection
- Enhanced Arabic, Persian, and Hebrew support
- Perfect text alignment

### 🎨 **Highly Customizable**
- Multiple built-in types (success, error, warning, info, custom)
- Custom colors, icons, fonts, and sizes
- Gradient backgrounds support
- Custom action buttons

### 📍 **Flexible Positioning**
- Top or bottom positioning
- Custom margins and padding
- Dismissible or persistent options

### 🎮 **Enhanced User Experience**
- Smooth animations with no stuttering
- Haptic feedback support
- Progress indicators for long operations
- Action buttons with callbacks

### ⚙️ **Advanced Configuration**
- Global app-wide settings
- Progress tracking for async operations
- Multiple snackbar management
- Custom shadows and styling

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  snackly: ^0.0.6

```

---

## 📱 Usage

### Quick Start

```dart
import 'package:snackly/snackly.dart';

// Simple usage
Snackly.success(title: "Success!", message: "Data saved successfully");
Snackly.error(title: "Error!", message: "Network connection failed");
Snackly.warning(title: "Warning!", message: "Battery is low");
Snackly.info(title: "Info", message: "New update available");
```

### Advanced Usage

```dart
Snackly.show(
  title: 'Custom Snackbar',
  message: 'This is a highly customized snackbar',
  type: SnackbarType.success,
  position: SnackbarPosition.top,
  duration: Duration(seconds: 5),
  backgroundColor: Colors.deepPurple,
  textColor: Colors.white,
  icon: Icons.rocket_launch,
  showProgressIndicator: true,
  actionLabel: "UNDO",
  onActionPressed: () => print("Undo pressed"),
  onTap: () => print("Snackbar tapped"),
);
```

### Gradient Backgrounds

```dart
Snackly.show(
  title: 'Gradient Magic',
  message: 'Beautiful gradient background',
  type: SnackbarType.custom,
  backgroundGradient: LinearGradient(
    colors: [Colors.purple, Colors.blue, Colors.teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
```

### Progress Tracking

```dart
// Automatic progress tracking
Snackly.showWithProgress(
  title: "Uploading File",
  message: "Please wait...",
  future: uploadFileToServer(),
  successTitle: "Success!",
  successMessage: "File uploaded successfully",
  errorTitle: "Failed!",
  errorMessage: "Upload failed, please try again",
);

// Manual progress control
Snackly.showProgressValue(
  title: "Downloading",
  message: "75% completed",
  progressValue: 0.75,
  type: SnackbarType.info,
);
```

### String Extensions (Super Easy!)

```dart
"File saved successfully!".showAsSuccess();
"Network error occurred".showAsError();
"Please check your input".showAsWarning();
"New features are available".showAsInfo();

// With custom titles
"Operation completed".showAsSuccess(title: "Done!");
```

### Global Configuration

```dart
void main() {
  // Set global defaults
  SnacklyConfig.defaultDuration = Duration(seconds: 4);
  SnacklyConfig.defaultFontFamily = 'Cairo';
  SnacklyConfig.enableHapticFeedback = true;
  SnacklyConfig.successColor = Color(0xFF00C851);
  SnacklyConfig.errorColor = Color(0xFFFF4444);
  
  runApp(MyApp());
}
```

### Snackbar Management

```dart
// Check if snackbar is currently showing
if (Snackly.isSnackbarOpen) {
  print("Snackbar is currently visible");
}

// Close current snackbar
Snackly.closecurrent();

// Close all snackbars
Snackly.closeAll();
```

---

## 🎨 Customization Options

### SnackbarType Options
- `SnackbarType.success` - Green with check icon
- `SnackbarType.error` - Red with error icon  
- `SnackbarType.warning` - Orange with warning icon
- `SnackbarType.info` - Blue with info icon
- `SnackbarType.custom` - Fully customizable

### Position Options
- `SnackbarPosition.top` - Show at top of screen
- `SnackbarPosition.bottom` - Show at bottom of screen

### Progress Indicator
- Smooth animation at the bottom
- Customizable colors and opacity
- Support for determinate and indeterminate progress
- Perfect integration with snackbar design

---

## 🌍 Internationalization

Snackly automatically detects text direction:

```dart
// Arabic text (RTL)
Snackly.success(title: "نجح", message: "تم حفظ البيانات بنجاح");

// English text (LTR)  
Snackly.success(title: "Success", message: "Data saved successfully");

// Mixed content (automatically handled)
Snackly.info(title: "معلومة", message: "Available in English and العربية");
```

---

## 📋 Complete API Reference

### Main Method
```dart
Snackly.show({
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
  double? progressValue,
  VoidCallback? onTap,
  String? actionLabel,
  VoidCallback? onActionPressed,
  Color? actionColor,
  List<BoxShadow>? boxShadows,
  bool enableHapticFeedback = true,
  Gradient? backgroundGradient,
})
```

### Quick Access Methods
```dart
Snackly.success({required String title, required String message, ...})
Snackly.error({required String title, required String message, ...})
Snackly.warning({required String title, required String message, ...})
Snackly.info({required String title, required String message, ...})
Snackly.custom({required String title, required String message, ...})
```

### Utility Methods
```dart
Snackly.closecurrent()                    // Close current snackbar
Snackly.closeAll()                 // Close all snackbars
Snackly.isSnackbarOpen            // Check if snackbar is open
```

---

## 🤝 Contributing

We love contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Areas for Contribution
- 🐛 Bug fixes and improvements
- ✨ New features and enhancements
- 📚 Documentation improvements
- 🌍 Localization and i18n
- 🎨 UI/UX improvements
- 📱 Platform-specific optimizations

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Built with ❤️ using [GetX](https://pub.dev/packages/get)
- Inspired by Material Design principles
- Community feedback and contributions

---

## 👨‍💻 Author

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/EnadAbulawi">
        <img src="https://github.com/EnadAbulawi.png" width="100px;" alt="Enad Abulawi"/>
        <br />
        <sub><b>Enad Abulawi</b></sub>
      </a>
      <br />
      <sub>🇵🇸 Palestine</sub>
    </td>
  </tr>
</table>

**Developed with ❤️ by [Enad Abulawi](https://github.com/EnadAbulawi)**

- 📧 Email: [؟noorazkar7@gmail.com](mailto:؟noorazkar7@gmail.com)
- 💼 LinkedIn: [Enad Abulawi](https://linkedin.com/in/enadabulawi1)


---

## ⭐ Support

If you found this package useful, please consider:

- ⭐ **Starring** the repository
- 👍 **Liking** the package on [pub.dev](https://pub.dev/packages/snackly)
- 🐛 **Reporting** bugs and issues
- 💡 **Suggesting** new features
- 🔄 **Sharing** with other developers

<p align="center">
  <strong>Made with ❤️ for the Flutter community</strong>
</p>

---

<p align="center">
  <img src="https://raw.githubusercontent.com/EnadAbulawi/snackly/main/assets/footer.png" width="100%" alt="Snackly Footer" />
</p>