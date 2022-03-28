import 'package:flutter/cupertino.dart';

import '../../entities/parametros/entityParameter.dart';
import '../../uses cases/parametros/parametros_general.dart';

class ParametrosPRovider extends ChangeNotifier {
  final ParametrosGeneral usesCases;

  ParametrosPRovider(this.usesCases);
  List<EntityParametros> listadoParametros = [];
  EntityParametros parametro1 = new EntityParametros();
  EntityParametros parametro2 = new EntityParametros();
  EntityParametros parametro3 = new EntityParametros();

  Future<void> getAllParametros() async {
    try {
      var result = await usesCases.getAllParametros();
      listadoParametros = result.getOrElse(() => []);
      notifyListeners();
    } catch (ex) {}
  }

  Future<void> insertPArametros() async {
    try {
      var result1 = await usesCases.insertParametro(parametro1);
      var obj1 = result1.getOrElse(() => new EntityParametros());

      var result2 = await usesCases.insertParametro(parametro1);
      var obj2 = result2.getOrElse(() => new EntityParametros());

      var result3 = await usesCases.insertParametro(parametro1);
      var obj3 = result3.getOrElse(() => new EntityParametros());
    } catch (ex) {}
  }

  Future<void> updateParametros() async {
    try {
for (var item in listadoParametros) {
    var result1 = await usesCases.updateParametro(item);
      var obj1 = result1.getOrElse(() => new EntityParametros());
}

    } catch (ex) {}
  }
}
