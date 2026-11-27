/// Resultado do semáforo no momento da leitura.
enum HistoryVerdict {
  safe('safe'),
  attention('attention'),
  containsAllergen('contains_allergen');

  const HistoryVerdict(this.code);

  /// Valor gravado no banco.
  final String code;

  static HistoryVerdict fromCode(String code) => HistoryVerdict.values
      .firstWhere((verdict) => verdict.code == code, orElse: () => attention);
}

/// Um produto lido e guardado no histórico (F07).
class HistoryEntry {
  const HistoryEntry({
    this.id,
    required this.productName,
    this.brand = '',
    required this.verdict,
    required this.scannedAt,
    this.barcode,
  });

  final int? id;
  final String productName;
  final String brand;
  final HistoryVerdict verdict;
  final DateTime scannedAt;
  final String? barcode;

  HistoryEntry copyWith({int? id}) {
    return HistoryEntry(
      id: id ?? this.id,
      productName: productName,
      brand: brand,
      verdict: verdict,
      scannedAt: scannedAt,
      barcode: barcode,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is HistoryEntry &&
      other.id == id &&
      other.productName == productName &&
      other.brand == brand &&
      other.verdict == verdict &&
      other.scannedAt == scannedAt &&
      other.barcode == barcode;

  @override
  int get hashCode =>
      Object.hash(id, productName, brand, verdict, scannedAt, barcode);
}
