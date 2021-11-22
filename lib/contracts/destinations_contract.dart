
import 'package:gestint/models/destination_model.dart';

abstract class DestinationsContract {
  Future<List<Destination>> getDestinations(String id);
}