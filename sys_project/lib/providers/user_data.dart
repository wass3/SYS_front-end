import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyToken = 'token';
  static const _keyUserId = 'user_id';
  static const _keyUserHandler = 'user_handler';
  static const _keyName = 'name';
  static const _keySurname = 'surname';
  static const _keyBiography = 'biography';
  static const _keyEmailAddress = 'email_address';
  static const _keyUserImg = 'user_img';

  // Guardar los datos del usuario
  static Future<void> saveUser({
    required String token,
    required int userId,
    required String userHandler,
    required String name,
    required String surname,
    required String biography,
    required String emailAddress,
    required String userImg,
  }) async {
    print('saveUser');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyToken, token);
    prefs.setInt(_keyUserId, userId);
    prefs.setString(_keyUserHandler, userHandler);
    prefs.setString(_keyName, name);
    prefs.setString(_keySurname, surname);
    prefs.setString(_keyBiography, biography);
    prefs.setString(_keyEmailAddress, emailAddress);
    prefs.setString(_keyUserImg, userImg);

    print('saveUser: $token, $userId, $userHandler, $name, $surname, $biography, $emailAddress, $userImg');
  }

  // Obtener los datos del usuario
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_keyToken)) {
      return {
        'token': prefs.getString(_keyToken),
        'userId': prefs.getInt(_keyUserId),
        'userHandler': prefs.getString(_keyUserHandler),
        'name': prefs.getString(_keyName),
        'surname': prefs.getString(_keySurname),
        'biography': prefs.getString(_keyBiography),
        'emailAddress': prefs.getString(_keyEmailAddress),
        'userImg': prefs.getString(_keyUserImg),
      };
    }
    return null;
  }

  // Limpiar datos del usuario (logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyToken);
    prefs.remove(_keyUserId);
    prefs.remove(_keyUserHandler);
    prefs.remove(_keyName);
    prefs.remove(_keySurname);
    prefs.remove(_keyBiography);
    prefs.remove(_keyEmailAddress);
    prefs.remove(_keyUserImg);
  }
}
