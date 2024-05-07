import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String baseUrl = 'https://openexchangerates.org/api/latest.json';
  static const String apiKey = 'bb8e95c3f6954510b32af828084dd39d';

  Future<Map<String, dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('$baseUrl?app_id=$apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch exchange rates');
    }
  }

}
