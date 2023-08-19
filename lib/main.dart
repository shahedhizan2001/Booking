import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'hotel/elevated/hotel_secreen_cubit.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(BlocProvider<HotelSecreenCubit>(
      create: (context) => HotelSecreenCubit()..getSharedLanguage(), child: MyApp()));
}
