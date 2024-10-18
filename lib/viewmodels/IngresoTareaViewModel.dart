import 'package:flutter/material.dart';
import 'package:to_list_app/database_helper.dart';
import 'package:to_list_app/models/IngresosTarea.dart';
import 'package:to_list_app/models/TipoIngreso.dart';

class IngresoTareaViewModel extends ChangeNotifier {
  
  List<TipoIngreso> _tipoIngresos = [];
  TipoIngreso? _tipoSeleccionado;

  List<TipoIngreso> get tipoIngresos => _tipoIngresos;
  TipoIngreso? get tipoSeleccionado => _tipoSeleccionado;

  // Cargar catálogo de tipoIngreso para el dropdown
  Future<void> cargarTipoIngresos() async {
    _tipoIngresos = await DatabaseHelper().getAllTipoIngresos();
    notifyListeners();
  }

  void seleccionarTipoIngreso(TipoIngreso? tipo) {
    _tipoSeleccionado = tipo;
    notifyListeners();
  }

  // Guardar un nuevo ingresoTarea
  Future<void> agregarIngresoTarea(Ingresostarea nuevoIngreso) async {
    await DatabaseHelper().insertIngresoTarea(nuevoIngreso);
  }
}
