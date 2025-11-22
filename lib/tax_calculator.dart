class TaxCalculator {
  static const double igvRate = 0.18; // 18% de IGV
 
  /// Calcula el IGV total para una lista de precios
  double calculateTotalIGV(List<double> prices) {
    if (prices.isEmpty) return 0.0;
   
    double subtotal = prices.fold(0, (sum, price) => sum + price);
    return subtotal * igvRate;
  }
 
  /// Calcula el total a pagar (subtotal + IGV)
  double calculateTotalWithIGV(List<double> prices) {
    if (prices.isEmpty) return 0.0;
   
    double subtotal = prices.fold(0, (sum, price) => sum + price);
    return subtotal * (1 + igvRate);
  }
 
  /// Calcula el desglose completo: subtotal, IGV y total
  Map<String, double> calculateBreakdown(List<double> prices) {
    if (prices.isEmpty) {
      return {
        'subtotal': 0.0,
        'igv': 0.0,
        'total': 0.0,
      };
    }
   
    double subtotal = prices.fold(0, (sum, price) => sum + price);
    double igv = subtotal * igvRate;
    double total = subtotal + igv;
   
    return {
      'subtotal': subtotal,
      'igv': igv,
      'total': total,
    };
  }
}
