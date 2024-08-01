// auth_service.dart
class AuthService {
  Future<String?> login(String username, String password) async {
   
    await Future.delayed(Duration(seconds: 2)); 

    return 'mock_token';
  }
}
