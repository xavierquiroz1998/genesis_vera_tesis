import 'package:equatable/equatable.dart';

class EntityRegistro extends Equatable {
  EntityRegistro({
    this.id = 0,
    this.idTipo = "",
    this.detalle = "",
    this.estado = false,
  });
  int id;
  String idTipo;
  String detalle;
  bool estado;

  @override
  // TODO: implement props
  List<Object?> get props => [id, idTipo, detalle, estado];

  Map<String, dynamic> toMap() => {
        "id": id,
        "idTipo": idTipo,
        "detalle": detalle,
        "estado": estado,
      };
}
