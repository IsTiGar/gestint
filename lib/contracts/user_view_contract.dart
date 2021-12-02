
abstract class UserViewContract{
  void onCheckUserCredentialsComplete(String id, String password, bool match);
  void onCheckUserCredentialError();
}