
abstract class UserViewContract{
  void onCheckUserCredentialsComplete(String id, bool match);
  void onCheckUserCredentialError();
}