import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/services/database_service.dart';
import 'package:pokemon/features/home/view/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/services/http_service.dart';

void main() {
  _initServices();
  runApp(ProviderScope(child: const PokemonApp()));
}

_initServices() {
  GetIt.instance.registerLazySingleton<HttpService>(() => HttpService());
  GetIt.instance.registerLazySingleton<DatabaseService>(() => DatabaseService());
}

class PokemonApp extends ConsumerWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.oswaldTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
