import 'dart:convert';
import 'user.dart';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchUserData() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<User> createUser(User user) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user');
  }
}
