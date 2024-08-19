String getFullPath(String imageName)
{
  return 'assets/images/$imageName';
}


bool isValidPhoneNumber(String phoneNumber)
{
  return RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
      .hasMatch(phoneNumber);
}


bool isValidEmail(String email)
{
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(email);
}


bool isValidPassword(String password)
{
  return RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
      .hasMatch(password);
}
