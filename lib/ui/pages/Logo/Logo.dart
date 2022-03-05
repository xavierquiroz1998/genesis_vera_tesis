import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bubble_chart_outlined,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Admin",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
