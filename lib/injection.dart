import 'package:genesis_vera_tesis/data/datasource/logeo/logeo_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/producto_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/unidad_medida/unidad_datasource.dart';
import 'package:genesis_vera_tesis/data/repositories/unidad/unidad_imp.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/domain/repositories/unidad_medida/abstractMedida.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/unidad_medida/get_medidas.dart';
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
  sl.registerFactory(() => ProductosProvider(sl(), sl())); //injectar provider
  sl.registerFactory(() => LoginProvider(sl())); //injectar provider
  sl.registerFactory(() => UnidadMedidaProvider(sl()));

  sl.registerLazySingleton(() => InsertarProducto(sl()));
  sl.registerLazySingleton(() => GetProductos(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => InicioSesion(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => GetMedidas(sl()));

  sl.registerLazySingleton<AbstractMedidaUnidad>(
      () => UnidadImp(sl())); // injeccion de repository
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
  sl.registerLazySingleton<UnidadMediaDTS>(
      () => UnidadMedidaDTSImp(sl())); // injeccion de datasourse

  sl.registerLazySingleton(() => http.Client()); // injeccion de http

  //unidad medida
}
