import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageModel{

  // Create storage
  final storage = new FlutterSecureStorage();

  Future<void> saveUserData(String userId, String password) async{
    await storage.write(key: 'userId', value: userId);
    await storage.write(key: 'password', value: password);
  }

  Future<String?> getUserId() async {
    String? userId = await storage.read(key: 'userId');
    return userId;
  }

  Future<String?> getPassword() async {
    String? password = await storage.read(key: 'password');
    return password;
  }

  Future<void> clearData() async{
    await storage.deleteAll();
  }

}