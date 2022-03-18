import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "Ferreteria.png",
            //width: double.infinity,
            height: 100,
          ),
          SizedBox(
            width: 10,
          ),
          // Text(
          //   "Kiarita",
          //   style: TextStyle(
          //       fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}
