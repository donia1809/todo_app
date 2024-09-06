import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_application/database/collection/collection.dart';
import 'package:new_application/database/models/appUser.dart';

class AppAuthProvider extends ChangeNotifier
{
  UserCollection userCollection = UserCollection();
  User? authUser;
  AppUser? appUser;

  AppAuthProvider() {
    authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      signInWithUid(authUser!.uid);
    }
  }
  void signInWithUid(String uid)async {
    appUser = await userCollection.readUser(uid);
    notifyListeners();
  }
  bool isLoggedIn(){
    return authUser != null;
  }
  void login(User newUser){
    authUser = newUser;
  }
  void logout(){
    authUser = null;
    FirebaseAuth.instance.signOut();
  }
  Future<AppUser?> createUserWithEmailAndPassword(
      String email,
      String password,
      String fullName
      )async{

    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if(credential.user !=null){
      login(credential.user!);
      // insert user to fire store
      appUser = AppUser(
          authId: credential.user?.uid,
          fullName: fullName,
          email: email
      );
      var result = await userCollection.createUser(appUser!);// check if user created or there is an error
      return appUser!;
    }
    return null;
  }

  Future<AppUser?> signInWithEmailAndPassword(
      String email,
      String password
      )async{

    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if(credential.user !=null){
      login(credential.user!);
      //read user from database
      appUser = await userCollection.readUser(credential.user!.uid);

    }
    return appUser;
  }


}