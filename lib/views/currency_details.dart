import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/services/ui_convert.dart';
import 'package:crypto_app/widgets/currency_detail_card.dart';
import 'package:flutter/material.dart';

class CurrencyDetails extends StatelessWidget {
  final Currency currency;

  const CurrencyDetails({Key key, @required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Padding(
          padding: const EdgeInsets.only(right: 54),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Crypto",
                style: TextStyle(color: Colors.green, fontFamily: 'Roboto'),
              ),
              Text(
                "App",
                style: TextStyle(color: Colors.red, fontFamily: 'Roboto'),
              )
            ],
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(currency.nick_name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(currency.full_name,
                      style: TextStyle(color: Colors.grey, fontSize: 25)),
                ),
                CurrencyDetailCard(name: "Price", info: "\$" + currency.price, color: convertChangeToColor(currency.percent_change)),
                CurrencyDetailCard(name: "Volume 24h", info: "\$" + currency.volume_24h, color: convertChangeToColor(currency.percent_change)),
                CurrencyDetailCard(name: "Percent Change 24h", info:  currency.percent_change + "%", color: convertChangeToColor(currency.percent_change)),
                CurrencyDetailCard(name: "Circulating Supply", info: currency.circulating_supply, color: convertChangeToColor(currency.percent_change)),
                CurrencyDetailCard(name: "Total Supply", info: currency.total_supply, color: convertChangeToColor(currency.percent_change)),
                CurrencyDetailCard(name: "Market Cap", info: "\$" + currency.market_cap, color: convertChangeToColor(currency.percent_change)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
