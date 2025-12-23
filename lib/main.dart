import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_drop/features/map/presentation/cubit/pin_cubit.dart';
import 'core/service_locator.dart';
import 'features/map/presentation/pages/map_page.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PinCubit(sl()),
        child: const MapPage(),
      ),
    );
  }
}