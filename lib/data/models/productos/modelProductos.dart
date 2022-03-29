import 'dart:convert';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import '../../../domain/entities/Proveedores/Proveedores.dart';
import '../grupo/grupo_modelo.dart';

class ModelProducto extends Productos {
  ModelProducto({
    this.id = 0,
    this.referencia = "",
    this.nombre = "",
    this.detalle = "",
    this.precio = 0,
    this.cantidad = 0,
    this.idUnidad = 0,
    this.pedido = 0,
    this.idProveedor = 0,
    this.idGrupo = 0,
    this.estado = false,
    // this.proveedor,
    // this.unidad,
    // this.grupo,
  }) : super(
            id: id,
            referencia: referencia,
            nombre: nombre,
            detalle: detalle,
            precio: precio,
            cantidad: cantidad,
            pedido: pedido,
            idUnidad: idUnidad,
            idProveedor: idProveedor,
            idGrupo: idGrupo,
            estado: estado);

  int id;
  String referencia;
  String nombre;
  String detalle;
  double precio;
  double cantidad;
  int pedido;
  int idUnidad;
  int idProveedor;
  int idGrupo;
  bool estado;
  //final Proveedor? proveedor;
  //final Unidad? unidad;
  //final GruposModelo? grupo;

  factory ModelProducto.fromJson(String str) =>
      ModelProducto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelProducto.fromMap(Map<String, dynamic> json) => ModelProducto(
        id: json["id"],
        referencia: json["referencia"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        precio: json["precio"].toDouble(),
        cantidad: json["cantidad"].toDouble(),
        idUnidad: json["idUnidad"],
        pedido: json["pedido"],
        idProveedor: json["idProveedor"],
        idGrupo: json["idGrupo"],
        estado: json["estado"],
        // proveedor: Proveedor.fromMap(json["Proveedor"]),
        // unidad: Unidad.fromMap(json["Unidad"]),
        // grupo: GruposModelo.fromMap(json["Grupo"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "referencia": referencia,
        "nombre": nombre,
        "detalle": detalle,
        "precio": precio,
        "cantidad": cantidad,
        "pedido": pedido,
        "idUnidad": idUnidad,
        "idProveedor": idProveedor,
        "idGrupo": idGrupo,
        "estado": estado,
        // "Proveedor": proveedor!.toMap(),
        // "Unidad": unidad!.toMap(),
        // "Grupo": grupo!.toMap(),
      };
}

class Proveedor extends ProveedoresEntity {
  Proveedor({
    this.id = 0,
    this.identificacion = "",
    this.nombre = "",
    this.correo = "",
    this.telefono = "",
    this.direccion = "",
    this.estado = false,
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
