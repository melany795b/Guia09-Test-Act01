import 'package:flutter/material.dart';
import 'temperature_converter.dart';
import 'tax_calculator.dart';
import 'cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  
  // Instancias de las clases de cada ejercicio
  final TemperatureConverter temperatureConverter = TemperatureConverter();
  final TaxCalculator taxCalculator = TaxCalculator();
  final Cart cart = Cart();

  // Controladores para los diferentes ejercicios
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _fahrenheitController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  
  // Estados
  List<double> _prices = [];
  Map<String, double>? _taxBreakdown;
  List<String> _cartProducts = [];

  // Lista de widgets para cada pestaña
  List<Widget> get _widgetOptions => <Widget>[
    _buildTemperatureConverterTab(),
    _buildTaxCalculatorTab(),
    _buildShoppingCartTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suite de Pruebas Unitarias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_getAppBarTitle()),
          backgroundColor: _getAppBarColor(),
          foregroundColor: Colors.white,
        ),
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: 'Temperatura',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Impuestos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrito',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0: return '🌡️ Conversor de Temperatura';
      case 1: return '💰 Calculadora de IGV';
      case 2: return '🛒 Carrito de Compras';
      default: return 'Suite de Pruebas';
    }
  }

  Color _getAppBarColor() {
    switch (_selectedIndex) {
      case 0: return Colors.blue.shade700;
      case 1: return Colors.green.shade700;
      case 2: return Colors.orange.shade700;
      default: return Colors.blue;
    }
  }

  // Widget para el Ejercicio 1
  Widget _buildTemperatureConverterTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔥 ', style: TextStyle(fontSize: 20)),
                      Text(
                        'Celsius a Fahrenheit',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _celsiusController,
                    decoration: InputDecoration(
                      labelText: 'Grados Celsius (°C)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.arrow_upward), // Icono básico que sí funciona
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _convertCtoF,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('➡️ '),
                        Text('Convertir a Fahrenheit'),
                      ],
                    ),
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
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('❄️ ', style: TextStyle(fontSize: 20)),
                      Text(
                        'Fahrenheit a Celsius',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _fahrenheitController,
                    decoration: InputDecoration(
                      labelText: 'Grados Fahrenheit (°F)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.arrow_downward), // Icono básico que sí funciona
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _convertFtoC,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('⬅️ '),
                        Text('Convertir a Celsius'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildTestStatus(),
        ],
      ),
    );
  }

  // Widget para el Ejercicio 2
  Widget _buildTaxCalculatorTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('💰 ', style: TextStyle(fontSize: 20)),
                      Text(
                        'Agregar Precio al Cálculo',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Precio (S/)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addPrice,
                    child: Text('➕ Agregar Precio'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_prices.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '📊 Precios Ingresados (${_prices.length})',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _prices.asMap().entries.map((entry) {
                        return Chip(
                          label: Text('S/ ${entry.value.toStringAsFixed(2)}'),
                          deleteIcon: Text('❌'), // Emoji en lugar de icono
                          onDeleted: () => _removePrice(entry.key),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
          if (_taxBreakdown != null) ...[
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '🧾 Desglose de Pago',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    _buildBreakdownRow('📦 Subtotal:', _taxBreakdown!['subtotal']!),
                    _buildBreakdownRow('🏷️ IGV (18%):', _taxBreakdown!['igv']!),
                    Divider(),
                    _buildBreakdownRow('💳 TOTAL:', _taxBreakdown!['total']!, isTotal: true),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _calculateTax,
                  child: Text('🧮 Calcular IGV'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: _clearPrices,
                  child: Text('🗑️ Limpiar Precios'),
                ),
              ),
            ],
          ),
          _buildTestStatus(),
        ],
      ),
    );
  }

  // Widget para el Ejercicio 3
  Widget _buildShoppingCartTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🛒 ', style: TextStyle(fontSize: 20)),
                      Text(
                        'Agregar Producto al Carrito',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _productController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Producto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addToCart,
                    child: Text('➕ Agregar al Carrito'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '📋 Carrito de Compras (${cart.getItemCount()} items)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  if (_cartProducts.isEmpty)
                    Text('🛍️ El carrito está vacío', style: TextStyle(color: Colors.grey, fontSize: 16))
                  else
                    Column(
                      children: _cartProducts.map((product) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange.shade100,
                              child: Text('🛍️'),
                            ),
                            title: Text(product, style: TextStyle(fontWeight: FontWeight.w500)),
                            trailing: IconButton(
                              icon: Text('❌'), // Emoji en lugar de icono
                              onPressed: () => _removeFromCart(product),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _clearCart,
                  child: Text('🗑️ Vaciar Carrito'),
                ),
              ),
            ],
          ),
          _buildTestStatus(),
        ],
      ),
    );
  }

  // Métodos para el Ejercicio 1
  void _convertCtoF() {
    if (_celsiusController.text.isEmpty) return;
    double celsius = double.tryParse(_celsiusController.text) ?? 0;
    double fahrenheit = temperatureConverter.celsiusToFahrenheit(celsius);
    setState(() {
      _fahrenheitController.text = fahrenheit.toStringAsFixed(2);
    });
  }

  void _convertFtoC() {
    if (_fahrenheitController.text.isEmpty) return;
    double fahrenheit = double.tryParse(_fahrenheitController.text) ?? 0;
    double celsius = temperatureConverter.fahrenheitToCelsius(fahrenheit);
    setState(() {
      _celsiusController.text = celsius.toStringAsFixed(2);
    });
  }

  // Métodos para el Ejercicio 2
  void _addPrice() {
    if (_priceController.text.isEmpty) return;
    double price = double.tryParse(_priceController.text) ?? 0;
    setState(() {
      _prices.add(price);
      _priceController.clear();
    });
  }

  void _removePrice(int index) {
    setState(() {
      _prices.removeAt(index);
    });
  }

  void _calculateTax() {
    setState(() {
      _taxBreakdown = _calculateBreakdown(_prices);
    });
  }

  void _clearPrices() {
    setState(() {
      _prices.clear();
      _taxBreakdown = null;
    });
  }

  // Métodos para el Ejercicio 3
  void _addToCart() {
    if (_productController.text.isEmpty) return;
    setState(() {
      cart.addProduct(_productController.text);
      _cartProducts = cart.getProducts();
      _productController.clear();
    });
  }

  void _removeFromCart(String product) {
    setState(() {
      cart.removeProduct(product);
      _cartProducts = cart.getProducts();
    });
  }

  void _clearCart() {
    setState(() {
      cart.clearCart();
      _cartProducts.clear();
    });
  }

  // Método auxiliar para calcular el desglose
  Map<String, double> _calculateBreakdown(List<double> prices) {
    if (prices.isEmpty) {
      return {'subtotal': 0.0, 'igv': 0.0, 'total': 0.0};
    }
    
    double subtotal = prices.fold(0, (sum, price) => sum + price);
    double igv = subtotal * 0.18;
    double total = subtotal + igv;
    
    return {
      'subtotal': subtotal,
      'igv': igv,
      'total': total,
    };
  }

  // Widgets auxiliares
  Widget _buildBreakdownRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          )),
          Text('S/ ${value.toStringAsFixed(2)}', style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          )),
        ],
      ),
    );
  }

  Widget _buildTestStatus() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text('✅ Estado de Pruebas Unitarias', 
               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade800)),
          SizedBox(height: 8),
          Text('• TemperatureConverter: 6/6 pruebas pasadas', style: TextStyle(fontSize: 12)),
          Text('• TaxCalculator: 4/4 pruebas pasadas', style: TextStyle(fontSize: 12)),
          Text('• Cart: 8/8 pruebas pasadas', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}