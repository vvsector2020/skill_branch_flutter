import '../string_utils.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone == null) phone = "";
    if (email == null) email = "";
    if (phone.isEmpty && email.isEmpty)
      throw Exception("phone and email is empty");

    return User._(
      firstName: _getFirstName(name),
      lastName: _getLastName(name),
      phone: checkPhone(phone),
      email: checkEmail(email),
    );
  }

  static String _getLastName(String userName) =>
      userName.split(" ")[1].capitalize();

  static String _getFirstName(String userName) =>
      userName.split(" ")[0].capitalize();

  static String checkPhone(String phone) {
    if (phone.isEmpty) return phone;
    String pattern = r"^(?:[+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containig 11 digits");
    }

    return phone;
  }

  static String checkEmail(String email) {
    if (email.isEmpty) return email;
    String pattern = r"^[a-zA-Z0-9.]+\@[a-zA-Z0-9]+\.[a-zA-Z0-9]+";

    if (email == null) {
      throw Exception("Enter don't empty email");
    } else if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Enter a valid email");
    }

    return email;
  }

  String get login {
    if (_type == LoginType.phone) {
      return phone;
    } else {
      return email;
    }
  }

  set typeLogin(String type) {
    if (type == "phone") {
      _type = LoginType.phone;
    } else {
      _type = LoginType.email;
    }
  }

  @override
  bool operator ==(Object object) {
    if (object == null) return false;

    if (object is User) {
      return object._firstName == this._firstName &&
          object._lastName == this._lastName &&
          (object.phone == this.phone || object.email == email);
    }
    return false;
  }

  String get name =>
      this._firstName.capitalize() + " " + this._lastName.capitalize();

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo {
    Map info = {};
    info['name'] = this.name;
    info['email'] = this.email;
    info['phone'] = this.phone;
    info['friends'] = this.friends.toList();
    info['_firstName'] = this._firstName;
    info['_lastName'] = this._lastName;

    return info.toString();
  }

  @override
  String toString() {
    Map str = {};
    str['name'] = this.name;
    str['email'] = this.email;
    return str.toString();
  }
}

mixin UserUtils {
  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
