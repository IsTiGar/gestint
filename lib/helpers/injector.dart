import 'package:gestint/repositories/data_repository.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  DataRepository get dataRepository {
    return DataRepository();
  }
}