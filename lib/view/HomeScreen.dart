import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_list_app/viewmodels/HomeViewModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Importa el paquete de AwesomeDialog

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ingresos'),
        backgroundColor: Colors.black87, // Fondo oscuro
        titleTextStyle: const TextStyle(
          color: Colors.white, // Texto en blanco
          fontSize: 20, // Tamaño de la fuente
          fontWeight: FontWeight.bold, // Negrita (opcional)
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          // Cargar los ingresos cuando se construya la vista
          viewModel.cargarIngresosTarea();

          return viewModel.ingresosTarea.isEmpty
              ? const Center(child: Text('No hay ingresos registrados'))
              : ListView.builder(
                  itemCount: viewModel.ingresosTarea.length,
                  itemBuilder: (context, index) {
                    final ingreso = viewModel.ingresosTarea[index];

                    // Determinar el color según el tipo de ingreso
                    Color colorLinea = ingreso.tipoIngresoNombre == 'Ingreso'
                        ? Colors.green
                        : Colors.red;

                    return Card(
                      elevation: 4,
                      color: Colors.grey[200], // Sombras para la tarjeta
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(
                          10), // Margen alrededor de la tarjeta
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10.0),
                                child: Text(
                                  '${ingreso.descripcion} (${ingreso.tipoIngresoNombre})',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                    'Monto: \$${ingreso.monto.toStringAsFixed(2)}'),
                              ),
                              const SizedBox(height: 10),
                              // Colocamos la fecha en la parte inferior derecha
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16.0, bottom: 10.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Fecha: ${ingreso.fechaTransaccion.toLocal().toString().split(' ')[0]}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ),
                              // Barra de color en la parte inferior de la tarjeta
                              Container(
                                width: double.infinity, // Ocupar todo el ancho de la tarjeta
                                height: 5, // Altura de la barra
                                decoration: BoxDecoration(
                                  color: colorLinea, // Verde si es Ingreso, rojo si es Gasto
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Botón de eliminación más pequeño en la esquina superior derecha
                          Positioned(
                            top: 5,
                            right: 5,
                            child: IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 18,
                                  color: Colors.red), // Botón más pequeño
                              onPressed: () {
                                // Mostrar el diálogo de confirmación usando AwesomeDialog
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.bottomSlide,
                                  title: 'Eliminar Ingreso',
                                  desc:
                                      '¿Estás seguro de que deseas eliminar este ingreso?',
                                  btnCancelOnPress: () {
                                    // Cierra el diálogo sin hacer nada
                                  },
                                  btnOkOnPress: () {
                                    // Elimina el ingreso si confirma
                                    viewModel.eliminarIngreso(ingreso.ingresosTareaId!);
                                    
                                    // Muestra un SnackBar de confirmación
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:  Text('Ingreso eliminado correctamente'),
                                        duration:  Duration(seconds: 2),
                                        backgroundColor: Colors.green, // Puedes cambiar el color
                                      ),
                                    );
                                  },
                                ).show();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
