class Allergy {
  const Allergy({
    this.id,
    this.code,
    required this.name,
    this.isCustom = false,
  });

  final int? id;
  final String? code;
  final String name;
  final bool isCustom;

  @override
  bool operator ==(Object other) =>
      other is Allergy &&
      other.id == id &&
      other.code == code &&
      other.name == name &&
      other.isCustom == isCustom;

  @override
  int get hashCode => Object.hash(id, code, name, isCustom);
}
