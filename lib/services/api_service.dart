import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://futurex.lk/api';

  static Future<Map<String, dynamic>> checkStatus(int userId) async {
  try {
    print('📞 Calling checkstatus.php with userid: $userId');
    
    final response = await http.post(
      Uri.parse('$baseUrl/checkstatus.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userid': userId}),
    );

    print('📥 Response status code: ${response.statusCode}');
    print('📥 Response body: ${response.body}');
    
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('✅ Check Status Response: $responseData');
      return responseData;
    } else {
      throw Exception('Failed to check status. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ API Error - checkStatus: $e');
    rethrow;
  }
}
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Error - login: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> signup(
    String username, String email, String password, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to sign up. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Error - signup: $e');
      rethrow;
    }
  }

  // Optional: Method to get user details by ID
  static Future<Map<String, dynamic>> getUserDetails(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/getuser.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userid': userId}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API Error - getUserDetails: $e');
      rethrow;
    }
  }
}