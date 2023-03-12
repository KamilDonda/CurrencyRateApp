class CurrencyDetailMid {
  List<Rates>? rates;
  String? error;

  CurrencyDetailMid({this.rates});

  CurrencyDetailMid.withError(String errorMessage) {
    error = errorMessage;
  }

  CurrencyDetailMid.fromJson(Map<String, dynamic> json) {
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
