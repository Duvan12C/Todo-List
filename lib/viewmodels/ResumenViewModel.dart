import 'package:flutter/material.dart';
import 'package:to_list_app/database_helper.dart';

class ResumenViewModel extends ChangeNotifier {
  double _totalIngresos = 0;
  double _totalGastos = 0;

  double get totalIngresos => _totalIngresos;
  double get totalGastos => _totalGastos;

  // Método para calcular la suma total de ingresos y gastos
  Future<void> calcularTotalIngresosYGastos() async {
    final db = await DatabaseHelper().database;

    // Consulta para sumar todos los montos de tipo 'Ingreso'
    final ingresosResult = await db.rawQuery('''
      SELECT SUM(it.monto) as total
      FROM ingresosTarea it
      JOIN tipoIngresos ti ON it.tipoIngresoId = ti.tipoIngresoId
      WHERE ti.nombre = 'Ingreso'
    ''');

    // Consulta para sumar todos los montos de tipo 'Gasto'
    final gastosResult = await db.rawQuery('''
      SELECT SUM(it.monto) as total
      FROM ingresosTarea it
      JOIN tipoIngresos ti ON it.tipoIngresoId = ti.tipoIngresoId
      WHERE ti.nombre = 'Gasto'
    ''');

    // Asignar los resultados a las variables privadas
    _totalIngresos = (ingresosResult.first['total'] != null) ? ingresosResult.first['total'] as double : 0.0;
    _totalGastos = (gastosResult.first['total'] != null) ? gastosResult.first['total'] as double : 0.0;

    // Notificar a las vistas que los datos han cambiado
    notifyListeners();
  }
}
