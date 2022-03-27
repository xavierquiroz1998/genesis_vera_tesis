import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';

import '../../../domain/entities/tipo/grupo.dart';

class ModelKardex extends Kardex {
  ModelKardex({
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
    this.fecPro,
    this.stsPro = "",
  }) : super(
          codMov: codMov,
          codPro: codPro,
          nomPro: nomPro,
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

  DateTime? fecPro;
  String stsPro;

  factory ModelKardex.fromMap(Map<String, dynamic>? json) {
    return ModelKardex(
      codMov: json?["codMov"],
      codPro: json?["codPro"],
      nomPro: json?["nomPro"],
      proCanI: json?["proCanI"],
      proUntI: json?["proUntI"],
      proTtlI: json?["proTtlI"],
      proCanS: json?["proCanS"],
      proUntS: json?["proUntS"],
      proTtlS: json?["proTtlS"],
      proCanE: json?["proCanE"],
      proUntE: json?["proUntE"],
      proTtlE: json?["proTtlE"],
      fecPro: json?["fecPro"] == null ? null : DateTime.parse(json?["fecPro"]),
      stsPro: json?["stsPro"],
    );
  }

  Map<String, dynamic> toMap() => {
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
