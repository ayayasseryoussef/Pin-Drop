import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_drop/features/map/data/repo/zones_repo_impl.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  final ZonesRepoImpl repo;

  PinCubit(this.repo) : super(const PinState());

  void onMapMove() {
    emit(state.copyWith(isDragging: true));
  }

  Future<void> onMapIdle(double lat, double lng) async {
    final available = await repo.checkAvailability(lat, lng);
    emit(state.copyWith(isDragging: false, isAvailable: available));
  }
}