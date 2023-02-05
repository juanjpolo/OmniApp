import 'package:entrando_en_ambiente/src/models/Universidad.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../services/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  final _service = TodoService();
  bool isLoading = false;
  int _numeroEstudiantes = 0;
  List<Universidad> _universidad = [];
  List<Universidad> get universidad => _universidad;
  int get numeroEstudiantes => _numeroEstudiantes;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();
    _universidad = response;
    isLoading = false;
    notifyListeners();
  }

  void incrementX(int value) {
    _numeroEstudiantes = value;
    notifyListeners();
  }
}
