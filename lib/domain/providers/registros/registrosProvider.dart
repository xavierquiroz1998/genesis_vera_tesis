import 'package:flutter/cupertino.dart';

import '../../uses cases/registros/usesCaseRegistros.dart';

class RegistrosProvider extends ChangeNotifier {
  final UsesCaseRegistros usesCases;

  RegistrosProvider(this.usesCases);
}
