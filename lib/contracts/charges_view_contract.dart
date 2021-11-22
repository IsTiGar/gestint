import 'package:gestint/models/charge_model.dart';

abstract class ChargesViewContract{
  void onLoadChargesComplete(List<Charge> chargeList);
  void onLoadChargesError();
}