import 'package:equatable/equatable.dart';

class EntityRegistro extends Equatable {
  EntityRegistro({
    this.id = 0,
    this.idTipo = 0,
    this.detalle = "",
    this.estado = false,
    this.referencia = 0,
    this.cliente = "",
    this.createdAt = "",
    this.idSecundario = 0,
  });
  int id;
  int idTipo;
  String detalle;
  String cliente;
  int referencia;
  bool estado;
  String createdAt;
  int idSecundario;

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
        referencia
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "idTipo": idTipo,
        "detalle": detalle,
        "cliente": cliente,
        "referencia": referencia,
        "idSecundario": idSecundario,
        "estado": estado,
      };
}
