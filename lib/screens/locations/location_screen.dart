import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/bloc/autcomplete/autocomplete/autocomplete_bloc.dart';
import 'package:food/bloc/geolocation/geolocation_bloc.dart';
import 'package:food/bloc/place/place/place_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoactionScreen extends StatelessWidget {
  static const String routeName = "/location";

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => LoactionScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Location',
        ),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
        if (state is PlaceLoading) {
          return Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  //Double Infinity is also the size of the screen
                  width: double.infinity,
                  child: BlocBuilder<GeolocationBloc, GeolocationState>(
                      builder: (context, state) {
                    if (state is GeolocationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GeolocationLoaded) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(state.position.latitude,
                                state.position.longitude),
                            zoom: 10),
                        myLocationButtonEnabled: true,
                      );
                    } else {
                      return const Text('Something went Wrong');
                    }
                  })),
              const Location(),
              const SaveButton(),
            ],
          );
        } else if (state is PlaceLoaded) {
          return Stack(
            children: [
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(state.place.lat, state.place.lon))),
              const Location(),
              const SaveButton(),
            ],
          );
        } else {
          return const Text('Something went Wrong');
        }
      }),
    );
  }
}

class Location extends StatelessWidget {
  const Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/spoon.png",
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(children: [
              const LocationSearchBox(),
              BlocBuilder<AutocompleteBloc, AutocompleteState>(
                  builder: (context, state) {
                if (state is AutocompleteLoaded) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    height: 20,
                    color: state.autoComplete.isNotEmpty
                        ? Colors.black.withOpacity(0.6)
                        : Colors.transparent,
                    child: ListView.builder(
                        itemCount: state.autoComplete.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(state.autoComplete[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white)),
                              onTap: () {
                                context.read<PlaceBloc>().add(LoadPlace(
                                      placeId:
                                          state.autoComplete[index].placeId,
                                    ));
                              });
                        }),
                  );
                } else if (state is AutocompleteLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.white),
                  );
                }
              })
            ])),
          ],
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        child: ElevatedButton(
          child: const Text("Save"),
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Enter your Location",
            suffixIcon: const Icon(Icons.search),
            contentPadding:
                const EdgeInsets.only(left: 20, bottom: 5, right: 5),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white))),
        onChanged: (value) {
          context
              .read<AutocompleteBloc>()
              .add(LoadAutocomplete(searchInput: value));
        },
      ),
    );
  }
}
