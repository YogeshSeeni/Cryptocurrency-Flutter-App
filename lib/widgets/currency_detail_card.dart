import 'package:flutter/material.dart';

class CurrencyDetailCard extends StatelessWidget {
  final String name;
  final String info;
  final Color color;

  const CurrencyDetailCard({Key key, @required this.name, @required this.info,@required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height / 5,
      child: Card(
        color: Colors.grey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 50,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
              child: Text(
                  info,
                  style: TextStyle(color: color, fontSize: 20),
                ),
              ),
        ]),
      ),
    );
  }
}
