import 'dart:convert';

class ModelMovimiento {
  ModelMovimiento({
    this.id = 0,
    this.idProducto = 0,
    this.codigo = "",
  });

  int id;
  int idProducto;
  String codigo;

  factory ModelMovimiento.fromJson(String str) =>
      ModelMovimiento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelMovimiento.fromMap(Map<String, dynamic> json) => ModelMovimiento(
        id: json["id"],
        idProducto: json["idProducto"],
        codigo: json["codigo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idProducto": idProducto,
        "codigo": codigo,
      };
}
