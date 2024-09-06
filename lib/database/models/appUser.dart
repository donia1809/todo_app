class AppUser
{
  String? authId;
  String? fullName ;
  String? email;

  //first constructor
  AppUser({
    this.authId,
    this.fullName,
    this.email
  });

  //second constructor
  AppUser.FromFirestore(Map <String,dynamic>? data):this
    (
      authId: data? ['authId'],
      fullName: data? ['fullName'],
      email: data? ['email']
    );

  Map<String,dynamic> toFireStore(){
    return {
      "authId" : authId,
      "fullName" : fullName,
      "email" : email,
    };
}
}