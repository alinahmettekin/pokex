import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/home/providers/pokemon_data_provider.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonUrl;
  const PokemonStatsCard(this.pokemonUrl, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(
      pokemonDataProvider(pokemonUrl),
    );
    return AlertDialog(
      alignment: Alignment.center,
      title: const Text('Pokemon Stats'),
      content: pokemon.when(
        data: (data) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: data?.stats?.map(
                  (e) {
                    return Text('${e.stat!.name!.toUpperCase()}: ${e.baseStat}');
                  },
                ).toList() ??
                [],
          );
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
