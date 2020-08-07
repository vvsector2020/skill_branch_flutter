class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;

  User._({String firstName, String lastName, String phone, String email});

  factory User({String name, String phone, String email}){
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone.isEmpty || email.isEmpty) throw Exception("phone or email is empty");

    return User._(
      firstName: _getFirstName(name),
      lastName: _getLastName(name),
      phone: checkPhone(phone),
      email: checkEmail(email),
    );

  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];
  static String checkPhone(String phone){
    String pattern = r"^(?:+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception("Enter a valid phone number starting with a + and containig 11 digits");
    }

    return phone;
  }

static String checkEmail(String email){
    //String pattern = r"^[a-z]@?[a-z].[a-z]";

    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    }
    //else if (!RegExp(pattern).hasMatch(email)) {
    //  throw Exception("Enter a valid email");
    //}

    return email;
  }
}