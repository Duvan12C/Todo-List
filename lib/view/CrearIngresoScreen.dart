import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necesario para los inputFormatters
import 'package:to_list_app/models/IngresosTarea.dart';
import 'package:to_list_app/models/TipoIngreso.dart';
import 'package:to_list_app/viewmodels/IngresoTareaViewModel.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Importa el paquete de AwesomeDialog

class CrearIngresoScreen extends StatefulWidget {
  const CrearIngresoScreen({super.key});

  @override
  _CrearIngresoScreenState createState() => _CrearIngresoScreenState();
}

class _CrearIngresoScreenState extends State<CrearIngresoScreen> {
  final _formKey = GlobalKey<FormState>(); // Para validar los campos del formulario
  final _montoController = TextEditingController(); // Controlador para el monto
  final _descripcionController = TextEditingController(); // Controlador para la descripción
  DateTime _fechaTransaccion = DateTime.now(); // Fecha de transacción inicial

  @override
  void initState() {
    super.initState();
    // Llamamos a cargarTipoIngresos al inicio
    Future.microtask(() =>
        Provider.of<IngresoTareaViewModel>(context, listen: false)
            .cargarTipoIngresos());
  }

  // Método para mostrar el DatePicker para la fecha de transacción
  Future<void> _selectFechaTransaccion(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaTransaccion,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Cambia el color de fondo principal
              onPrimary: Colors.white, // Cambia el color del texto en el botón superior
              onSurface: Colors.black, // Cambia el color del texto en general
            ),
            dialogBackgroundColor: Colors.white, // Cambia el color de fondo del diálogo
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _fechaTransaccion) {
      setState(() {
        _fechaTransaccion = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<IngresoTareaViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco puro
      appBar: AppBar(
        title: const Text('Crear Ingreso'),
        backgroundColor: Colors.black87, // Fondo oscuro
        titleTextStyle: const TextStyle(
          color: Colors.white, // Texto en blanco
          fontSize: 20, // Tamaño de la fuente
          fontWeight: FontWeight.bold, // Negrita (opcional)
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20), // Margen del contenedor
          padding: const EdgeInsets.all(20), // Espaciado dentro del contenedor
          decoration: BoxDecoration(
            color: Colors.grey[200], // Color más oscuro que el blanco (gris claro)
            borderRadius: BorderRadius.circular(15), // Bordes redondeados
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // Cambia la sombra
              ),
            ],
          ),
          child: Form(
            key: _formKey, // Clave del formulario
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown para seleccionar el tipo de ingreso
                const Row(
                  children: [
                    Text(
                      "Tipo de Ingreso",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                viewModel.tipoIngresos.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : DropdownButtonFormField<TipoIngreso>(
                        value: viewModel.tipoSeleccionado,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: viewModel.tipoIngresos.map((tipo) {
                          return DropdownMenuItem<TipoIngreso>(
                            value: tipo,
                            child: Text(tipo.nombre),
                          );
                        }).toList(),
                        onChanged: (nuevoTipo) {
                          viewModel.seleccionarTipoIngreso(nuevoTipo!);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white, // Fondo blanco para el input
                          filled: true, // Hacer que el fondo blanco se vea
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.lightBlueAccent, width: 2), // Color del borde azul claro
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        validator: (value) => value == null
                            ? 'Por favor seleccione un tipo de ingreso'
                            : null, // Mensaje de validación
                      ),
                const SizedBox(height: 20),

                // Campo para ingresar el monto
                const Row(
                  children: [
                    Text(
                      "Monto",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _montoController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Ingrese el monto',
                    fillColor: Colors.white, // Fondo blanco para el input
                    filled: true, // Hacer que el fondo blanco se vea
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.lightBlueAccent, width: 2), // Color del borde azul claro
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]*[.]?[0-9]*$')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un monto';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Ingrese un monto válido';
                    }
                    return null;
                  }, // Mensaje de validación
                ),
                const SizedBox(height: 20),

                // Campo para ingresar la descripción
                const Row(
                  children: [
                    Text(
                      "Descripción",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descripcionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la descripción',
                    fillColor: Colors.white, // Fondo blanco para el input
                    filled: true, // Hacer que el fondo blanco se vea
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.lightBlueAccent, width: 2), // Color del borde azul claro
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  }, // Mensaje de validación
                ),
                const SizedBox(height: 20),

                // Campo para seleccionar la fecha de transacción
                const Text(
                  "Fecha de Transacción",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "${_fechaTransaccion.toLocal()}".split(' ')[0],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () => _selectFechaTransaccion(context),
                      child: const Text('Seleccionar Fecha'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Botón para agregar el ingreso
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final descripcion = _descripcionController.text;
                        final monto = double.parse(_montoController.text);

                        final nuevoIngreso = Ingresostarea(
                          tipoIngresoId: viewModel.tipoSeleccionado!.tipoIngresoId!,
                          descripcion: descripcion,
                          monto: monto,
                          fechaTransaccion: _fechaTransaccion,
                          fechaRegistro: DateTime.now(), // Fecha de registro: hoy
                        );

                        viewModel.agregarIngresoTarea(nuevoIngreso);

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.scale,
                          title: '¡Éxito!',
                          desc: 'Ingreso agregado correctamente.',
                          btnOkOnPress: () {},
                        ).show();

                        // Limpiar los campos después de agregar el ingreso
                        _montoController.clear();
                        _descripcionController.clear();
                        viewModel.seleccionarTipoIngreso(null); // Limpiar la selección
                        setState(() {
                          _fechaTransaccion = DateTime.now();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green, // Botón verde
                    ),
                    child: const Text(
                      'Agregar Ingreso o gasto',
                      style: TextStyle(color: Colors.white), // Cambiar el color del texto a blanco
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _montoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }
}
