import './modules/user.dart';
import 'package:FlutterGalleryApp/string_utils.dart';

class UserHolder {
  Map<String, User> users = {};
  Map<String, User> usersName = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      usersName[user.name] = user;
    } else {
      throw Exception("A user with this name already exist");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, phone: "+00000000000", email: email);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      usersName[user.name] = user;
    } else {
      throw Exception("A user with this email already exist");
    }

    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone, email: "email@email.ru");
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      usersName[user.name] = user;
    } else {
      throw Exception("A user with this phone  already exist");
    }

    return user;
  }

  User findUserInFriends(String fullName, User user) {
    String _fName = fullName.split(" ")[0].capitalize();
    String _sName = fullName.split(" ")[1].capitalize();
    String _fullName = _fName + " " + _sName;
    User _findUser;
    user.friends.forEach((friend) {
      if (friend.name == _fullName) {
        _findUser = friend;
      }
    });
    if (_findUser != null) {
      return _findUser;
    } else {
      throw Exception("${user.login} is not a friend of the login");
    }
  }

  /**
   * *importUsers
Необходимо реализовать метод importUsers объекта (object UserHolder) для импорта пользователей из списка строк
+3
Аргумент принимает список строк где разделителем полей является ";" данные перечислены в следующем порядке. Метод должен вернуть коллекцию User.

Пример csv:
"""
Eric Freeman;
eric.freeman@gmail.com;
+1 (231) 076-1449;
"""
   */
}
