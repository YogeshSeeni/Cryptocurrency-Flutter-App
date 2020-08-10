import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/services/shared_preferences_service.dart';
import 'package:crypto_app/services/ui_convert.dart';
import 'package:crypto_app/views/currency_details.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatefulWidget {
  final Currency currency;
  final int index;
  final Color iconColor;
  final bool indexNumber;
  const CurrencyCard({Key key, @required this.currency, @required this.index, this.iconColor,@required this.indexNumber})
      : super(key: key);

  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  
  Color iconColor = Colors.white;
  SharedPreferenceService sharedPreferenceService = new SharedPreferenceService();
  
  
  @override
  Widget build(BuildContext context) {  
    sharedPreferenceService.getCurrencies().then((data) {
      if (data.contains(widget.currency.full_name)) {
        setState(() {
          iconColor = Colors.yellow;
        });
      }
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CurrencyDetails(
                    currency: widget.currency,
                  )));
        },
        leading: Text(
          (widget.index + 1).toString(),
          style: TextStyle(color: Colors.grey[400], fontSize: 20),
        ),
        title: Text(
          widget.currency.nick_name,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.currency.full_name,
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: convertChangeToIcon(widget.currency.percent_change),
              ),
              Column(
                children: <Widget>[
                  Text(
                    roundMoney(widget.currency.price),
                    style: TextStyle(
                        color: convertChangeToColor(
                            widget.currency.percent_change),
                        fontSize: 20),
                  ),
                  Text(
                    roundChange(widget.currency.percent_change),
                    style: TextStyle(
                        color: convertChangeToColor(
                            widget.currency.percent_change),
                        fontSize: 10),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    if (iconColor == Colors.white) {
                      sharedPreferenceService.addCurrency(widget.currency.full_name);
                      setState(() {
                        iconColor = Colors.yellow;
                      });
                    }
                    else {
                      sharedPreferenceService.removeCurrency(widget.currency.full_name);
                      setState(() {
                        iconColor = Colors.white;
                      });
                    }
                  },
                  child: Container(
                    child: Icon(
                      Icons.star,
                      color: iconColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
