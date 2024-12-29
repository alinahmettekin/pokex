// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pokemon/features/home/models/pokemon_list.dart';

class HomePageData {
  PokemonListModel? pokemonList;

  HomePageData({this.pokemonList});

  HomePageData.initial() : pokemonList = null;

  HomePageData copyWith({
    PokemonListModel? pokemonList,
  }) {
    return HomePageData(
      pokemonList: pokemonList ?? this.pokemonList,
    );
  }
}
