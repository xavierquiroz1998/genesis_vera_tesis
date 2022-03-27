import 'package:equatable/equatable.dart';

class EntityParametros extends Equatable {
  EntityParametros({
    this.id = 0,
    this.detalle = "",
    this.holgura = 0,
    this.estado = false,
  });

  int id;
  String detalle;
  int holgura;
  bool estado;
  @override
  // TODO: implement props
  List<Object?> get props => [id, detalle, holgura, estado];

  Map<String, dynamic> toMap() => {
        "id": id,
        "detalle": detalle,
        "holgura": holgura,
        "estado": estado,
      };
}
