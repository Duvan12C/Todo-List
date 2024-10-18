import 'package:flutter/material.dart';
import 'package:to_list_app/database_helper.dart';
import 'package:to_list_app/models/IngresosTarea.dart';

class HomeViewModel extends ChangeNotifier {
  List<Ingresostarea> _ingresosTarea = [];

  List<Ingresostarea> get ingresosTarea => _ingresosTarea;

  Future<void> cargarIngresosTarea() async {
    _ingresosTarea = await DatabaseHelper().getAllIngresosTarea();
    notifyListeners();
  }


  // Método para eliminar un ingreso por su ID
  Future<void> eliminarIngreso(int ingresoTareaId) async {
    await DatabaseHelper().deleteIngreso(ingresoTareaId);
    await cargarIngresosTarea();  // Volver a cargar la lista después de eliminar
  }
}
