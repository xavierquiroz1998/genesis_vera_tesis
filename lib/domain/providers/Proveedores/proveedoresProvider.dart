import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

import '../../../core/Errors/failure.dart';
import '../../uses cases/proveedores/getproveedores.dart';

class ProveedoresProvider extends ChangeNotifier {
  String _titulo = "";

  final GetProveedores useCaseProveedores;
  ProveedoresProvider(this.useCaseProveedores);

  List<ProveedoresEntity> listaProveedores = [];

  ProveedoresEntity _proveedores = new ProveedoresEntity();
  TextEditingController _controllIdentificacion = new TextEditingController();

  TextEditingController _controllNombres = new TextEditingController();

  TextEditingController _controllDireccion = new TextEditingController();

  TextEditingController _controllCorreo = new TextEditingController();

  TextEditingController get controllCorreo => _controllCorreo;

  TextEditingController _controllCelular = new TextEditingController();

  TextEditingController get controllCelular => _controllCelular;

  String get titulo => _titulo;

  set titulo(String titulo) {
    _titulo = titulo;
  }

  set controllCelular(TextEditingController controllCelular) {
    _controllCelular = controllCelular;
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
  }

  TextEditingController get controllDireccion => _controllDireccion;

  set controllDireccion(TextEditingController controllDireccion) {
    _controllDireccion = controllDireccion;
  }

  set controllCorreo(TextEditingController controllCorreo) {
    _controllCorreo = controllCorreo;
  }

  ProveedoresEntity get proveedor => _proveedores;

  set proveedor(ProveedoresEntity proveedores) {
    _proveedores = proveedores;
    controllIdentificacion.text = proveedor.identificacion;
    controllCorreo.text = proveedor.correo;
    controllDireccion.text = proveedor.direccion;
    controllNombres.text = proveedor.nombre;
    controllCelular.text = proveedor.identificacion;
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
      proveedor.identificacion = controllCelular.text;
    } catch (e) {}
  }

  void guardar(BuildContext context) {
    try {
      if (keyProvider.currentState!.validate()) {
        getProveedor();
        proveedor.id = Estaticas.listProveedores.length + 1;
        Estaticas.listProveedores.add(proveedor);
        print("Nuevo Proveedor registrado");
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  void anular(ProveedoresEntity prove) {
    try {
      if (prove.id != 0) {
        Estaticas.listProveedores.remove(prove);
        prove.estado = false;
        Estaticas.listProveedores.add(prove);
      }
    } catch (e) {
      print("error en anular");
    }
  }
}
