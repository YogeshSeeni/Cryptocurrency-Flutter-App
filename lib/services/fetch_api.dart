import 'dart:convert';

import 'package:crypto_app/models/crypto_currency.dart';
import 'package:http/http.dart' as http;


Future<List<Currency>> getPrices(int amount) async {
  var data = await http.get(
      Uri.encodeFull(
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=$amount&convert=USD"),
      headers: {
        "X-CMC_PRO_API_KEY": "be2934a9-e1aa-4c7e-8fcd-c9e98630b40c",
      });

  var jsonData = json.decode(data.body);

  List<Currency> currencies = [];

  for (var c in jsonData["data"]) {
    Currency currency = Currency(
        c["id"],
        c["symbol"].toString(),
        c["name"].toString(),
        c["quote"]["USD"]["price"].toString(),
        c["quote"]["USD"]["percent_change_24h"].toString(),
        c["circulating_supply"].toString(),
        c["max_supply"].toString(),
        c["total_supply"].toString(),
        c["quote"]["USD"]["volume_24h"].toString(),
        c["quote"]["USD"]["percent_change_1h"].toString(),
        c["quote"]["USD"]["percent_change_7h"].toString(),
        c["quote"]["USD"]["market_cap"].toString(),
        );
    currencies.add(currency);
  }

  return currencies;
}