
import '../services/services.dart';
import 'package:geocoding/geocoding.dart';


class LocationRepository {


  Future<Location?> getLatLng(String? address) async {
    return await LocationService.getLatLngFromAddress(address);
  }


}
