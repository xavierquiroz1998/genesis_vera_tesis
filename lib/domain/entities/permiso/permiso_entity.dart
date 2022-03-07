import 'package:equatable/equatable.dart';
import 'package:genesis_vera_tesis/data/models/permiso/permiso.dart';
import 'package:genesis_vera_tesis/data/models/proyecto/proyecto.dart';

// ignore: must_be_immutable
class PermisosEntity extends Equatable {
  PermisosEntity(
      {this.id = 0,
      this.idProyecto = 0,
      this.idUsuario = 0,
      this.creacion = 0,
      this.actualizar = 0,
      this.anular = 0,
      this.consulta = 0,
      this.estado = true,
      this.usuario,
      this.proyecto});

  int id;
  int idProyecto;
  int idUsuario;
  int creacion;
  int actualizar;
  int anular;
  int consulta;
  bool estado;
  Usuario? usuario;
  ProyectoModelo? proyecto;

  @override
  List<Object?> get props => [
        id,
        idProyecto,
        idUsuario,
        creacion,
        actualizar,
        anular,
        consulta,
        estado
      ];
}
