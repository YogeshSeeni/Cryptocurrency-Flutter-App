
class Currency {
  final int id;
  final String nick_name;
  final String full_name;
  final String price;
  final String percent_change;
  final String circulating_supply;
  final String max_supply;
  final String total_supply;
  final String volume_24h;
  final String percent_change_1h;
  final String percent_change_7d;
  final String market_cap;

  Currency(this.id, this.nick_name, this.full_name, this.price, this.percent_change, this.circulating_supply, this.max_supply, this.total_supply, this.volume_24h, this.percent_change_1h, this.percent_change_7d, this.market_cap);
}
