import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/features/home/data/home_page_data.dart';
import 'package:pokemon/services/http_service.dart';
import 'package:pokemon/features/home/models/pokemon_list.dart';

class HomePageController extends StateNotifier<HomePageData> {
  final _httpService = GetIt.instance.get<HttpService>();
  HomePageController(super._state) {
    _setUp();
  }

  _setUp() {
    loadData();
  }

  Future<void> loadData() async {
    if (state.pokemonList == null) {
      final response = await _httpService.get(url: 'https://pokeapi.co/api/v2/pokemon');

      PokemonListModel data = PokemonListModel.fromJson(response.data);

      state = state.copyWith(
        pokemonList: data,
      );
    } else {
      final response = await _httpService.get(url: state.pokemonList!.next!);

      PokemonListModel data = PokemonListModel.fromJson(response.data);

      state = state.copyWith(
        pokemonList: state.pokemonList!.copyWith(
          next: data.next,
          previous: data.previous,
          results: [...state.pokemonList!.results!, ...data.results!],
        ),
      );
    }
  }
}

final homePageControllerProvider = StateNotifierProvider<HomePageController, HomePageData>((ref) {
  return HomePageController(HomePageData.initial());
});
