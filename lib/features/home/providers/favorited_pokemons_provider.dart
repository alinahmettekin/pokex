import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/services/database_service.dart';

final favoritedPokemonsProvider = StateNotifierProvider<FavoritePokemonsProvider, List<String>>(
  (ref) {
    return FavoritePokemonsProvider([]);
  },
);

class FavoritePokemonsProvider extends StateNotifier<List<String>> {
  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();
  final String key = 'favorite_pokemons';
  FavoritePokemonsProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    List<String>? archivedPokemons = await _databaseService.getList(key);
    state = archivedPokemons ?? [];
  }

  void addFavoritePokemon(String url) {
    state = [...state, url];
    _databaseService.saveList(key, state);
  }

  void removeFavoritePokemon(String url) {
    state = state.where((element) => element != url).toList();
    _databaseService.saveList(key, state);
  }
}
