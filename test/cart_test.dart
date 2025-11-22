import 'package:flutter_test/flutter_test.dart';
import 'package:guia09_test/cart.dart';  // ← ¡CORREGIR ESTA LÍNEA!

void main() {
  late Cart cart;

  setUp(() {
    cart = Cart();
  });

  group('Carrito de Compras - Funcionalidades Básicas', () {
    test('Carrito inicia vacío', () {
      expect(cart.getItemCount(), 0);
    });

    test('Añadir producto incrementa el contador', () {
      cart.addProduct('Manzana');
      expect(cart.getItemCount(), 1);
    });

    test('Añadir múltiples productos', () {
      cart.addProduct('Manzana');
      cart.addProduct('Pan');
      cart.addProduct('Leche');
      expect(cart.getItemCount(), 3);
    });

    test('Eliminar producto decrementa el contador', () {
      cart.addProduct('Manzana');
      cart.addProduct('Pan');
      cart.removeProduct('Manzana');
      expect(cart.getItemCount(), 1);
    });

    test('Verificar productos en el carrito', () {
      cart.addProduct('Manzana');
      cart.addProduct('Pan');
      expect(cart.containsProduct('Manzana'), true);
      expect(cart.containsProduct('Pan'), true);
      expect(cart.containsProduct('Leche'), false);
    });

    test('Obtener lista de productos', () {
      cart.addProduct('Manzana');
      cart.addProduct('Pan');
      List<String> products = cart.getProducts();
      expect(products, contains('Manzana'));
      expect(products, contains('Pan'));
      expect(products.length, 2);
    });

    test('Limpiar carrito vacía la lista', () {
      cart.addProduct('Manzana');
      cart.addProduct('Pan');
      cart.clearCart();
      expect(cart.getItemCount(), 0);
    });

    test('Eliminar producto no existente no causa error', () {
      cart.addProduct('Manzana');
      cart.removeProduct('ProductoInexistente');
      expect(cart.getItemCount(), 1);
    });
  });
}