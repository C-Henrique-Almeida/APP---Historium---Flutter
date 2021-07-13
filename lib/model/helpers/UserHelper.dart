import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:historium/model/entity/User.dart';

class UserHelper {
	final _firestore = FirebaseFirestore.instance;

	static const collectionName = 'User';

  Future <void> save(User user) async {
    await _firestore
    .collection(collectionName)
    .doc(user.id)
    .set(user.toMap());
  }

  Future<User> load(String id) async {
		final userMap = (
			await _firestore
			.collection(collectionName)
			.doc(id)
			.get()
		).data();

    return User.fromMap(userMap);
  }

  Future<void> delete(String id) async {
    await _firestore
    .collection(collectionName)
    .doc(id)
    .delete();
  }
}