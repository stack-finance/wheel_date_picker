import 'package:flutter/material.dart';
import 'package:wheel_date_picker/wheel_date_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: WheelDatePickerSlider(
          onChanged: (_) {},
          config: PointerConfig(color: const Color(0xffcccad8)),
        ),
      ),
    );
  }
}
