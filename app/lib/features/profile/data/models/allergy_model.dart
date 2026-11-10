import '../../domain/entities/allergy.dart';

abstract final class AllergyModel {
  static Allergy fromMap(Map<String, Object?> map) {
    return Allergy(
      id: map['id'] as int,
      code: map['code'] as String?,
      name: map['name'] as String,
      isCustom: (map['is_custom'] as int) == 1,
    );
  }

  static Map<String, Object?> toMap(Allergy allergy) {
    return {
      if (allergy.id != null) 'id': allergy.id,
      'code': allergy.code,
      'name': allergy.name,
      'is_custom': allergy.isCustom ? 1 : 0,
    };
  }
}
