import 'package:genesis_vera_tesis/data/datasource/grupo/grupo_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/logeo/logeo_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/permiso/permiso_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/producto_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/proveedores/proveedores_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/proyecto/proyecto_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/unidad_medida/unidad_datasource.dart';
import 'package:genesis_vera_tesis/data/repositories/grupo/grupo_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/permiso/permiso_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/proyecto/proyecto_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/unidad/unidad_imp.dart';
import 'package:genesis_vera_tesis/domain/providers/grupo/grupo_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/permiso/permiso_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/proyecto/proyecto_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/domain/repositories/grupo/abstract_grupo.dart';
import 'package:genesis_vera_tesis/domain/repositories/permiso/abstract_permiso.dart';
import 'package:genesis_vera_tesis/domain/repositories/proyecto/abstract_proyecto.dart';
import 'package:genesis_vera_tesis/domain/repositories/unidad_medida/abstractMedida.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/grupo/get_grupos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/permiso/get_permiso.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proyecto/get_proyectos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/unidad_medida/get_medidas.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/logeo/sesion_Imp.dart';
import 'data/repositories/producto_Imp.dart';
import 'data/repositories/proveedores/proveedor_imp.dart';
import 'domain/providers/Login/loginProvider.dart';
import 'domain/providers/Proveedores/proveedoresProvider.dart';
import 'domain/repositories/abstractPRoducto.dart';
import 'domain/repositories/logeo/abstract_sesion.dart';
import 'domain/repositories/proveedores/abtract_proveedores.dart';
import 'domain/uses cases/logeo/inicio_sesion.dart';
import 'domain/uses cases/productos/insert_producto.dart';
import 'domain/uses cases/proveedores/getproveedores.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => ProductosProvider(sl(), sl(), sl(), sl())); //injectar provider
  sl.registerFactory(() => LoginProvider(sl())); //injectar provider
  sl.registerFactory(() => UnidadMedidaProvider(sl()));
  sl.registerFactory(() => GrupoProvider(sl()));
  sl.registerFactory(() => ProveedoresProvider(sl()));
  sl.registerFactory(() => PermisoProvider(sl()));
  sl.registerFactory(() => ProyectoProvider(sl()));

  sl.registerLazySingleton(() => InsertarProducto(sl()));
  sl.registerLazySingleton(() => GetProductos(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => InicioSesion(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => GetMedidas(sl()));
  sl.registerLazySingleton(() => GetGrupos(sl()));
  sl.registerLazySingleton(() => GetProveedores(sl()));
  sl.registerLazySingleton(() => GetProyectos(sl()));
  sl.registerLazySingleton(() => GetPermiso(sl()));

  sl.registerLazySingleton<AbstractMedidaUnidad>(
      () => UnidadImp(sl())); // injeccion de repository
  sl.registerLazySingleton<AbstractProducto>(
      () => ProductoImp(sl())); // injeccion de repository

  sl.registerLazySingleton<AbstractSesion>(
      () => SesionImp(sl())); // injeccion de repository
  sl.registerLazySingleton<AbstractGrupo>(
      () => GrupoImp(sl())); // injeccion de repository
  sl.registerLazySingleton<AbstractProveedores>(
      () => ProveedoresImp(sl())); // injeccion de repository
  sl.registerLazySingleton<AbstractProyecto>(
      () => ProyectoImpl(sl())); // injeccion de repository
  sl.registerLazySingleton<AbstractPermiso>(
      () => PermisoImp(sl())); // injeccion de repository

  // sl.registerLazySingleton<UsuarioRepository>(
  //     () => FailureUsuarioRepositoryImp(sl()));

  sl.registerLazySingleton<ProductosDataSource>(
      () => ProductosDataSourceImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<LogeoDatasource>(
      () => LogeoDatasourceImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<UnidadMediaDTS>(
      () => UnidadMedidaDTSImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<GrupoDTS>(
      () => GrupoDTSImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<ProveedoresDatasourceADS>(
      () => ProveedoresDataSourceImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<PermisoDTS>(
      () => PermisoDTSImp(sl())); // injeccion de datasourse
  sl.registerLazySingleton<ProyectoDTS>(
      () => ProyectoDTSImp(sl())); // injeccion de datasourse

  sl.registerLazySingleton(() => http.Client()); // injeccion de http

  //unidad medida
}
