class ZonesService {
  Future<bool> checkAvailability(double lat, double lng) async {
    await Future.delayed(const Duration(milliseconds: 200));

    const double minLat = 29.9;
    const double maxLat = 30.1;
    const double minLng = 31.15;
    const double maxLng = 31.35;

    return lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
  }
}
