import 'dart:convert';

class UnidadMedida {
  int? id;
  String? codigo;
  String? descripcion;
  String? estado;
  String? adicional;
  UnidadMedida({
    this.id,
    this.codigo,
    this.descripcion,
    this.estado,
    this.adicional,
  });

  UnidadMedida copyWith({
    int? id,
    String? codigo,
    String? descripcion,
    String? estado,
    String? adicional,
  }) {
    return UnidadMedida(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descripcion: descripcion ?? this.descripcion,
      estado: estado ?? this.estado,
      adicional: adicional ?? this.adicional,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'estado': estado,
      'adicional': adicional,
    };
  }

  factory UnidadMedida.fromMap(Map<String, dynamic> map) {
    return UnidadMedida(
      id: map['id']?.toInt(),
      codigo: map['codigo'],
      descripcion: map['descripcion'],
      estado: map['estado'],
      adicional: map['adicional'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UnidadMedida.fromJson(String source) =>
      UnidadMedida.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UnidadMedida(id: $id, codigo: $codigo, descripcion: $descripcion, estado: $estado, adicional: $adicional)';
  }
}
