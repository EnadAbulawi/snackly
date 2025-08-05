import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snackify/snackly_custom_snackbar.dart';

void main() {
  runApp(GetMaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Snackbar Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Snackly.show(
              title: 'تم',
              message: 'تمت العملية بنجاح!',
              type: SnackbarType.success,
              position: SnackbarPosition.top,
            );
          },
          child: Text('عرض Snackbar'),
        ),
      ),
    );
  }
}
