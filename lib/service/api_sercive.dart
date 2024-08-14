import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://143.244.131.156:8000';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<void> _deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<Map<String, dynamic>?> signup(String email, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Return the entire response body
      } else {
        print('Signup failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during signup: $e');
      rethrow;
    }
    return null;
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['token'] != null) {
          await _saveToken(data['token']);
        }
        return data;
      } else {
        print('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
    return null;
  }

  Future<String?> googleLogin(String idToken, String email, String pictureUrl) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/googlelogin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idToken': idToken, 'email': email, 'pictureUrl': pictureUrl}),      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final token = data['token'] as String?;
        if (token != null) {
          await _saveToken(token);
          return token;
        }
      } else {
        print('Google login failed with status: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print('Error during Google login: $e');
      rethrow;
    }
  }

  Future<bool> createSong(String title, String artist, String lyrics) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'title': title, 'artist': artist, 'lyrics': lyrics}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Create song failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during song creation: $e');
      return false;
    }
  }

  Future<bool> createCustomSong(String customData) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/createcustom'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'customData': customData}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Create custom song failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during custom song creation: $e');
      return false;
    }
  }

  Future<http.Response?> fetchUserSongs() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/usersongs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        print('Fetch user songs failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during fetching user songs: $e');
      rethrow;
    }
  }
}
