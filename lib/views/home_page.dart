import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/services/fetch_api.dart';
import 'package:crypto_app/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future<List<Currency>> currencies = getPrices(100);

class HomePage extends StatefulWidget {
  final ScrollController controller;

  const HomePage({Key key,@required this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
            future: currencies,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 2));

                    setState(() {
                      currencies = getPrices(100);
                    });
                  },
                  child: ListView.builder(
                    controller: widget.controller,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CurrencyCard(currency: snapshot.data[index], index: index, indexNumber: true,);
                    },
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }
}
