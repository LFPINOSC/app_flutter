class Cliente {
  String cedula;
  String nombre;
  String apellido;
  String email;
  String? fotoPath;

  Cliente({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.email,
    this.fotoPath,
  });
  Map<String, dynamic> toMap() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'fotoPath': fotoPath,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      cedula: map['cedula'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      email: map['email'],
      fotoPath: map['fotoPath'],
    );
  }
}
