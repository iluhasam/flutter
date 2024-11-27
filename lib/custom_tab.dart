import 'package:flutter/material.dart';

class CustomTabScreen extends StatefulWidget {
  @override
  _CustomTabScreenState createState() => _CustomTabScreenState();
}

class _CustomTabScreenState extends State<CustomTabScreen> {
  final List<String> _entries = [];

  void _addEntry() {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Новая запись'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(labelText: 'Введите текст'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (textController.text.isNotEmpty) {
                  _entries.add(textController.text);
                }
              });
              Navigator.pop(context);
            },
            child: Text('Добавить'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_entries[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: Icon(Icons.add),
      ),
    );
  }
}
