import 'dart:convert';

class Productos {
  int? id;
  String? descripcion;
  String? codigo;
  String? tipoProdcuto;
  int? stock;
  var precio;

  Productos({
    this.id,
    this.descripcion,
    this.codigo,
    this.stock,
    this.tipoProdcuto,
    required this.precio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descripcion': descripcion,
      'codigo': codigo,
      'stock': stock,
      'tipo': tipoProdcuto,
      'precio': precio.toMap(),
    };
  }

  // factory Productos.fromMap(Map<String, dynamic> map) {
  //   return Productos(
  //     id: map['id'] != null ? map['id'] : null,
  //     descripcion: map['descripcion'] != null ? map['descripcion'] : null,
  //     codigo: map['codigo'] != null ? map['codigo'] : null,
  //     stock: map['stock'] != null ? map['stock'] : null,
  //     precio: var.fromMap(map['precio']),
  //   );
  // }

  String toJson() => json.encode(toMap());

  //factory Productos.fromJson(String source) => Productos.fromMap(json.decode(source));
}
