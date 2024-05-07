import 'package:flutter/material.dart';
import '../model/model.dart';
import '../repository/currency_repository.dart';

class CurrencyViewModel extends ChangeNotifier {
  final CurrencyRepository _repository;
  final Map<String, double> _exchangeRates = {};
  List<Currency> _currencies = [];
  late Currency _selectedCurrency;
  late double _amount;
  late List<Conversion> _conversions;

  CurrencyViewModel(this._repository) {
    _selectedCurrency = Currency('INR', 'Indian Rupees');
    _amount = 0.0;
    _conversions = [];
    fetchExchangeRates();
  }

  Currency get selectedCurrency => _selectedCurrency;
  List<Currency> get currencies => _currencies;
  List<Conversion> get conversions => _conversions;

  Future<void> fetchExchangeRates() async {
    try {
      final exchangeRates = await _repository.getExchangeRates();
       exchangeRates['rates'].forEach((key, value) {
        _exchangeRates[key] = value * 1.0;
      });
      _currencies = _exchangeRates.keys.map((code) => Currency(code, '')).toList();
      _conversions = [];
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching exchange rates: $e');
    }
  }

  void updateSelectedCurrency(Currency currency) {
    _selectedCurrency = currency;
    _conversions = _exchangeRates.entries.map((entry) => Conversion(Currency(entry.key, ''), entry.value * _amount / _exchangeRates[_selectedCurrency.code]!)).toList();
    notifyListeners();
  }

  void updateCountry(String countryCode) {
    _selectedCurrency = Currency(countryCode, "");
    updateSelectedCurrency(_selectedCurrency);
  }

  void updateAmount(double amount) {
    _amount = amount;
    updateSelectedCurrency(_selectedCurrency);
  }

  Currency getSelectedCurrency() {
    return _selectedCurrency;
  }
}
