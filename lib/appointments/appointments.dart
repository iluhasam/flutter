import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<String> _appointments = [];

  void _addAppointment() {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Новое мероприятие'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(labelText: 'Описание мероприятия'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (textController.text.isNotEmpty) {
                  _appointments.add(textController.text);
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
        itemCount: _appointments.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_appointments[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAppointment,
        child: Icon(Icons.add),
      ),
    );
  }
}
