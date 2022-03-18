import '../../repositories/unidad_medida/abstractMedida.dart';

class InsertMedidas {
  final AbstractMedidaUnidad repository;

  InsertMedidas(this.repository);

  Future<String> insert() async {
    return await repository.insetUnidades();
  }
}
