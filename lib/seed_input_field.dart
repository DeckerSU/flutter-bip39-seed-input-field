// lib/seed_input_field.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SeedInputField extends StatefulWidget {
  @override
  _SeedInputFieldState createState() => _SeedInputFieldState();
}

class _SeedInputFieldState extends State<SeedInputField> {
  final TextEditingController _controller = TextEditingController();
  List<String> _bip39Words = [];
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _loadBip39Words();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadBip39Words() async {
    final String data = await rootBundle.loadString('assets/bip39_words.txt');
    setState(() {
      _bip39Words = data.split('\n');
    });
  }

  void _onTextChanged() {
    final text = _controller.text;
    final words = text.split(' ');
    final lastWord = words.isNotEmpty ? words.last : '';
    if (lastWord.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    final matches = _bip39Words.where((word) => word.startsWith(lastWord)).toList();
    setState(() {
      _suggestions = matches.take(10).toList(); // Limit to 10 suggestions
    });
  }

  void _insertSuggestion(String suggestion) {
    final text = _controller.text;
    final words = text.trim().split(' ');
    if (words.isNotEmpty) {
      words.removeLast();
    }
    words.add(suggestion);
    final newText = words.join(' ') + ' ';
    setState(() {
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      );
      _suggestions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Enter your seed phrase',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _suggestions.map((suggestion) {
            return GestureDetector(
              onTap: () => _insertSuggestion(suggestion),
              child: Chip(
                backgroundColor: Colors.blue,
                label: Text(
                  suggestion,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
