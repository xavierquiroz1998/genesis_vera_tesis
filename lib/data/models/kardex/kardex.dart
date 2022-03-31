import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';

class ModelKardex extends Kardex {
  ModelKardex({
    this.id = 0,
    this.idProducto = 0,
    this.codMov = "",
    this.codPro = "",
    this.nomPro = "",
    this.proCanI = 0,
    this.proUntI = "",
    this.proTtlI = "",
    this.proCanS = 0,
    this.proUntS = "",
    this.proTtlS = "",
    this.proCanE = 0,
    this.proUntE = "",
    this.proTtlE = "",
    this.fecPro,
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
          fecPro: fecPro,
          stsPro: stsPro,
        );

  int id;
  int idProducto;
  String codMov;
  String codPro;
  String nomPro;
  int proCanI;
  String proUntI;
  String proTtlI;
  int proCanS;
  String proUntS;
  String proTtlS;
  int proCanE;
  String proUntE;
  String proTtlE;
  DateTime? fecPro;
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
      fecPro:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
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
        "fecPro": fecPro?.toIso8601String(),
        "stsPro": stsPro,
      };
}
