import 'dart:convert';

class ModelMovimiento {
  ModelMovimiento({
    this.id = 0,
    this.idProducto = 0,
    this.total = 0,
    this.actual = 0,
    this.precio = 0,
    this.codigo = "",
  });

  int id;
  int idProducto;
  String codigo;
  int total;
  int actual;
  double precio;

  factory ModelMovimiento.fromJson(String str) =>
      ModelMovimiento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelMovimiento.fromMap(Map<String, dynamic> json) => ModelMovimiento(
        id: json["id"],
        idProducto: json["idProducto"],
        total: json["total"],
        actual: json["actual"],
        codigo: json["codigo"],
        precio: json["precio"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idProducto": idProducto,
        "codigo": codigo,
        "total": total,
        "actual": actual,
        "precio": precio,
      };
}
