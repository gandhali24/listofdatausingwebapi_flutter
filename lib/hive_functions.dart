import 'package:hive_flutter/hive_flutter.dart';

class HiveFunctions {

  static const String userHiveBox="User Box";
// Constant Name of Box where we will store details of user
  // Box which will use to store the things
  static final userBox = Hive.box(userHiveBox);
  // Create or add single data in hive
  static createUser(Map data) {
    userBox.add(data);
  }

  // Create or add multiple data in hive
  static addAllUser(List data) {
    userBox.addAll(data);
  }

  // Get All data  stored in hive
  static List getAllUsers() {
    final data = userBox.keys.map((key) {
      final value = userBox.get(key);
      return {"key": key, "image_url": value["image_url"], "title": value['title']};
    }).toList();

    return data.reversed.toList();
  }

  // Get data for particular user in hive
  static Map getUser(int key) {
    return userBox.get(key);
  }

  // update data for particular user in hive
  static updateUser(int key, Map data) {
    userBox.put(key, data);
  }

  // delete data for particular user in hive
  static deleteUser(int key) {
    return userBox.delete(key);
  }

  // delete data for particular user in hive
  static deleteAllUser(int key) {
    return userBox.deleteAll(userBox.keys);
  }

}

