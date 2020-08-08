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

  User registerUser2(String name, String phone, String email,
      [String type = "email"]) {
    User user = User(name: name, phone: phone, email: email);
    if (type == "phone") user.typeLogin = type;
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this name already exist");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = this.registerUser2(fullName, '', email);
    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = registerUser2(fullName, phone, "");
    return user;
  }

  User findUserInFriends(String fullName, User user) {
    User _f2User;

    _f2User = getUserByFullName(fullName);

    _f2User.friends.forEach((friend) {
      if (friend == user) {
        return friend;
      }
    });
    throw Exception("${_f2User.login} is not a friend of the login");
  }

  List<User> importUsers(List<String> users) {
    List<User> usersList = <User>[];

    users.forEach((user) {
      List data = user.split(";");
      User u = this.registerUser2(data[0], data[2], data[1]);
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
    //User user = getUserByLogin(login);
    users[login].addFriend(friends);
  }
}
