import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppointmentsDBWorker {
  static final AppointmentsDBWorker _instance = AppointmentsDBWorker._internal();
  factory AppointmentsDBWorker() => _instance;
  AppointmentsDBWorker._internal();

  Future<Database> get _db async {
    final path = join(await getDatabasesPath(), 'appointments.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE appointments(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertAppointment(Map<String, dynamic> appointment) async {
    final db = await _db;
    await db.insert('appointments', appointment, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await _db;
    return db.query('appointments');
  }
}
