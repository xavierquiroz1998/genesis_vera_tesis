import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:provider/provider.dart';

class ProductoCrud extends StatefulWidget {
  ProductoCrud({Key? key}) : super(key: key);

  @override
  _ProductoCrudState createState() => _ProductoCrudState();
}

class _ProductoCrudState extends State<ProductoCrud> {
  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                onChanged: (value) {
                  producto.product.codigo = value;
                },
                decoration: InputDecoration(labelText: "Codigo"),
              ),
              TextField(
                onChanged: (value) {
                  producto.product.descripcion = value;
                },
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              TextField(
                onChanged: (value) {
                  try {
                    producto.product.stock = int.parse(value);
                  } catch (e) {}
                },
                decoration: InputDecoration(labelText: "Stock"),
              ),
              TextField(
                onChanged: (value) {
                  try {
                    producto.product.precio = double.parse(value);
                  } catch (e) {}
                },
                decoration: InputDecoration(labelText: "Precio"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (producto.guardar()) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Guardar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
