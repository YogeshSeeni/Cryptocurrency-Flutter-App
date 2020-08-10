import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/services/fetch_api.dart';
import 'package:crypto_app/widgets/currency_card.dart';
import 'package:flutter/material.dart';

Future<List<Currency>> currencies = getPrices(1500);
List<Currency> duplicateCurrencies;
List<Currency> filteredCurrencies = [];

class SearchCoins extends StatefulWidget {
  final ScrollController controller;

  const SearchCoins({Key key,@required this.controller}) : super(key: key);

  @override
  _SearchCoinsState createState() => _SearchCoinsState();
}

class _SearchCoinsState extends State<SearchCoins> {
  final userText = TextEditingController();
  List<Currency> tempItems = [];

  void updateFilteredCurrencies(String search) {
    for (Currency currency in duplicateCurrencies) {
      if (currency.full_name.toLowerCase().contains(search.toLowerCase()) |
          currency.nick_name.toLowerCase().contains(search.toLowerCase())) {
        tempItems.add(currency);
      }
    }

    setState(() {
      filteredCurrencies = tempItems;
    });

    if (search.length == 0) {
      setState(() {
        filteredCurrencies = [];
      });
    }

    tempItems = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: TextField(
              controller: userText,
              onChanged: (value) {
                updateFilteredCurrencies(userText.text);
              },
              decoration: InputDecoration(
                fillColor: Colors.grey,

                filled: true,
                focusedBorder: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(width: 1,color: Colors.black),
                  
                  gapPadding: 0
                ),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                //labelText: "Search for Coins",
                hintText: "Search for Coins"
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: currencies,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    if (duplicateCurrencies == null) {
                      duplicateCurrencies = snapshot.data;
                    }
                    if (userText.text.length == 0) {
                        filteredCurrencies = [];
                    }

                    return ListView.builder(
                      controller: widget.controller,
                      itemCount: filteredCurrencies.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(filteredCurrencies[0].percent_change);
                        return CurrencyCard(currency: filteredCurrencies[index], index: index, indexNumber: false,);
                      },
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
        ],
      ),
    );
  }
}
