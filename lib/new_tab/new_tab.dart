import 'package:flutter/material.dart';

class NewTabScreen extends StatefulWidget {
  @override
  _NewTabScreenState createState() => _NewTabScreenState();
}

class _NewTabScreenState extends State<NewTabScreen> {
  final List<String> _entries = [];

  void _addEntry(String text) {
    setState(() {
      _entries.add(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _entries.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_entries[index]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(labelText: 'Добавить заметку'),
            onSubmitted: _addEntry,
          ),
        ),
      ],
    );
  }
}
