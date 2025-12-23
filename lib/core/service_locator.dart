import 'package:get_it/get_it.dart';
import 'package:pin_drop/features/map/data/repo/zones_repo_impl.dart';

import '../features/map/data/datasources/zones_service.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerLazySingleton<ZonesService>(() => ZonesService());
  sl.registerLazySingleton<ZonesRepoImpl>(
      () => ZonesRepoImpl(sl()));
}