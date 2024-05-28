


import '../entities/marcos.entity.dart';

class Macros {
   int calories;
  int proteins;
  int fat;
  int carbs;
  Macros(
      {required this.calories,
      required this.proteins,
      required this.fat,
      required this.carbs});

 static final empty = Macros(
		calories: 0,
    proteins: 0,
    fat: 0,
    carbs: 0,
	);
  MacrosEntity toEntity() {
    return MacrosEntity(
      calories: calories,
      proteins: proteins,
      fat: fat,
      carbs: carbs,
      
    );
  }

  static Macros fromEntity(MacrosEntity macrosEntity) {
    return Macros(
      calories: macrosEntity.calories,
      proteins: macrosEntity.proteins,
      fat: macrosEntity.fat,
      carbs: macrosEntity.carbs,
    );
  }

  
}