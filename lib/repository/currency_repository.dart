import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/currency_service.dart';

class CurrencyRepository {
  static const String lastFetchedKey = 'last_fetched';
  static const int refreshInterval = 30 * 60 * 1000; // 30 minutes

  final CurrencyService _service;

  CurrencyRepository(this._service);

  Future<Map<String, dynamic>> getExchangeRates() async {
    final prefs = await SharedPreferences.getInstance();
    final lastFetched = prefs.getInt(lastFetchedKey) ?? 0;

    if (DateTime.now().millisecondsSinceEpoch - lastFetched > refreshInterval) {
      final exchangeRates = await _service.fetchExchangeRates();
      prefs.setInt(lastFetchedKey, DateTime.now().millisecondsSinceEpoch);
      prefs.setString('exchange_rates', jsonEncode(exchangeRates));
      return exchangeRates;
    } else {
      final cachedData = prefs.getString('exchange_rates');
      return jsonDecode(cachedData!);
    }
  }
}
