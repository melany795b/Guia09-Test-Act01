import 'package:flutter_test/flutter_test.dart';
import 'package:guia09_test/tax_calculator.dart';


void main() {
  late TaxCalculator taxCalculator;


  setUp(() {
    taxCalculator = TaxCalculator();
  });


  group('Cálculo de IGV', () {
    test('Calcula IGV para lista de precios [100.0, 250.0, 50.0]', () {
      List<double> prices = [100.0, 250.0, 50.0];
      double result = taxCalculator.calculateTotalIGV(prices);
     
      // Subtotal: 400.0, IGV: 400 * 0.18 = 72.0
      expect(result, 72.0);
    });


    test('Calcula IGV para lista vacía', () {
      List<double> prices = [];
      double result = taxCalculator.calculateTotalIGV(prices);
     
      expect(result, 0.0);
    });


    test('Calcula IGV para un solo precio', () {
      List<double> prices = [100.0];
      double result = taxCalculator.calculateTotalIGV(prices);
     
      // IGV: 100 * 0.18 = 18.0
      expect(result, 18.0);
    });
  });


  group('Cálculo de total con IGV', () {
    test('Calcula total con IGV para [100.0, 250.0, 50.0]', () {
      List<double> prices = [100.0, 250.0, 50.0];
      double result = taxCalculator.calculateTotalWithIGV(prices);
     
      // Subtotal: 400.0, Total: 400 * 1.18 = 472.0
      expect(result, 472.0);
    });


    test('Calcula total con IGV para lista vacía', () {
      List<double> prices = [];
      double result = taxCalculator.calculateTotalWithIGV(prices);
     
      expect(result, 0.0);
    });
  });


  group('Desglose completo', () {
    test('Calcula desglose para [100.0, 250.0, 50.0]', () {
      List<double> prices = [100.0, 250.0, 50.0];
      Map<String, double> breakdown = taxCalculator.calculateBreakdown(prices);
     
      expect(breakdown['subtotal'], 400.0);
      expect(breakdown['igv'], 72.0);
      expect(breakdown['total'], 472.0);
    });


    test('Calcula desglose para lista vacía', () {
      List<double> prices = [];
      Map<String, double> breakdown = taxCalculator.calculateBreakdown(prices);
     
      expect(breakdown['subtotal'], 0.0);
      expect(breakdown['igv'], 0.0);
      expect(breakdown['total'], 0.0);
    });
  });
}
