import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/providers/grupo/grupo_provider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/custom_outlined_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class TipoModal extends StatefulWidget {
  final GrupoEntity? categoria;

  const TipoModal({Key? key, this.categoria}) : super(key: key);

  @override
  _TipoModalState createState() => _TipoModalState();
}

class _TipoModalState extends State<TipoModal> {
  String descripcion = '';
  String nombre = '';
  String codigo = '';
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.categoria?.id.toString();
    codigo = widget.categoria?.referencia ?? '';
    nombre = widget.categoria?.nombre ?? '';
    descripcion = widget.categoria?.detalle ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<GrupoProvider>(context);
    return Container(
        padding: EdgeInsets.all(20),
        height: 500,
        decoration: builBoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categoria?.nombre ?? 'Nuevo Tipo',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
              ],
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    initialValue: widget.categoria?.referencia ?? '',
                    onChanged: (value) => codigo = value,
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Codigo de tipo',
                        label: 'Codigo',
                        icon: Icons.new_releases_outlined),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    initialValue: widget.categoria?.nombre ?? '',
                    onChanged: (value) => nombre = value,
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Nombre de tipo',
                        label: 'Nombre',
                        icon: Icons.new_releases_outlined),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.categoria?.detalle ?? '',
              onChanged: (value) => descripcion = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Descripcion de tipo',
                  label: 'Descripcion',
                  icon: Icons.new_releases_outlined),
              style: TextStyle(color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                  onPressed: () async {
                    try {
                      GrupoEntity grp = new GrupoEntity(
                        nombre: nombre,
                        detalle: descripcion,
                        referencia: codigo,
                        estado: true,
                      );
                      if (id == null) {
                        productProvider.guardarGrupo(grp);
                      } else {
                        grp.id = int.tryParse(id!) ?? 0;
                        productProvider.modifica(grp);
                      }
                      NavigationService.replaceTo("/tipo/producto");
                    } catch (e) {
                      print(e);
                      Navigator.of(context).pop();
                    }
                  },
                  text: 'Guardar'),
            )
          ],
        ));
  }

  BoxDecoration builBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Color(0xff0F2041));
  //  boxShadow: [BoxShadow(color: Colors.black26)]);
}
