/* import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveCSRFToken(String token) async {
    await _storage.write(key: 'csrf_token', value: token);
  }

  Future<String?> getCSRFToken() async {
    return await _storage.read(key: 'csrf_token');
  }

  Future<void> deleteCSRFToken() async {
    await _storage.delete(key: 'csrf_token');
  }
}
 */