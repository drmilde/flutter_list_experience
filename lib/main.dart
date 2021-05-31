import 'package:flutter/material.dart';
import 'package:flutter_list_experience/screens/benzin_preis_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BenzinPreisListScreen(),
    );
  }
}
