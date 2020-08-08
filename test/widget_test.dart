// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:unittest/unittest.dart';

// import 'package:skill_branch_flutter/main.dart';
// import 'package:skill_branch_flutter/user_holder.dart';

import '../lib/modules/user.dart';
import '../lib/user_holder.dart';

void main() {
  UserHolder holder;

  setUp(() {
    holder = UserHolder();
  });

  tearDownAll(() {
    holder = null;
  });

  test('registerUser', () {
    holder.registerUser("SkiLl DRanch", "+98988021456", "popkadur@tm.ur");

    expect("popkadur@tm.ur", holder.users["popkadur@tm.ur"].login);
    expect("popkadur@tm.ur", holder.users["popkadur@tm.ur"].email);
    expect("+98988021456", holder.users["popkadur@tm.ur"].phone);
    expect("Skill Dranch", holder.users["popkadur@tm.ur"].name);
  });

  test('registerUserByEmail', () {
    User user1 = holder.registerUserByEmail("SkiLl DRanch", "popkadur@tm.ur");
    expect("popkadur@tm.ur", user1.login);
    expect("popkadur@tm.ur", user1.email);
    expect("+00000000000", user1.phone);
    expect("Skill Dranch", user1.name);
  });

  test('registerUserByPhone', () {
    User user1 = holder.registerUserByPhone("SkiLl DRanch", "+798988077777");
    expect("email@email.ru", user1.login);
    expect("email@email.ru", user1.email);
    expect("+798988077777", user1.phone);
    expect("Skill Dranch", user1.name);
  });

  test('checkUserFriendShips', () {
    User user1 = holder.registerUserByEmail("SkiLl DRanch", "popkadur@tm.ur");
    User user2 = holder.registerUserByEmail("SkiLl DRanch2", "email2");
    User user3 = holder.registerUserByEmail("SkiLl DR2", "email3");

    user1.addFriend([user2, user3]);

    expect(user1.friends.contains(user2), isTrue);
    expect(user1.friends.contains(user3), isTrue);
    user1.removeFriend(user2);
    expect(false, user1.friends.contains(user2));
    expect(user3, holder.findUserInFriends("Skill DR2", user1));
    expect(() => holder.findUserInFriends("SkiLl DRanch2", user1),
        throwsA(isException));
  });

  test('importUser', () {
    List<String> test_data = [
      "Eric Freeman; eric.freeman@gmail.com; +1 (231) 076-1449;",
      "Eric Freeman1; eric1.freeman@gmail.com; +2 (231) 076-1449;",
      "Eric Freeman2; eric2.freeman@gmail.com; +3 (231) 076-1449;",
      "Eric Freeman3; eric3.freeman@gmail.com; +4 (231) 076-1449;",
      "Eric Freeman4; eric4.freeman@gmail.com; +5 (231) 076-1449;",
    ];

    List<User> usersList;
    usersList = holder.importUsers(test_data);
    User user1 = User(
        name: "Eric Freeman",
        email: "eric.freeman@gmail.com",
        phone: "+1 (231) 076-1449");

    expect(usersList, isList);
    expect(usersList[0], user1);
    expect(usersList.length, 5);
  });
}
