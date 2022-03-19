import 'package:equatable/equatable.dart';

class UnidadMedidaEntity extends Equatable {
  UnidadMedidaEntity({
    this.id = 0,
    this.codigo = "",
    this.detalle = "",
    this.estado = true,
  });

  int id;
  String codigo;
  String detalle;
  bool estado;

  @override
  List<Object?> get props => [id, codigo, detalle, estado];

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
        "estado": estado,
      };
}
