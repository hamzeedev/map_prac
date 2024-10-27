import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class MapsScreenController extends GetxController {
  
  Future<List<Location>> fetchGeoPoints(String address) async{
    try {
      List<Location> locations = await locationFromAddress(address);
    return locations; 
    } catch (e) {
      return [];
    }
  }
}