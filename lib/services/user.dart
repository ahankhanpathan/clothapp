import 'dart:convert';
import 'dart:io';

class User {
  String username;
  String password;

  User({required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class UserRepository {
  final String filePath;

  UserRepository(this.filePath);

  Future<void> saveUser(User user) async {
    final file = File(filePath);
    List<User> users = await getUsers();
    users.add(user);
    await file.writeAsString(jsonEncode(users.map((user) => user.toJson()).toList()));
  }

  Future<List<User>> getUsers() async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return [];
      }
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => User.fromJson(json)).toList().cast<User>();
    } catch (e) {
      return [];
    }
  }
}

void main() async {
  final userRepository = UserRepository('users.json');

  // Example: Saving user
  await userRepository.saveUser(User(username: 'user1', password: 'password1'));

  // Example: Loading users
  final List<User> users = await userRepository.getUsers();
  print(users);
}
