import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:historium/model/entity/Entity.dart';

abstract class Helper<T extends Entity> {
  final _firestore = FirebaseFirestore.instance;

  Future <void> save(T entity) async {
    await _firestore
    .collection(collectionName)
    .doc(entity.id)
    .set(entityToMap(entity));
  }

  Future<T> load(String id) async {
    return entityFromMap(
      (
        await _firestore
        .collection(T.toString())
        .doc(id)
        .get()
      )
      .data()
    );
  }

  Future<void> delete(String id) async {
    await _firestore
    .collection(collectionName)
    .doc(id)
    .delete();
  }

  // Returs the name of the collection of this
  // entity
  // Can be overrided by the Helpers
  String get collectionName {
    return T.toString();
  }

  // These functions must be overrided by the
  // Helpers
  Map<String, dynamic> entityToMap(T entity);
  T entityFromMap(Map<String, dynamic> map);

}