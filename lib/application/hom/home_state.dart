import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationState extends Equatable{
  const LocationState();

  @override
  List<Object?> get props => [];
}
class LocationInitialState extends LocationState{
  @override
  List<Object?> get props => [];
}
class LocationLoading extends LocationState{}
class LocationCompleted extends LocationState{
  final double lon,lat;
  final Set<Marker> markers;

  const LocationCompleted({required this.lon, required this.lat,required this.markers});


}
class LocationField extends LocationState{
  final String message;

  const LocationField({required this.message});

}