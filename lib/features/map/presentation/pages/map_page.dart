import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_drop/features/map/presentation/cubit/pin_cubit.dart';
import 'package:pin_drop/features/map/presentation/widgets/availability_badge.dart';
import 'package:pin_drop/features/map/presentation/widgets/pin_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PinCubit, PinState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(30.0, 30.0),
                  zoom: 30,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onCameraMove: (_) =>
                    context.read<PinCubit>().onMapMove(),
                onCameraIdle: () async {
                 final screenSize = MediaQuery.of(context).size;

  final centerLatLng = await _mapController.getLatLng(
    ScreenCoordinate(
      x: (screenSize.width / 2).round(),
      y: (screenSize.height / 2).round(),
    ),
  );

  context
      .read<PinCubit>()
      .onMapIdle(centerLatLng.latitude, centerLatLng.longitude);
},),

              PinMarker(
                isDragging: state.isDragging,
                isAvailable: state.isAvailable,
              ),

              Positioned(
                top: 60,
                child: AvailabilityBadge(available: state.isAvailable),
              ),
            ],
          );
        },
      ),
    );
  }
}
