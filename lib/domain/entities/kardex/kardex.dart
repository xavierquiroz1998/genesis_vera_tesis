import 'package:equatable/equatable.dart';

class Kardex extends Equatable {
  int id;
  int idProducto;
  final String codMov;
  final String codPro;
  final String nomPro;

  final double proCanI;
  final double proUntI;
  final double proTtlI;

  final double proCanS;
  final double proUntS;
  final double proTtlS;

  final double proCanE;
  final double proUntE;
  final double proTtlE;

  final DateTime? fecPro;
  final String stsPro;

  Kardex({
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
    this.fecPro,
    this.stsPro = "",
  });

  @override
  String toString() {
    return codMov +
        " / " +
        codPro +
        " / " +
        nomPro +
        " / " +
        "Entradas : $proCanI / $proUntI / $proTtlI Salidas: $proCanS / $proUntS / $proTtlS Existencias: $proCanE / $proUntE / $proTtlE";
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
        "fecPro": fecPro!.toIso8601String(),
        "stsPro": stsPro,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        idProducto,
        codMov,
        codPro,
        nomPro,
        proCanI,
        proUntI,
        proTtlI,
        proCanS,
        proUntS,
        proTtlS,
        proCanE,
        proUntE,
        proTtlE,
        fecPro,
        stsPro
      ];
}



/// I-0001 XXXXYYY IMPRESORAS 10  20.0  200.00 (8/01/2021) I
/// E-0002 XXXXYYY IMPRESORAS 5   20.0  200.00 (9/01/2021) E
/// ojo
/// I pero en negativo -0003 XXXXYYY IMPRESORAS 2   20.0  200.00 (15/01/2021) D
/// E pero en negativo -0004 XXXXYYY IMPRESORAS 2   20.0  200.00 (19/01/2021) D
/// METODOS INGRESOS - EGRESOS  - DEVOLUCIONES V - DEVOLUCIONES C
/// SELECT * FROM REGISTROS WHERE CODPRO = "XXXXYYY" ORDY BY FECPRO ASC;