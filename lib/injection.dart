import 'package:genesis_vera_tesis/data/datasource/grupo/grupo_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/kardex/kardex_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/logeo/logeo_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/parametros/parametros_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/permiso/permiso_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/producto_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/proveedores/proveedores_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/proyecto/proyecto_datasource.dart';
import 'package:genesis_vera_tesis/data/datasource/unidad_medida/unidad_datasource.dart';
import 'package:genesis_vera_tesis/data/repositories/Usuarios/usuarios_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/grupo/grupo_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/kardex/kardex_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/parametros/parametrosImp.dart';
import 'package:genesis_vera_tesis/data/repositories/permiso/permiso_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/proyecto/proyecto_imp.dart';
import 'package:genesis_vera_tesis/data/repositories/unidad/unidad_imp.dart';
import 'package:genesis_vera_tesis/domain/providers/grupo/grupo_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/permiso/permiso_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/proyecto/proyecto_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/domain/repositories/Usuarios/abstractUsuarios.dart';
import 'package:genesis_vera_tesis/domain/repositories/grupo/abstract_grupo.dart';
import 'package:genesis_vera_tesis/domain/repositories/kardex/abstract_kardex.dart';
import 'package:genesis_vera_tesis/domain/repositories/permiso/abstract_permiso.dart';
import 'package:genesis_vera_tesis/domain/repositories/proyecto/abstract_proyecto.dart';
import 'package:genesis_vera_tesis/domain/repositories/unidad_medida/abstractMedida.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/Kardex/kardex_general.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/grupo/get_grupos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/permiso/get_permiso.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/permiso/insert_permiso.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proveedores/insert_proveedor.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proyecto/get_proyectos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/unidad_medida/get_medidas.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/unidad_medida/insert_medidas.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/usuarios/get_usuarios.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/usuarios/insert_usuario.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasource/registros/registroDataSource.dart';
import 'data/datasource/usuarios/usuarios_datasource.dart';
import 'data/repositories/logeo/sesion_Imp.dart';
import 'data/repositories/producto_Imp.dart';
import 'data/repositories/proveedores/proveedor_imp.dart';
import 'data/repositories/registros/registros_imp.dart';
import 'domain/providers/Devoluciones/devolucionProvider.dart';
import 'domain/providers/Login/loginProvider.dart';
import 'domain/providers/Proveedores/proveedoresProvider.dart';
import 'domain/providers/Usuarios/UsuariosProvider.dart';
import 'domain/providers/egreso/e_productoProvider.dart';
import 'domain/providers/ingreso/ingresosProvider.dart';
import 'domain/providers/kardex/kardex_provider.dart';
import 'domain/providers/parametros/provider_parametros.dart';
import 'domain/providers/registros/registrosProvider.dart';
import 'domain/repositories/abstractPRoducto.dart';
import 'domain/repositories/logeo/abstract_sesion.dart';
import 'domain/repositories/parametros/Abstrac_parametros.dart';
import 'domain/repositories/proveedores/abtract_proveedores.dart';
import 'domain/repositories/registros/abstract_registros.dart';
import 'domain/uses cases/grupo/delete_grupo.dart';
import 'domain/uses cases/grupo/insert_grupos.dart';
import 'domain/uses cases/grupo/update_grupos.dart';
import 'domain/uses cases/logeo/inicio_sesion.dart';
import 'domain/uses cases/parametros/parametros_general.dart';
import 'domain/uses cases/productos/insert_producto.dart';
import 'domain/uses cases/proveedores/delete_proveedores.dart';
import 'domain/uses cases/proveedores/getproveedores.dart';
import 'domain/uses cases/proveedores/update_proveedores.dart';
import 'domain/uses cases/registros/usesCaseRegistros.dart';
import 'domain/uses cases/unidad_medida/delete_medidas.dart';
import 'domain/uses cases/unidad_medida/update_medidas.dart';
import 'domain/uses cases/usuarios/delete_usuarios.dart';
import 'domain/uses cases/usuarios/update_usuarios.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ProductosProvider(
      sl(), sl(), sl(), sl(), sl(), sl())); //injectar provider
  sl.registerFactory(() => LoginProvider(sl(), sl())); //injectar provider
  sl.registerFactory(() => UnidadMedidaProvider(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => GrupoProvider(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ProveedoresProvider(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => PermisoProvider(sl()));
  sl.registerFactory(() => ProyectoProvider(sl(), sl()));
  sl.registerFactory(() => EProductoProvider(sl(), sl()));
  sl.registerFactory(() => DevolucionProvider(sl(), sl()));
  sl.registerFactory(() => UsuariosProvider(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => RegistrosProvider(sl()));
  sl.registerFactory(() => IngresosProvider(sl(), sl()));
  sl.registerFactory(() => KardexProvider(sl()));
  sl.registerFactory(() => ParametrosPRovider(sl()));

  sl.registerLazySingleton(() => InsertarProducto(sl()));
  sl.registerLazySingleton(() => GetProductos(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => InicioSesion(sl())); //injeccion casos de uso
  sl.registerLazySingleton(() => GetMedidas(sl()));
  sl.registerLazySingleton(() => GetGrupos(sl()));
  sl.registerLazySingleton(() => GetProveedores(sl()));
  sl.registerLazySingleton(() => GetProyectos(sl()));
  sl.registerLazySingleton(() => GetPermiso(sl()));
  sl.registerLazySingleton(() => GetUsuarios(sl()));
  sl.registerLazySingleton(() => InsertMedidas(sl()));
  sl.registerLazySingleton(() => InsertPermiso(sl()));
  sl.registerLazySingleton(() => InsertProveedor(sl()));
  sl.registerLazySingleton(() => InsertUsuarios(sl()));
  sl.registerLazySingleton(() => InsertGrupo(sl()));
  sl.registerLazySingleton(() => DeleteUsuarios(sl()));
  sl.registerLazySingleton(() => UpdatetUsuarios(sl()));
  sl.registerLazySingleton(() => UpdateGrupos(sl()));
  sl.registerLazySingleton(() => DeleteGrupo(sl()));
  sl.registerLazySingleton(() => UpdateProveedor(sl()));
  sl.registerLazySingleton(() => DeleteProveedor(sl()));
  sl.registerLazySingleton(() => DeleteMedidas(sl()));
  sl.registerLazySingleton(() => UpdateMedidas(sl()));
  sl.registerLazySingleton(() => UsesCaseRegistros(sl()));
  sl.registerLazySingleton(() => KardexGeneral(sl()));
  sl.registerLazySingleton(() => ParametrosGeneral(sl()));

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
  sl.registerLazySingleton<AbstractUsuarios>(() => UsuariosImp(sl()));
  sl.registerLazySingleton<AbstractRegistros>(() => RegistrosImp(sl()));
  sl.registerLazySingleton<AbstractKardex>(() => KardexImp(sl()));
  sl.registerLazySingleton<AbstractParametros>(() => ParametrosImps(sl()));

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
  sl.registerLazySingleton<UsuarioDatasource>(() => UsuarioDatasourceImp(sl()));
  sl.registerLazySingleton<RegistroDTS>(() => RegistroDTSImp(sl()));
  sl.registerLazySingleton<KardexDTS>(() => KardexDTSImp(sl()));
  sl.registerLazySingleton<ParametrosDTS>(() => ParametrosDTSImp(sl()));

  sl.registerLazySingleton(() => http.Client()); // injeccion de http

  //unidad medida
}
