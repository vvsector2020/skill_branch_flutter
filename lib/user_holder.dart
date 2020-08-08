import './models/user.dart';
import 'package:FlutterGalleryApp/string_util.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exist");
    }
  }

  User registerUser2(String name, String phone, String email) {
    String _name = name.trim();
    String _phone = phone.trim();
    String _email = email.trim();
    User user = User(name: _name, phone: _phone, email: _email);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this name already exist");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = registerUser2(fullName, '', email);
    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = registerUser2(fullName, phone, "");
    return user;
  }

  User findUserInFriends(String login, User user) {
    User _f2User = users[login];

    for (final friend in _f2User.friends) {
      if (friend.name == user.name) return friend;
    }
    throw Exception("${_f2User.login} is not a friend of the login");
  }

  List<User> importUsers(List<String> users) {
    List<User> usersList = <User>[];

    users.forEach((user) {
      List data = user.split(";");
      User u = registerUser2(data[0], data[2], data[1]);
      usersList.add(u);
    });
    return usersList;
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  User getUserByFullName(String fullName) {
    users.forEach((login, user) {
      print(fullName);
      print(user);
      if (user.name == fullName) return user;
    });
    throw Exception("User not found");
  }

  void setFriends(String login, List<User> friends) {
    users[login].addFriend(friends);
  }
}
