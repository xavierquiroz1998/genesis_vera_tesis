import 'package:equatable/equatable.dart';
import 'package:genesis_vera_tesis/domain/entities/registro/entityRegistroDetaller.dart';

class EntityRegistro extends Equatable {
  EntityRegistro({
    this.id = 0,
    this.idTipo = 0,
    this.detalle = "",
    this.estado = false,
    this.referencia = 0,
    this.cliente = "",
    this.fecha = "",
    this.createdAt = "",
    this.idSecundario = 0,
  });
  int id;
  int idTipo;
  String detalle;
  String cliente;
  int referencia;
  bool estado;
  String fecha;
  String createdAt;
  int idSecundario;
  List<EntityRegistroDetalle> detalles = [];

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        idTipo,
        detalle,
        estado,
        createdAt,
        idSecundario,
        cliente,
        fecha,
        referencia
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "idTipo": idTipo,
        "detalle": detalle,
        "cliente": cliente,
        "referencia": referencia,
        "fecha": fecha,
        "idSecundario": idSecundario,
        "estado": estado,
      };
}
