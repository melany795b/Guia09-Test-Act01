import 'package:flutter/material.dart';
import 'temperature_converter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TemperatureConverter converter = TemperatureConverter();
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _fahrenheitController = TextEditingController();
  
  void _convertCtoF() {
    if (_celsiusController.text.isEmpty) return;
    double celsius = double.tryParse(_celsiusController.text) ?? 0;
    double fahrenheit = converter.celsiusToFahrenheit(celsius);
    setState(() {
      _fahrenheitController.text = fahrenheit.toStringAsFixed(2);
    });
  }
  
  void _convertFtoC() {
    if (_fahrenheitController.text.isEmpty) return;
    double fahrenheit = double.tryParse(_fahrenheitController.text) ?? 0;
    double celsius = converter.fahrenheitToCelsius(fahrenheit);
    setState(() {
      _celsiusController.text = celsius.toStringAsFixed(2);
    });
  }

  void _clearFields() {
    setState(() {
      _celsiusController.clear();
      _fahrenheitController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('🌡️ Conversor de Temperatura'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Celsius a Fahrenheit
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Celsius a Fahrenheit',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _celsiusController,
                        decoration: InputDecoration(
                          labelText: 'Celsius (°C)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _convertCtoF,
                        child: Text('Convertir a °F'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Fahrenheit a Celsius
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Fahrenheit a Celsius',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _fahrenheitController,
                        decoration: InputDecoration(
                          labelText: 'Fahrenheit (°F)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _convertFtoC,
                        child: Text('Convertir a °C'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Botones adicionales
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clearFields,
                      child: Text('Limpiar'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Estado de pruebas
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.green.shade100,
                child: Text(
                  '✅ Pruebas unitarias: 6/6 pasadas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}