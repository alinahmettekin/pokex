import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/services/http_service.dart';
import 'package:pokemon/features/home/models/pokemon_model.dart';

final pokemonDataProvider = FutureProvider.family<PokemonModel?, String>(
  (ref, url) async {
    final httpService = GetIt.instance.get<HttpService>();
    log('çalıştım');
    Response response = await httpService.get(url: url);

    if (response.data != null && response.statusCode == 200) {
      return PokemonModel.fromJson(response.data);
    }
    return null;
  },
);
