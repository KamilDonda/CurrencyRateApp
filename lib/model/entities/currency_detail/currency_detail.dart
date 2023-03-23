class CurrencyDetail {
  List<Rates>? rates;

  CurrencyDetail({this.rates});

  CurrencyDetail.fromJson(Map<String, dynamic> json) {
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rates != null) {
      data['rates'] = rates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rates {
  String? effectiveDate;
  double? bid;
  double? ask;

  Rates({this.effectiveDate, this.bid, this.ask});

  Rates.fromJson(Map<String, dynamic> json) {
    effectiveDate = json['effectiveDate'];
    bid = json['bid'];
    ask = json['ask'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['effectiveDate'] = effectiveDate;
    data['bid'] = bid;
    data['ask'] = ask;
    return data;
  }
}
