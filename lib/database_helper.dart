import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_list_app/models/IngresosTarea.dart';
import 'package:to_list_app/models/TipoIngreso.dart'; 

class DatabaseHelper {
  // Crear una instancia única de la base de datos (Singleton pattern)
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Obtener la ruta correcta para la base de datos en cada plataforma
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'to_do_list.db');

    // Abrir la base de datos, crearla si no existe
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  // Método para crear las tablas
  Future _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tipoIngresos(
        tipoIngresoId INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        fechaRegistro DATETIME

      )
    ''');

       await db.execute('''
      CREATE TABLE ingresosTarea(
        ingresosTareaId INTEGER PRIMARY KEY AUTOINCREMENT,
        tipoIngresoId INTEGER,
        descripcion TEXT,
        monto REAL,
        fechaTransaccion DATETIME,
        fechaRegistro DATETIME,
        FOREIGN KEY (tipoIngresoId) REFERENCES tipoIngresos(tipoIngresoId)
      )
    ''');

      // Insertar los valores 'Ingreso' y 'Gasto' en la tabla tipoIngresos
  await db.insert('tipoIngresos', {
    'nombre': 'Ingreso',
    'fechaRegistro': DateTime.now().toIso8601String()
  });

  await db.insert('tipoIngresos', {
    'nombre': 'Gasto',
    'fechaRegistro': DateTime.now().toIso8601String()
  });
  }

  

  Future<List<Ingresostarea>> getAllIngresosTarea() async {
  final db = await database;

  // Query con JOIN para obtener el nombre del tipo de ingreso
  final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT ingresosTarea.*, tipoIngresos.nombre AS tipoIngresoNombre 
    FROM ingresosTarea
    JOIN tipoIngresos ON ingresosTarea.tipoIngresoId = tipoIngresos.tipoIngresoId
  ''');

  // Convertir el resultado a objetos Ingresostarea
  return List.generate(result.length, (i) {
    var ingreso = Ingresostarea.fromMap(result[i]);
    ingreso.tipoIngresoNombre = result[i]['tipoIngresoNombre']; // Asignar el nombre del tipo de ingreso
    return ingreso;
  });
}


  Future<List<TipoIngreso>> getAllTipoIngresos() async {
    final db = await database;
    final List<Map<String, dynamic>> resultTipoIngresos = await db.query('tipoIngresos');

    return List.generate(resultTipoIngresos.length, (i) {
      return TipoIngreso.fromMap(resultTipoIngresos[i]);
    });
  }

  Future<int> insertIngresoTarea(Ingresostarea nuevoIngreso) async {
    final db = await database;
    return await db.insert('ingresosTarea', nuevoIngreso.toMap());
  }


  Future<void> deleteIngreso(int ingresoTareaId) async {
  final db = await database;

  // Eliminar el registro por su ID
  await db.delete(
    'ingresosTarea',
    where: 'ingresosTareaId = ?',
    whereArgs: [ingresoTareaId],
  );
}


}
