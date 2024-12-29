import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/home/providers/favorited_pokemons_provider.dart';
import 'package:pokemon/features/home/models/pokemon_model.dart';
import 'package:pokemon/features/home/providers/pokemon_data_provider.dart';
import 'package:pokemon/features/home/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonTile extends ConsumerWidget {
  final String pokemonUrl;
  late FavoritePokemonsProvider _favoritedPokemonsProvider;
  late List<String> _favoritePokemons;
  PokemonTile({required this.pokemonUrl, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritedPokemonsProvider = ref.watch(favoritedPokemonsProvider.notifier);
    _favoritePokemons = ref.watch(favoritedPokemonsProvider);

    final pokemon = ref.watch(
      pokemonDataProvider(pokemonUrl),
    );

    return pokemon.when(
      data: (pokemonData) {
        return _tile(context, false, pokemonData);
      },
      loading: () => _tile(context, true, null),
      error: (error, stack) => Text('Error: $error'),
    );
  }

  Widget _tile(
    BuildContext context,
    bool isLoading,
    PokemonModel? pokemonData,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () {
          if (!isLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return PokemonStatsCard(pokemonUrl);
              },
            );
          }
        },
        child: ListTile(
          leading: pokemonData != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(pokemonData.sprites!.frontDefault!),
                )
              : CircleAvatar(),
          title: Text(pokemonData != null ? pokemonData.name!.toUpperCase() : ''),
          subtitle: Text('Has ${pokemonData?.moves!.length.toString() ?? 0} moves'),
          trailing: IconButton(
            onPressed: () {
              if (_favoritePokemons.contains(pokemonUrl)) {
                _favoritedPokemonsProvider.removeFavoritePokemon(pokemonUrl);
              } else {
                _favoritedPokemonsProvider.addFavoritePokemon(pokemonUrl);
              }
            },
            icon: _favoritePokemons.contains(pokemonUrl)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
          ),
        ),
      ),
    );
  }
}
