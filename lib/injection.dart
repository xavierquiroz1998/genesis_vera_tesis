import 'package:genesis_vera_tesis/data/datasource/logeo/logeo_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/producto_datasource.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/logeo/sesion_Imp.dart';
import 'data/repositories/producto_Imp.dart';
import 'domain/providers/Login/loginProvider.dart';
import 'domain/repositories/abstractPRoducto.dart';
import 'domain/repositories/logeo/abstract_sesion.dart';
import 'domain/uses cases/logeo/inicio_sesion.dart';
import 'domain/uses cases/productos/insert_producto.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ProductosProvider(sl())); //injectar provider
  sl.registerFactory(() => LoginProvider(sl())); //injectar provider

  sl.registerLazySingleton(
      () => InsertarProducto(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => InicioSesion(sl())); //injeccion casos de uso

  sl.registerLazySingleton<AbstractProducto>(
      () => ProductoImp(sl())); // injeccion de repository

  sl.registerLazySingleton<AbstractSesion>(
      () => SesionImp(sl())); // injeccion de repository

  // sl.registerLazySingleton<UsuarioRepository>(
  //     () => FailureUsuarioRepositoryImp(sl()));

  sl.registerLazySingleton<ProductosDataSource>(
      () => ProductosDataSourceImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<LogeoDatasource>(
      () => LogeoDatasourceImp(sl())); // injeccion de datasourse

  sl.registerLazySingleton(() => http.Client()); // injeccion de http
}
