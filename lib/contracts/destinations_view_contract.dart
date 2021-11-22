import 'package:gestint/models/destination_model.dart';

abstract class DestinationsViewContract{
  void onLoadDestinationsComplete(List<Destination> destinationList);
  void onLoadDestinationsError();
}