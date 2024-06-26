import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_repository/src/entities/entity.dart';

class FirebasePizzaRepo implements PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  @override
  Future<List<PizzaModel>> getPizzas() async {
    try {
      return await pizzaCollection.get().then((value) => value.docs
          .map((e) => PizzaModel.fromEntity(PizzaEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> sendImage(Uint8List file, String name) async {
    try {
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(name);
      await firebaseStorageRef.putData(
          file, SettableMetadata(contentType: 'image/jpeg'));
      return firebaseStorageRef.getDownloadURL();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> setPizzaData(PizzaModel pizzaModel) async {
    try {
     await pizzaCollection
          .doc(pizzaModel.pizzaId)
          .set(pizzaModel.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
