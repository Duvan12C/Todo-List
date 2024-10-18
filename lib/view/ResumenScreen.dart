import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:to_list_app/viewmodels/ResumenViewModel.dart';

class ResumenScreen extends StatefulWidget {
  const ResumenScreen({Key? key}) : super(key: key);

  @override
  _ResumenScreenState createState() => _ResumenScreenState();
}

class _ResumenScreenState extends State<ResumenScreen> {
  @override
  void initState() {
    super.initState();
    // Calcular los totales de ingresos y gastos al cargar la pantalla
    Future.microtask(() =>
        Provider.of<ResumenViewModel>(context, listen: false)
            .calcularTotalIngresosYGastos());
  }

  @override
  Widget build(BuildContext context) {
    final resumenViewModel = Provider.of<ResumenViewModel>(context);

    // Balance actual = Total Ingresos - Total Gastos
    final balanceActual =
        resumenViewModel.totalIngresos - resumenViewModel.totalGastos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Transacciones'),
        backgroundColor: Colors.black87, // Fondo oscuro
        titleTextStyle: const TextStyle(
          color: Colors.white, // Texto en blanco
          fontSize: 20, // Tamaño de la fuente
          fontWeight: FontWeight.bold, // Negrita (opcional)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostrar el resumen de ingresos, gastos y balance
            _buildResumen(resumenViewModel.totalIngresos,
                resumenViewModel.totalGastos, balanceActual),
            const SizedBox(height: 30),

            // Mostrar el gráfico de torta
            Expanded(
              child: Center(
                child: _buildPieChart(resumenViewModel.totalIngresos,
                    resumenViewModel.totalGastos),
              ),
            ),
            
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  // Método para construir el resumen superior
Widget _buildResumen(
    double totalIngresos, double totalGastos, double balanceActual) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // Cambia la sombra
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total de Ingresos: \$${totalIngresos.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
        const SizedBox(height: 10),
        Text('Total de Gastos: \$${totalGastos.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
        const SizedBox(height: 10),
        Text('Balance Actual: \$${balanceActual.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: balanceActual >= 0 ? Colors.green : Colors.red)),
      ],
    ),
  );
}


  // Método para construir el gráfico de torta (PieChart)
  Widget _buildPieChart(double totalIngresos, double totalGastos) {
    return SfCircularChart(
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        DoughnutSeries<_ChartData, String>(
          dataSource: <_ChartData>[
            _ChartData('Ingresos', totalIngresos, Colors.green),
            _ChartData('Gastos', totalGastos, Colors.red),
          ],
          xValueMapper: (_ChartData data, _) => data.label,
          yValueMapper: (_ChartData data, _) => data.value,
          pointColorMapper: (_ChartData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

// Clase para estructurar los datos del gráfico
class _ChartData {
  _ChartData(this.label, this.value, this.color);

  final String label;
  final double value;
  final Color color;
}
