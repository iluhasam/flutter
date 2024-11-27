import 'package:flutter/material.dart';

import 'appointments/appointments.dart';
import 'custom_tab.dart';
import 'notes/notes.dart';
import 'tasks/tasks.dart';
import 'contacts/contacts.dart';

class TabItem {
  String title;
  final IconData icon;
  final Widget Function() screenBuilder;

  TabItem({required this.title, required this.icon, required this.screenBuilder});
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Переменная для отслеживания текущей темы
  bool _isDarkMode = true;

  // Функция для переключения темы
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Менеджер Flutter',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      home: MainScreen(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  MainScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Динамический список вкладок
  final List<TabItem> _tabs = [
    TabItem(
      title: 'Мероприятия',
      icon: Icons.event,
      screenBuilder: () => AppointmentsScreen(),
    ),
    TabItem(
      title: 'Заметки',
      icon: Icons.note,
      screenBuilder: () => NotesScreen(),
    ),
    TabItem(
      title: 'Задачи',
      icon: Icons.task,
      screenBuilder: () => TasksScreen(),
    ),
    TabItem(
      title: 'Контакты',
      icon: Icons.contact_phone,
      screenBuilder: () => ContactsScreen(),
    ),
  ];

  // Функция для добавления новой вкладки
  void _addTab() {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Создать новую вкладку'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Введите название вкладки'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _tabs.add(
                  TabItem(
                    title: nameController.text.isNotEmpty
                        ? nameController.text
                        : 'New Tab ${_tabs.length + 1}',
                    icon: Icons.folder,
                    screenBuilder: () => CustomTabScreen(),
                  ),
                );
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
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Менеджер'),
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: () {
                widget.toggleTheme();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _addTab, // Добавление новой вкладки
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs
                .map((tab) => Tab(
              icon: Icon(tab.icon),
              text: tab.title,
            ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _tabs.map((tab) => tab.screenBuilder()).toList(),
        ),
      ),
    );
  }
}
