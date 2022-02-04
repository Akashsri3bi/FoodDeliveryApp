import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food/bloc/geolocation/geolocation_bloc.dart';
import 'package:food/config/app_router.dart';
import 'package:food/config/theme.dart';
import 'package:food/repositories/geolocations/geolocation_repository.dart';
import 'package:food/repositories/places/places_repository.dart';
import 'package:food/repositories/vouvher/voucher_repository.dart';
import 'package:food/screens/homeScreen/homescreen.dart';

import 'bloc/autcomplete/autocomplete/autocomplete_bloc.dart';
import 'bloc/basket/basket_bloc.dart';
import 'bloc/filters/filters_bloc.dart';
import 'bloc/place/place/place_bloc.dart';
import 'bloc/voucher/voucher_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBqVm9lddLTzNtAJ9QhugBg0kE3hLJ0rpA",
          appId: "1:953288630092:android:afba5e0f67f826cffb39e9",
          messagingSenderId: "953288630092",
          projectId: "spacex-57c09"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeoLocationRepository>(
            create: (_) => GeoLocationRepository()),
        RepositoryProvider<PlacesRepository>(create: (_) => PlacesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => GeolocationBloc(
                  geoLocationRepository: context.read<GeoLocationRepository>())
                ..add(LoadGeoLocation())),
          BlocProvider(
              create: (context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(LoadAutocomplete())),
          BlocProvider(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
          BlocProvider(
              create: (context) =>
                  VoucherBloc(voucherRepository: VoucherRepository())
                    ..add(LoadVouchers())),
          BlocProvider(create: (context) => FiltersBloc()..add(FilterLoad())),
          BlocProvider(
              create: (context) => BasketBloc(
                    voucherBloc: BlocProvider.of<VoucherBloc>(context),
                  )..add(StartBasket())),
        ],
        child: MaterialApp(
          title: 'Food Delivery',
          theme: theme(),
          debugShowCheckedModeBanner: false,
          //These are routes which can be used to move through our application
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
