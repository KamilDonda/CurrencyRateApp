class CurrencyDetailMid {
  String? currency;
  List<Rates>? rates;

  CurrencyDetailMid({this.currency, this.rates});

  CurrencyDetailMid.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    if (rates != null) {
      data['rates'] = rates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rates {
  String? effectiveDate;
  double? mid;

  Rates({this.effectiveDate, this.mid});

  Rates.fromJson(Map<String, dynamic> json) {
    effectiveDate = json['effectiveDate'];
    mid = json['mid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['effectiveDate'] = effectiveDate;
    data['mid'] = mid;
    return data;
  }
}
