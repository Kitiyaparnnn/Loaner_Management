class LoginModel{
  String? username;
  String? password;
  bool isRemember = false;

  @override
  String toString() =>  'username: $username, password: $password, Remember: $isRemember';
}