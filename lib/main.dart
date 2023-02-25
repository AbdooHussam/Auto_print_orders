import 'package:auto_print_app/Home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


Future<void> main() async {
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
    @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeScreen(),
    );
  }

}
