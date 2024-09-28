// lib/main.dart

import 'package:flutter/material.dart';
import 'seed_input_field.dart'; // Import the SeedInputField

void main() {
  runApp(SeedEnterApp());
}

class SeedEnterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seed Enter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SeedPhrasePage(),
    );
  }
}

class SeedPhrasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore Wallet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SeedInputField(),
      ),
    );
  }
}
