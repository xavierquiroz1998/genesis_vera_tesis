import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/domain/repositories/proveedores/abtract_proveedores.dart';

class GetProveedores {
  final AbstractProveedores repository;

  GetProveedores(this.repository);

  Future<Either<Failure, List<ProveedoresEntity>>> call() async {
    return repository.getAllProveedores();
  }
}
