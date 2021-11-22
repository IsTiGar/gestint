
import 'package:gestint/models/scale_model.dart';

abstract class ScaleContract {
  Future<Scale> getScale(String id);
}