import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../hom/home_bloc.dart';
import '../hom/home_state.dart';

class MapBody extends StatelessWidget {
  const MapBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationBloc locationBloc = context.read<LocationBloc>();
    return BlocBuilder<LocationBloc, LocationState>(
      bloc: locationBloc,
      builder: (context, state) {
        if (state is LocationCompleted) {

          return GoogleMap(
            onMapCreated: locationBloc.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(state.lat, state.lon),
              zoom: 10,
            ),
            markers: state.markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
