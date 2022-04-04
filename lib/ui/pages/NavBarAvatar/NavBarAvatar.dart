import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/datasource/reference/local_storage.dart';
import '../../../domain/entities/usuarios/registroUsuarios.dart';

class NavBarAvatar extends StatefulWidget {
  const NavBarAvatar({Key? key}) : super(key: key);

  @override
  State<NavBarAvatar> createState() => _NavBarAvatarState();
}

class _NavBarAvatarState extends State<NavBarAvatar> {
  String nomUser = "";
  @override
  void initState() {
    var usuario = LocalStorage.prefs.getString('usuario');
    var mapUsuario = json.decode(usuario!);
    var susurio = RegistUser.fromMap(mapUsuario);
    if (susurio != null) {
      nomUser = susurio.nombre;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$nomUser"),
        ClipOval(
          child: Container(
            child: Image.network(
                'https://dl.airtable.com/DH4ROlhgSVG6TpXY0xrI_large_Joel-Monegro-pic-458x458.jpg'),
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }
}
