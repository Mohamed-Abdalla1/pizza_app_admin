import 'dart:typed_data';

import 'models/models.dart';

abstract class PizzaRepo {
  Future<List<PizzaModel>> getPizzas();
  Future<String> sendImage(Uint8List file, String name);
  Future<void> setPizzaData(PizzaModel pizzaModel);
}
