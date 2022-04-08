import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';

// ignore: must_be_immutable
class ModelKardex extends Kardex {
  ModelKardex({
    this.id = 0,
    this.idProducto = 0,
    this.codMov = "",
    this.codPro = "",
    this.nomPro = "",
    this.proCanI = 0,
    this.proUntI = 0,
    this.proTtlI = 0,
    this.proCanS = 0,
    this.proUntS = 0,
    this.proTtlS = 0,
    this.proCanE = 0,
    this.proUntE = 0,
    this.proTtlE = 0,
    this.createdAt,
    this.stsPro = false,
  }) : super(
          id: id,
          idProducto: idProducto,
          codMov: codMov,
          codPro: codPro,
          proCanI: proCanI,
          proUntI: proUntI,
          proTtlI: proTtlI,
          proCanS: proCanS,
          proUntS: proUntS,
          proTtlS: proTtlS,
          proCanE: proCanE,
          proUntE: proUntE,
          proTtlE: proTtlE,
          createdAt: createdAt,
          stsPro: stsPro,
        );

  int id;
  int idProducto;
  String codMov;
  String codPro;
  String nomPro;
  double proCanI;
  double proUntI;
  double proTtlI;
  double proCanS;
  double proUntS;
  double proTtlS;
  double proCanE;
  double proUntE;
  double proTtlE;
  DateTime? createdAt;
  bool stsPro;

  factory ModelKardex.fromMap(Map<String, dynamic> json) {
    return ModelKardex(
      id: json["id"],
      codMov: json["codMov"],
      idProducto: json["idProducto"],
      proCanI: json["proCanI"],
      proUntI: json["proUntI"],
      proTtlI: json["proTtlI"],
      proCanS: json["proCanS"],
      proUntS: json["proUntS"],
      proTtlS: json["proTtlS"],
      proCanE: json["proCanE"],
      proUntE: json["proUntE"],
      proTtlE: json["proTtlE"],
      createdAt: DateTime.parse(json["createdAt"]),
      stsPro: json["estado"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "idProducto": idProducto,
        "codMov": codMov,
        "codPro": codPro,
        "nomPro": nomPro,
        "proCanI": proCanI,
        "proUntI": proUntI,
        "proTtlI": proTtlI,
        "proCanS": proCanS,
        "proUntS": proUntS,
        "proTtlS": proTtlS,
        "proCanE": proCanE,
        "proUntE": proUntE,
        "proTtlE": proTtlE,
        "createdAt": createdAt!.toIso8601String(),
        "stsPro": stsPro,
      };
}
