import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class ProveedoresProvider extends ChangeNotifier {
  String _titulo = "";

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
    controllIdentificacion.text = proveedor.identificacion ?? "";
    controllCorreo.text = proveedor.correo ?? "";
    controllDireccion.text = proveedor.direccion ?? "";
    controllNombres.text = proveedor.nombres ?? "";
    controllCelular.text = proveedor.celular ?? "";
    notifyListeners();
  }

  GlobalKey<FormState> get keyProvider => _keyProveedor;

  getProveedor() {
    try {
      proveedor.identificacion = controllIdentificacion.text;
      proveedor.correo = controllCorreo.text;
      proveedor.direccion = controllDireccion.text;
      proveedor.nombres = controllNombres.text;
      proveedor.celular = controllCelular.text;
    } catch (e) {}
  }

  void guardar(BuildContext context) {
    try {
      if (keyProvider.currentState!.validate()) {
        getProveedor();
        proveedor.idProveedor = Estaticas.listProveedores.length + 1;
        Estaticas.listProveedores.add(proveedor);
        print("Nuevo Proveedor registrado");
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  void anular() {
    try {
      if (proveedor.idProveedor != null) {
        Estaticas.listProveedores.remove(proveedor);
        proveedor.estado = "I";
        Estaticas.listProveedores.add(proveedor);
      }
    } catch (e) {
      print("error en anular");
    }
  }
}
