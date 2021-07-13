import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:historium/model/entity/ReadingProgress.dart';
import 'package:historium/model/entity/User.dart';
import 'package:historium/model/helpers/BookHelper.dart';

class UserHelper {
	final _firestore = FirebaseFirestore.instance;
	final _bookHelper = BookHelper();

	static const collectionName = 'User';

  Future <void> save(User user) async {
		final ref = _firestore
    .collection(collectionName)
    .doc(user.id);

		if(ref.id == null)
    	await ref.set(user.toMap());
		else
			await ref.update(user.toMap());
  }

  Future<User> load(String id, {eagerLoading = false}) async {
		final ref = _firestore
			.collection(collectionName)
			.doc(id);

		final userMap = (
			await ref
			.get()
		).data();

		final user = User.fromMap(userMap);
		user.id = ref.id;

		if(eagerLoading) {
			user.library = [];

			for(Map<String, dynamic> map in userMap['library']) {
				var readingProgress = ReadingProgress();

				readingProgress.readPages = map['readPages'];
				readingProgress.book = await _bookHelper.load(map['book']);

				user.library.add(readingProgress);
			}
		}
		else user.library = null;

    return user;
  }

  Future<void> delete(String id) async {
    await _firestore
    .collection(collectionName)
    .doc(id)
    .delete();
  }
}