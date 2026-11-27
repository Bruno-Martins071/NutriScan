import '../../domain/entities/history_entry.dart';

abstract final class HistoryEntryModel {
  static HistoryEntry fromMap(Map<String, Object?> map) {
    return HistoryEntry(
      id: map['id'] as int,
      productName: map['product_name'] as String,
      brand: (map['brand'] as String?) ?? '',
      verdict: HistoryVerdict.fromCode(map['verdict'] as String),
      barcode: map['barcode'] as String?,
      scannedAt: DateTime.parse(map['scanned_at'] as String),
    );
  }

  static Map<String, Object?> toMap(HistoryEntry entry) {
    return {
      if (entry.id != null) 'id': entry.id,
      'product_name': entry.productName.trim(),
      'brand': entry.brand.trim(),
      'verdict': entry.verdict.code,
      'barcode': entry.barcode,
      // Hora local em ISO 8601: ordena certo como texto no SQLite.
      'scanned_at': entry.scannedAt.toLocal().toIso8601String(),
    };
  }
}
