
import '../../data/models/user.dart';

class CurrentUser {
  static Future<void> saveUser(String? user) async {
    //await Helpers.storage.write(key: StorageKeys.user, value: user);
  }

  static Future<User?> get getUser async {
    var user = ''; //await Helpers.storage.read(key: StorageKeys.token);

    return null;
  }

  static Future<bool> get hasUser async {
    return true;//Helpers.storage.containsKey(key: StorageKeys.token);
  }

  static Future<void> delete() async {
    //await Helpers.storage.delete(key: StorageKeys.token);
  }
}

class Token {
  static Future<void> persistToken(String token) async {
    await token;//Helpers.storage.write(key: StorageKeys.token, value: token);
  }

  static Future<String?> get getToken async {
    var token = ''; //await Helpers.storage.read(key: StorageKeys.token);

    return token;
  }

  static Future<bool> get hasToken async {
    return true;//Helpers.storage.containsKey(key: StorageKeys.token);
  }

  static Future<void> delete() async {
    //await Helpers.storage.delete(key: StorageKeys.token);
  }
}