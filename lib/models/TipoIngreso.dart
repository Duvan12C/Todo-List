class TipoIngreso {
  int? tipoIngresoId;
  String nombre;
  DateTime fechaRegistro;

  TipoIngreso({
    this.tipoIngresoId, 
    required this.nombre, 
    required this.fechaRegistro});

  // Convertir un TipoIngreso a un Map (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'tipoIngresoId': tipoIngresoId,
      'nombre': nombre,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }

  // Crear un TipoIngreso a partir de un Map (para leer desde la base de datos)
  factory TipoIngreso.fromMap(Map<String, dynamic> map) {
    return TipoIngreso(
      tipoIngresoId: map['tipoIngresoId'],
      nombre: map['nombre'],
      fechaRegistro: DateTime.parse(map['fechaRegistro']),
    );
  }
}
