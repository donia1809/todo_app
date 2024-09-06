import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_application/database/models/appUser.dart';

class UserCollection
{
  CollectionReference<AppUser> getUsersCollection()
  {
    var db = FirebaseFirestore.instance;
    return db.collection("users")
        .withConverter(
      fromFirestore: (snapshot, _) => AppUser.FromFirestore(snapshot.data()) ,
      toFirestore: (model, _) => model.toFireStore(),
    );
  }

  Future<void> createUser(AppUser user)
   { //write user in user collection
    return getUsersCollection()
        .doc(user.authId)
        .set(user);
  }


  Future<AppUser?> readUser(String uid) async{
    var doc = getUsersCollection()
        .doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }

}
