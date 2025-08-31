import 'package:flutter/material.dart';
import 'package:snackly/snackly.dart';

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Snackly Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Snackly.show(
              context: context,
              title: 'نجاح',
              message: 'تمت العملية بنجاح ✅',
            );
          },
          child: Text('عرض Snackbar'),
        ),
      ),
    );
  }
}
