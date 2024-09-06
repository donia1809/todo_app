String getFullPath(String imageName)
{
  return 'assets/images/$imageName';
}


bool isValidPhoneNumber(String phoneNumber)
{
  return RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
      .hasMatch(phoneNumber);
}

bool isValidEmail(String email){
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isValidPassword(String password){
  if(password.length<6){
    return false;
  }
  return true;
}