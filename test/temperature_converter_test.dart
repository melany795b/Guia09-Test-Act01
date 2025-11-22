import 'package:flutter_test/flutter_test.dart';
import 'package:guia09_test/temperature_converter.dart'; 

void main() {
  late TemperatureConverter converter;

  setUp(() {
    converter = TemperatureConverter();
  });

  group('Conversión Celsius a Fahrenheit', () {
    test('Convierte 0°C a 32°F', () {
      expect(converter.celsiusToFahrenheit(0), 32.0);
    });

    test('Convierte 100°C a 212°F', () {
      expect(converter.celsiusToFahrenheit(100), 212.0);
    });

    test('Convierte -40°C a -40°F', () {
      expect(converter.celsiusToFahrenheit(-40), -40.0);
    });
  });

  group('Conversión Fahrenheit a Celsius', () {
    test('Convierte 32°F a 0°C', () {
      expect(converter.fahrenheitToCelsius(32), 0.0);
    });

    test('Convierte 212°F a 100°C', () {
      expect(converter.fahrenheitToCelsius(212), 100.0);
    });

    test('Convierte -40°F a -40°C', () {
      expect(converter.fahrenheitToCelsius(-40), -40.0);
    });
  });
}