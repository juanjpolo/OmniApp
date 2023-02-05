import 'package:entrando_en_ambiente/src/models/Universidad.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../services/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  final _service = TodoService();
  bool isLoading = false;
  int _numeroEstudiantes = 0;
  List<Universidad> _universidades = [];
  List<Universidad> get universidades => _universidades;
  int get numeroEstudiantes => _numeroEstudiantes;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();
    _universidades = response;
    isLoading = false;
    notifyListeners();
  }

  void incrementX(int value) {
    _numeroEstudiantes = value;
    notifyListeners();
  }
}
