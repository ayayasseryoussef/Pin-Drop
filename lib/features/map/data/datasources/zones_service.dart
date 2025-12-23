class ZonesService {
  Future<bool> checkAvailability(double lat, double lng) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return lat % 2 == 0;
  }
}