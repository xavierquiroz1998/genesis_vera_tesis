import 'package:flutter/material.dart';

class ProductoCrud extends StatefulWidget {
  ProductoCrud({Key? key}) : super(key: key);

  @override
  _ProductoCrudState createState() => _ProductoCrudState();
}

class _ProductoCrudState extends State<ProductoCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Codigo"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Stock"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Precio"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: null,
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
