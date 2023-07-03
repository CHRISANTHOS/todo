import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location{

  Future<String?> getCurrentLocation()async{
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.longitude, position.latitude);
      final address = placeMarks.first.administrativeArea;
      return address;
    }catch(e){
      print(e);
    }
    return 'null';
  }

}