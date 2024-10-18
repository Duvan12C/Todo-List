class Ingresostarea {
  int? ingresosTareaId;
  int tipoIngresoId;
  String descripcion;
  double monto;
  DateTime fechaTransaccion;
  DateTime fechaRegistro;
  String? tipoIngresoNombre; // Nuevo campo para el nombre del tipo de ingreso

  Ingresostarea({
    this.ingresosTareaId,
    required this.tipoIngresoId,
    required this.descripcion,
    required this.monto,
    required this.fechaTransaccion,
    required this.fechaRegistro,
    this.tipoIngresoNombre, // Campo opcional en el constructor
  });

  // Convertir a Map para insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'ingresosTareaId': ingresosTareaId,
      'tipoIngresoId': tipoIngresoId,
      'descripcion': descripcion,
      'monto': monto,
      'fechaTransaccion': fechaTransaccion.toIso8601String(),
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }

  // Crear desde Map
  factory Ingresostarea.fromMap(Map<String, dynamic> map) {
    return Ingresostarea(
      ingresosTareaId: map['ingresosTareaId'],
      tipoIngresoId: map['tipoIngresoId'],
      descripcion: map['descripcion'],
      monto: map['monto'],
      fechaTransaccion: DateTime.parse(map['fechaTransaccion']),
      fechaRegistro: DateTime.parse(map['fechaRegistro']),
      tipoIngresoNombre: map['tipoIngresoNombre'], // Asignar el nombre del tipo de ingreso
    );
  }
}
