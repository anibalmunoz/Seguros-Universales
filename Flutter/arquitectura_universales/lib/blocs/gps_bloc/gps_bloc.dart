import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;

  GpsBloc()
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionGranted: event.isGpsPermissionGranted,
        )));

    _init();
  }

  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
        isGpsEnabled: gpsInitStatus[0],
        isGpsPermissionGranted: gpsInitStatus[1]));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      //DISPARAR EVENTOS
      final isEnabled = (event.index == 1) ? true : false;
      print("Service Status :   $isEnabled");
      add(GpsAndPermissionEvent(
          isGpsEnabled: isEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });

    if (isEnable == true) {
      _initialPosition = await Geolocator.getCurrentPosition();
    } else {
      _initialPosition = const Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: null,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
    }
    return isEnable;
  }

  Position? _initialPosition;
  Position? get initialPosition => _initialPosition;

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:

      case PermissionStatus.restricted:

      case PermissionStatus.limited:

      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    //Limpiar el service status stream

    gpsServiceSubscription?.cancel();

    return super.close();
  }

  //METODOS DE PRUEBA

  /*obtenerUbicacion() async {
    _initialPosition = await Geolocator.getCurrentPosition();
    print("LA UBICACION ACTUAL OBTENIDA POR GEOLOCATOR ES:  $_initialPosition");
    return _initialPosition;
  }
  */

}
