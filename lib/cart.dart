class Cart {
  List<String> _products = [];
  
  void addProduct(String product) {
    _products.add(product);
  }
  
  void removeProduct(String product) {
    _products.remove(product);
  }
  
  int getItemCount() {
    return _products.length;
  }
  
  List<String> getProducts() {
    return List.from(_products);
  }
  
  void clearCart() {
    _products.clear();
  }
  
  bool containsProduct(String product) {
    return _products.contains(product);
  }
}