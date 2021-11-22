import 'package:gestint/models/scale_model.dart';

abstract class ScaleViewContract{
  void onLoadScaleComplete(Scale scale);
  void onLoadScaleError();
}