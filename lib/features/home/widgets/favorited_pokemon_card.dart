import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/home/providers/favorited_pokemons_provider.dart';
import 'package:pokemon/features/home/models/pokemon_model.dart';
import 'package:pokemon/features/home/providers/pokemon_data_provider.dart';
import 'package:pokemon/features/home/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritedPokemonCard extends ConsumerWidget {
  final String pokemonUrl;

  late FavoritePokemonsProvider favorited;

  FavoritedPokemonCard({
    required this.pokemonUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorited = ref.watch(favoritedPokemonsProvider.notifier);

    final pokemon = ref.watch(
      pokemonDataProvider(pokemonUrl),
    );

    return pokemon.when(data: (data) {
      return _card(context, false, data!);
    }, error: (error, stackTrace) {
      return Text('Error: $error');
    }, loading: () {
      return _card(context, true, PokemonModel());
    });
  }

  Widget _card(BuildContext context, bool isLoading, PokemonModel pokemonData) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
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
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemonData.name?.toUpperCase() ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '#${pokemonData.id?.toString()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: CircleAvatar(
                backgroundImage: NetworkImage(
                  pokemonData.sprites?.frontDefault ?? '',
                ),
                radius: MediaQuery.of(context).size.width * 0.1,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Has ${pokemonData.moves?.length.toString() ?? 0} moves',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      favorited.removeFavoritePokemon(pokemonUrl);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
