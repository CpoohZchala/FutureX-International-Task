import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Storage {
  static const String userIdKey = 'user_id';
  static const String userDataKey = 'user_data';

  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(userIdKey, userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
  }

  // User ID එක terminal එකට print කිරීම
  static Future<void> printUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(userIdKey);
      
      if (userId != null) {
        print('✅ Stored User ID: $userId');
      } else {
        print('❌ No User ID found in local storage');
      }
    } catch (e) {
      print('❌ Error retrieving User ID: $e');
    }
  }

  // User data save කිරීම 
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = userData['userid'];
      
      // User ID save කිරීම
      if (userId != null) {
        await prefs.setInt(userIdKey, userId);
      }
      
      // User data JSON String ලෙස save කිරීම
      final userDataJson = json.encode(userData);
      await prefs.setString(userDataKey, userDataJson);
      
      print('✅ User data saved successfully: $userData');
    } catch (e) {
      print('❌ Error saving user data: $e');
    }
  }

  // User data ලබාගැනීම
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataJson = prefs.getString(userDataKey);
      
      if (userDataJson != null) {
        return json.decode(userDataJson);
      }
      return null;
    } catch (e) {
      print('❌ Error retrieving user data: $e');
      return null;
    }
  }
  
  // Old keys cleanup කිරීම
static Future<void> cleanupOldKeys() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userid'); 
    await prefs.remove('userId'); 
    await prefs.remove('user');   
    
    print('✅ Cleaned up old storage keys');
  } catch (e) {
    print('❌ Error cleaning up old keys: $e');
  }
}

  // User data clear කිරීම
  static Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(userDataKey);
      print('✅ User data cleared from local storage');
    } catch (e) {
      print('❌ Error clearing user data: $e');
    }
  }

  static Future<void> printAllStoredData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      
      print('=== LOCAL STORAGE CONTENTS ===');
      
      if (allKeys.isEmpty) {
        print('No data found in local storage');
      } else {
        for (String key in allKeys) {
          final value = prefs.get(key);
          print('$key: $value');
        }
      }
      
      print('=============================');
    } catch (e) {
      print('❌ Error reading storage contents: $e');
    }
  }

  // Specific user ID එකක් තිබේදැයි check කිරීම
  static Future<bool> hasUserId(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUserId = prefs.getInt(userIdKey);
      return storedUserId == userId;
    } catch (e) {
      print('❌ Error checking user ID: $e');
      return false;
    }
  }
}


