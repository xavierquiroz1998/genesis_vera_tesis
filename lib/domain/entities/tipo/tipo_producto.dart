import 'dart:convert';

class TipoProducto {
  TipoProducto({
    required this.codPro,
    required this.codRef,
    required this.nomPro,
    required this.desPro,
    required this.stsPro,
  });

  String codPro;
  String codRef;
  String nomPro;
  String desPro;
  String stsPro;

  factory TipoProducto.fromJson(String str) =>
      TipoProducto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipoProducto.fromMap(Map<String, dynamic> json) => TipoProducto(
        codPro: json["cod_pro"],
        codRef: json["cod_ref"],
        nomPro: json["nom_pro"],
        desPro: json["des_pro"],
        stsPro: json["sts_pro"],
      );

  Map<String, dynamic> toMap() => {
        "cod_pro": codPro,
        "cod_ref": codRef,
        "nom_pro": nomPro,
        "des_pro": desPro,
        "sts_pro": stsPro,
      };
}
