class Contacto {
  int? id;
  String nombre;
  String apellido;
  String telefono;
  String domicilio;
  String genero;

  Contacto({this.id ,required this.nombre, required this.apellido, required this.telefono, required this.domicilio, required this.genero});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'domicilio': domicilio,
      'genero': genero,
    };
  }

  Contacto copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? telefono,
    String? domicilio,
    String? genero,
  }) {
    return Contacto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      telefono: telefono ?? this.telefono,
      domicilio: domicilio ?? this.domicilio,
      genero: genero ?? this.genero,
    );
  }

  @override
  String toString() {
    return 'Contacto{id: $id, nombre: $nombre, apellido: $apellido, telefono: $telefono, domicilio: $domicilio, genero: $genero}';
  }
}