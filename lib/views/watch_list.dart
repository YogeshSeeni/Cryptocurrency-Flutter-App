import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/services/fetch_api.dart';
import 'package:crypto_app/services/shared_preferences_service.dart';
import 'package:crypto_app/widgets/currency_card.dart';
import 'package:flutter/material.dart';

Future<List<Currency>> currencies = getPrices(5000);
List<Currency> duplicateCurrencies;
List<Currency> favoriteCurrencies = [];

class WatchList extends StatefulWidget {
  final ScrollController controller;

  const WatchList({Key key, @required this.controller}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  SharedPreferenceService sharedPreferenceService =
      new SharedPreferenceService();

  void initState() {
    getPrices(5000).then((data) {
      duplicateCurrencies = data;
      favoriteCurrencies = [];
      sharedPreferenceService.getCurrencies().then((data) {
        print(data);
        for (Currency currency in duplicateCurrencies) {
          if (data.contains(currency.full_name)) {
            setState(() {
              favoriteCurrencies.add(currency);
            });
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
            future: currencies,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                if (favoriteCurrencies.length == 0) {
                  return SizedBox.expand(
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You don't have any coins on your watchlist", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(height: 15),
                          Text("Add one by tapping the star on any coin", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {
                        getPrices(5000).then((data) {
                          duplicateCurrencies = data;
                          favoriteCurrencies = [];
                          sharedPreferenceService.getCurrencies().then((data) {
                            print(data);
                            for (Currency currency in duplicateCurrencies) {
                              if (data.contains(currency.full_name)) {
                                setState(() {
                                  favoriteCurrencies.add(currency);
                                });
                              }
                            }
                          });
                        });
                      });
                    },
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: widget.controller,
                      itemCount: favoriteCurrencies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CurrencyCard(
                          currency: favoriteCurrencies[index],
                          index: index,
                          indexNumber: false,
                        );
                      },
                    ),
                  );
                }
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
