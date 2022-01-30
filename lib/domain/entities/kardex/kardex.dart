class Kardex {
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

  final DateTime fecPro;
  final String stsPro;

  Kardex(
      {required this.codMov,
      required this.codPro,
      required this.nomPro,
      required this.proCanI,
      required this.proUntI,
      required this.proTtlI,
      required this.proCanS,
      required this.proUntS,
      required this.proTtlS,
      required this.proCanE,
      required this.proUntE,
      required this.proTtlE,
      required this.fecPro,
      required this.stsPro});

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
}



/// I-0001 XXXXYYY IMPRESORAS 10  20.0  200.00 (8/01/2021) I
/// E-0002 XXXXYYY IMPRESORAS 5   20.0  200.00 (9/01/2021) E
/// ojo
/// I pero en negativo -0003 XXXXYYY IMPRESORAS 2   20.0  200.00 (15/01/2021) D
/// E pero en negativo -0004 XXXXYYY IMPRESORAS 2   20.0  200.00 (19/01/2021) D
/// METODOS INGRESOS - EGRESOS  - DEVOLUCIONES V - DEVOLUCIONES C
/// SELECT * FROM REGISTROS WHERE CODPRO = "XXXXYYY" ORDY BY FECPRO ASC;