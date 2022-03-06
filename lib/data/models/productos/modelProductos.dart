import 'dart:convert';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class ModelProducto extends Productos {
  ModelProducto({
    required this.id,
    required this.referencia,
    required this.nombre,
    required this.detalle,
    required this.precio,
    required this.idUnidad,
    required this.idProveedor,
    required this.estado,
    required this.proveedor,
    required this.unidad,
  }) : super(
            id: id,
            referencia: referencia,
            nombre: nombre,
            detalle: detalle,
            precio: precio,
            idUnidad: idUnidad,
            idProveedor: idProveedor,
            estado: estado);

  final int id;
  final String referencia;
  final String nombre;
  final String detalle;
  final double precio;
  final int idUnidad;
  final int idProveedor;
  final bool estado;
  final Proveedor proveedor;
  final Unidad unidad;

  factory ModelProducto.fromJson(String str) =>
      ModelProducto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelProducto.fromMap(Map<String, dynamic> json) => ModelProducto(
        id: json["id"],
        referencia: json["referencia"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        precio: json["precio"].toDouble(),
        idUnidad: json["idUnidad"],
        idProveedor: json["idProveedor"],
        estado: json["estado"],
        proveedor: Proveedor.fromMap(json["Proveedor"]),
        unidad: Unidad.fromMap(json["Unidad"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "referencia": referencia,
        "nombre": nombre,
        "detalle": detalle,
        "precio": precio,
        "idUnidad": idUnidad,
        "idProveedor": idProveedor,
        "estado": estado,
        //"Proveedor": proveedor.toMap(),
        //"Unidad": unidad.toMap(),
      };
}

class Proveedor {
  Proveedor({
    required this.id,
    required this.identificacion,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.direccion,
    required this.estado,
  });

  int id;
  String identificacion;
  String nombre;
  String correo;
  String telefono;
  String direccion;
  bool estado;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        id: json["id"],
        identificacion: json["identificacion"],
        nombre: json["nombre"],
        correo: json["correo"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "identificacion": identificacion,
        "nombre": nombre,
        "correo": correo,
        "telefono": telefono,
        "direccion": direccion,
        "estado": estado,
      };
}

class Unidad {
  Unidad({
    required this.id,
    required this.codigo,
    required this.detalle,
    required this.estado,
  });

  int id;
  String codigo;
  String detalle;
  bool estado;

  factory Unidad.fromJson(String str) => Unidad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Unidad.fromMap(Map<String, dynamic> json) => Unidad(
        id: json["id"],
        codigo: json["codigo"],
        detalle: json["detalle"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
        "estado": estado,
      };
}
