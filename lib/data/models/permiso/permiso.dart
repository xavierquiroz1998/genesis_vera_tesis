// To parse this JSON data, do
//
//     final permisoModelo = permisoModeloFromMap(jsonString);

import 'dart:convert';

import 'package:genesis_vera_tesis/data/models/proyecto/proyecto.dart';
import 'package:genesis_vera_tesis/domain/entities/permiso/permiso_entity.dart';

class PermisoModelo extends PermisosEntity {
  PermisoModelo({
    required this.id,
    required this.idProyecto,
    required this.idUsuario,
    required this.creacion,
    required this.actualizar,
    required this.anular,
    required this.consulta,
    required this.estado,
    required this.usuario,
    required this.proyecto,
  }) : super(
            id: id,
            idProyecto: idProyecto,
            idUsuario: idUsuario,
            creacion: creacion,
            actualizar: actualizar,
            anular: anular,
            consulta: consulta,
            estado: estado,
            usuario: usuario,
            proyecto: proyecto);

  int id;
  int idProyecto;
  int idUsuario;
  int creacion;
  int actualizar;
  int anular;
  int consulta;
  bool estado;
  final Usuario usuario;
  final ProyectoModelo proyecto;

  factory PermisoModelo.fromJson(String str) =>
      PermisoModelo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PermisoModelo.fromMap(Map<String, dynamic> json) => PermisoModelo(
        id: json["id"],
        idProyecto: json["idProyecto"],
        idUsuario: json["idUsuario"],
        creacion: json["creacion"],
        actualizar: json["actualizar"],
        anular: json["anular"],
        consulta: json["consulta"],
        estado: json["estado"],
        usuario: Usuario.fromMap(json["Usuario"]),
        proyecto: ProyectoModelo.fromMap(json["Proyecto"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idProyecto": idProyecto,
        "idUsuario": idUsuario,
        "creacion": creacion,
        "actualizar": actualizar,
        "anular": anular,
        "consulta": consulta,
        "estado": estado,
        "Usuario": usuario.toMap(),
        "Proyecto": proyecto.toMap(),
      };
}

class Usuario {
  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.clave,
    required this.estado,
    required this.expiracion,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nombre;
  String email;
  String clave;
  bool estado;
  DateTime expiracion;
  DateTime createdAt;
  DateTime updatedAt;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        clave: json["clave"],
        estado: json["estado"],
        expiracion: DateTime.parse(json["expiracion"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "clave": clave,
        "estado": estado,
        "expiracion": expiracion.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
