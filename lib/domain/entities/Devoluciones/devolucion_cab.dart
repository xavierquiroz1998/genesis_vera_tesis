import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_det.dart';

class DevolucionCab {
  int? idDevolucion;
  String? observacion;
  DateTime? fechaIngreso;
  String? estado;
  List<DevolucionDet>? detalleDevolucion = [];

  DevolucionCab({
    this.idDevolucion,
    this.observacion,
    this.fechaIngreso,
    this.estado,
    this.detalleDevolucion,
  });

  Map<String, dynamic> toMap() {
    return {
      'idDevolucion': idDevolucion,
      'observacion': observacion,
      'fechaIngreso': fechaIngreso?.millisecondsSinceEpoch,
      'estado': estado,
      'detalleDevolucion': detalleDevolucion!.map((x) => x.toMap()).toList(),
    };
  }

  factory DevolucionCab.fromMap(Map<String, dynamic> map) {
    return DevolucionCab(
      idDevolucion: map['idDevolucion']?.toInt(),
      observacion: map['observacion'],
      fechaIngreso: map['fechaIngreso'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['fechaIngreso'])
          : null,
      estado: map['estado'],
      detalleDevolucion: map['detalleDevolucion'] != null
          ? List<DevolucionDet>.from(
              map['detalleDevolucion']?.map((x) => DevolucionDet.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevolucionCab.fromJson(String source) =>
      DevolucionCab.fromMap(json.decode(source));
}
