import 'package:flutter/material.dart';
import 'package:wiegeth/vista/vista_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima Widget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clima Widget'),
        ),
        body: VistaInicio(), // Aquí usamos la vista de widgets.
      ),
    );
  }
}
