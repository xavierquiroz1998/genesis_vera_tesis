import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

import '../../../core/Errors/failure.dart';
import '../../../data/services/Navigation/NavigationService.dart';
import '../../services/fail.dart';
import '../../uses cases/proveedores/delete_proveedores.dart';
import '../../uses cases/proveedores/getproveedores.dart';
import '../../uses cases/proveedores/insert_proveedor.dart';
import '../../uses cases/proveedores/update_proveedores.dart';

class ProveedoresProvider extends ChangeNotifier {
  String _titulo = "";

  final GetProveedores useCaseProveedores;
  final InsertProveedor insertProveedor;
  final UpdateProveedor updateProveedor;
  final DeleteProveedor deleteProveedor;
  ProveedoresProvider(this.useCaseProveedores, this.insertProveedor,
      this.updateProveedor, this.deleteProveedor);

  List<ProveedoresEntity> listaProveedores = [];

  ProveedoresEntity _proveedores = new ProveedoresEntity();
  TextEditingController _controllIdentificacion = new TextEditingController();

  TextEditingController _controllNombres = new TextEditingController();

  TextEditingController _controllDireccion = new TextEditingController();

  TextEditingController _controllCorreo = new TextEditingController();
  TextEditingController _controllTiempoHolgura = new TextEditingController();

  TextEditingController get controllTiempoHolgura => _controllTiempoHolgura;

  set controllTiempoHolgura(TextEditingController controllTiempoHolgura) {
    _controllTiempoHolgura = controllTiempoHolgura;
    notifyListeners();
  }

  TextEditingController get controllCorreo => _controllCorreo;

  TextEditingController _controllCelular = new TextEditingController();

  TextEditingController get controllCelular => _controllCelular;

  String get titulo => _titulo;

  set titulo(String titulo) {
    _titulo = titulo;
    notifyListeners();
  }

  set controllCelular(TextEditingController controllCelular) {
    _controllCelular = controllCelular;
    notifyListeners();
  }
  //TextEditingController controllIdentificacion = new TextEditingController();

  final _keyProveedor = GlobalKey<FormState>();

  TextEditingController get controllIdentificacion => _controllIdentificacion;

  set controllIdentificacion(TextEditingController controllIdentificacion) {
    _controllIdentificacion = controllIdentificacion;
    notifyListeners();
  }

  TextEditingController get controllNombres => _controllNombres;

  set controllNombres(TextEditingController controllNombres) {
    _controllNombres = controllNombres;
    notifyListeners();
  }

  TextEditingController get controllDireccion => _controllDireccion;

  set controllDireccion(TextEditingController controllDireccion) {
    _controllDireccion = controllDireccion;
    notifyListeners();
  }

  set controllCorreo(TextEditingController controllCorreo) {
    _controllCorreo = controllCorreo;
    notifyListeners();
  }

  ProveedoresEntity get proveedor => _proveedores;

  set proveedor(ProveedoresEntity proveedores) {
    _proveedores = proveedores;
    controllIdentificacion.text = proveedor.identificacion;
    controllCorreo.text = proveedor.correo;
    controllDireccion.text = proveedor.direccion;
    controllNombres.text = proveedor.nombre;
    controllCelular.text = proveedor.identificacion;
    controllTiempoHolgura.text = proveedor.holgura.toString();
    notifyListeners();
  }

  GlobalKey<FormState> get keyProvider => _keyProveedor;

  Future<void> obtenerProveedores() async {
    var temporal = await useCaseProveedores.call();
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listaProveedores = result as List<ProveedoresEntity>;
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  String failure(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        return "Ocurrio un Error";

      default:
        return "Error";
    }
  }

  getProveedor() {
    try {
      proveedor.identificacion = controllIdentificacion.text;
      proveedor.correo = controllCorreo.text;
      proveedor.direccion = controllDireccion.text;
      proveedor.nombre = controllNombres.text;
      proveedor.telefono = controllCelular.text;
      proveedor.estado = true;
      proveedor.holgura = int.parse(controllTiempoHolgura.text);
    } catch (e) {}
  }

  Future<bool> guardar() async {
    try {
      //if (keyProvider.currentState!.validate()) {
      getProveedor();
      if (proveedor.id == 0) {
        var result = await insertProveedor.insert(proveedor);
        var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
        tem as ProveedoresEntity;
      } else {
        var result = await updateProveedor.update(proveedor);
        var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
        tem as ProveedoresEntity;
      }

      clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  void anular(ProveedoresEntity prove) async {
    try {
      if (prove.id != 0) {
        prove.estado = false;
        var tem = await updateProveedor.update(prove);
        NavigationService.replaceTo("/proveedores");
      }
    } catch (e) {
      print("error en anular");
    }
  }

  void clear() {
    proveedor = new ProveedoresEntity();
    controllIdentificacion.text = proveedor.identificacion;
    controllDireccion.text =
        controllNombres.text = controllCorreo.text = controllCelular.text = "";
  }
}
