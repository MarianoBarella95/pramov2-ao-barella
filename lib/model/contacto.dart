class Contacto {
  int? id;
  String nombre;
  String apellido;
  String telefono;
  String domicilio;
  String genero;
  String? email;
  String? fechaNacimiento;

  Contacto({this.id, required this.nombre, required this.apellido, required this.telefono, required this.domicilio, required this.genero, this.email, this.fechaNacimiento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'domicilio': domicilio,
      'genero': genero,
      'email': email,
      'fechaNacimiento': fechaNacimiento,
    };
  }

  Contacto copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? telefono,
    String? domicilio,
    String? genero,
    String? email,
    String? fechaNacimiento,
  }) {
    return Contacto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      telefono: telefono ?? this.telefono,
      domicilio: domicilio ?? this.domicilio,
      genero: genero ?? this.genero,
      email: email ?? this.email,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    );
  }

  @override
  String toString() {
    return 'Contacto{id: $id, nombre: $nombre, apellido: $apellido, telefono: $telefono, domicilio: $domicilio, genero: $genero, email: $email, fechaNacimiento: $fechaNacimiento}';
  }

  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      id: json['id'],
      nombre: json['nombre']?.toString() ?? '',
      apellido: json['apellido']?.toString() ?? '',
      telefono: json['telefono']?.toString() ?? '',
      domicilio: json['domicilio']?.toString() ?? '',
      genero: json['genero']?.toString() ?? '',
      email: json['email']?.toString(),
      fechaNacimiento: json['fechaNacimiento']?.toString(),
    );
  }
}