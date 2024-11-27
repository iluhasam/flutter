import 'package:scoped_model/scoped_model.dart';

class AppointmentsModel extends Model {
  static final AppointmentsModel _instance = AppointmentsModel._internal();
  factory AppointmentsModel() => _instance;
  AppointmentsModel._internal();

  int stackIndex = 0;

  void setStackIndex(int index) {
    stackIndex = index;
    notifyListeners();
  }
}
