import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../data/location_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService = LocationService();

  LocationBloc(super.initialState) {
    on<GetLocation>(openMap);
  }

  GoogleMapController? mapController;

  Future<void> openMap(GetLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    LocationData? locationData = await getCurrentLocation();

    if (locationData == null) {
      emit(const LocationField(message: "could not get the location"));
      return;
    }
    var locationServer = await _locationService.getLocationServer2();
    if (locationServer.data?.deliveryTarget != null) {
      final Set<Marker> markers = {
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          markerId: const MarkerId('location1'),
          position: LatLng(locationData.longitude!, locationData.latitude!),
          infoWindow: const InfoWindow(title: 'Location 1'),
        ),
        Marker(
          markerId: const MarkerId('location2'),
          position: LatLng(
            double.parse(locationServer.data!.deliveryTarget!.latitude!),
            double.parse(locationServer.data!.deliveryTarget!.longitude!),
          ),
          infoWindow: const InfoWindow(title: 'Location 2'),
        ),
      };
      emit(LocationCompleted(
          lon: locationData.longitude!,
          lat: locationData.latitude!,
          markers: markers,
      ));
    }else{
      emit(LocationField(message: locationServer.message));
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }

}
