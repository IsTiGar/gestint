
abstract class UserContract {
  Future<bool> checkUserCredentials(String id, String password);
}