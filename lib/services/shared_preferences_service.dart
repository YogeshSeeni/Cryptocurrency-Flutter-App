
import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferenceService {
  
  addCurrency(String full_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currencyList = prefs.getStringList("favorite_coins");
    if (currencyList == null) {
      prefs.setStringList("favorite_coins", [full_name.toString()]);
    }
    else {
      if (currencyList.contains(full_name)) {
        print("id already in list");
      }
      else {
        currencyList.add(full_name);
        prefs.setStringList("favorite_coins", currencyList);
        print(currencyList);
      } 
    }
  }

  removeCurrency(String full_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currencyList = prefs.getStringList("favorite_coins");
    currencyList.remove(full_name);
    prefs.setStringList("favorite_coins", currencyList);
    print(currencyList);
  }

  getCurrencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currencyList = prefs.getStringList("favorite_coins");
    return currencyList;
  }
}