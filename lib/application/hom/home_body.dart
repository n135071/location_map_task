import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../map_screen/map_body.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationBloc locationBloc = context.read<LocationBloc>();
    return BlocConsumer<LocationBloc, LocationState>(
        builder: (BuildContext context, LocationState state) {
      if (state is LocationLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Center(
          child: ElevatedButton(
              onPressed: () => locationBloc.add(GetLocation()),
              child: const Text('location')),
        );
      }
    }, listener: (BuildContext context, LocationState state) {
      if (state is LocationField) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
      if (state is LocationCompleted) {
        //Navigator
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MapScreen(),
          ),
        );
      }
    });
  }
}
