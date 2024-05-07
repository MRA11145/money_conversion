import 'package:flutter_test/flutter_test.dart';
import 'package:pay2dc/model/model.dart';


void main() {
  group('Currency Model Test', () {
    test('Currency object creation', () {
      final currency = Currency('USD', 'United States Dollar');
      expect(currency.code, 'USD');
      expect(currency.name, 'United States Dollar');
    });
  });

  group('Conversion Model Test', () {
    test('Conversion object creation', () {
      final currency = Currency('USD', 'United States Dollar');
      final conversion = Conversion(currency, 100.0);
      expect(conversion.currency, currency);
      expect(conversion.amount, 100.0);
    });
  });
}
