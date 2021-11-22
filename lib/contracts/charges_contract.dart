
import 'package:gestint/models/charge_model.dart';

abstract class ChargesContract {
  Future<List<Charge>> getCharges(String id);
}