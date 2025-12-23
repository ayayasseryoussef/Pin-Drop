import 'package:pin_drop/features/map/domain/repo/zones_repo.dart';

import '../datasources/zones_service.dart';

class ZonesRepoImpl implements ZonesRepo {
  final ZonesService service;
  ZonesRepoImpl(this.service);

  @override
  Future<bool> checkAvailability(double lat, double lng) {
    return service.checkAvailability(lat, lng);
  }
}