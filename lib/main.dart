import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_list_app/view/CrearIngresoScreen.dart';
import 'package:to_list_app/view/HomeScreen.dart'; 
import 'package:to_list_app/view/ResumenScreen.dart'; // Agregar la pantalla ResumenScreen
import 'package:to_list_app/viewmodels/HomeViewModel.dart';
import 'package:to_list_app/viewmodels/IngresoTareaViewModel.dart';
import 'package:to_list_app/viewmodels/ResumenViewModel.dart'; // Agregar el ViewModel ResumenViewModel

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IngresoTareaViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()), // Asegúrate de que HomeViewModel esté aquí
        ChangeNotifierProvider(create: (_) => ResumenViewModel()), // Agregar el ResumenViewModel
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To List App',
      home: HomeAndCrearIngresoScreen(),
    );
  }
}

class HomeAndCrearIngresoScreen extends StatefulWidget {
  const HomeAndCrearIngresoScreen({Key? key}) : super(key: key);

  @override
  _HomeAndCrearIngresoScreenState createState() =>
      _HomeAndCrearIngresoScreenState();
}



class _HomeAndCrearIngresoScreenState extends State<HomeAndCrearIngresoScreen> {
  int _selectedIndex = 0;

  // Lista de las vistas que se alternarán con el BottomNavigationBar
  final List<Widget> _screens = [
    HomeScreen(), // Pantalla que muestra la lista de ingresos
    CrearIngresoScreen(), // Pantalla que permite crear ingresos
    ResumenScreen(), // Pantalla que muestra el resumen
  ];

void _onItemTapped(int index) {
  if (index >= 0 && index < _screens.length) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Cambia la vista según el índice seleccionado
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista de Ingresos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crear Ingreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Resumen', // Opción para ir al Resumen
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black87, // Fondo oscuro
        selectedItemColor: Colors.white, // Color para el ítem seleccionado
        unselectedItemColor: Colors.grey, // Color para los ítems no seleccionados
        type: BottomNavigationBarType.fixed, // Fijar la barra en su posición
        selectedLabelStyle: const TextStyle(
          fontSize: 14, // Tamaño de la fuente para los textos seleccionados
          fontWeight: FontWeight.bold, // Negrita para el texto seleccionado
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12, // Tamaño de la fuente para los textos no seleccionados
        ),
      ),
    );
  }
}