import 'package:location/location.dart';

class LocationPermission {
  LocationPermission() {
    init();
  }

  Location location = Location();
  LocationData? _locationData;
  init() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    //권한 상태를 확인합니다.
    if (_permissionGranted == PermissionStatus.denied) {
      // 권한이 없으면 권한을 요청합니다.
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // 권한이 없으면 위치정보를 사용할 수 없어 위치정보를 사용하려는 코드에서 에러가 나기때문에 종료합니다.
        return;
      }
    }
    _locationData = await location.getLocation();
    //_locationData에는 위도, 경도, 위치의 정확도, 고도, 속도, 방향 시간등의 정보가 담겨있습니다.
  }

  Future<LocationData> get curLocation async => await location.getLocation();

}
