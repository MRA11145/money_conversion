class Currency {
  final String code;
  final String name;

  Currency(this.code, this.name);
}

class Conversion {
  final Currency currency;
  final double amount;

  Conversion(this.currency, this.amount);
}

