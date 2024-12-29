import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/home/providers/favorited_pokemons_provider.dart';
import 'package:pokemon/features/home/controllers/home_page_controller.dart';
import 'package:pokemon/features/home/data/home_page_data.dart';
import 'package:pokemon/features/home/widgets/favorited_pokemon_card.dart';
import 'package:pokemon/features/home/widgets/pokemon_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomePageController _homePageController = ref.watch(homePageControllerProvider.notifier);
  late HomePageData _homePageData;
  final ScrollController _scrollController = ScrollController();
  late List<String> _favoritePokemons;

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent * 1 &&
        !_scrollController.position.outOfRange) {
      _homePageController.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    _scrollController.addListener(_scrollListener);
    _favoritePokemons = ref.watch(favoritedPokemonsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pokex'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _favoritePokemonsList(context),
                _allPokemonsList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _allPokemonsList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Pokemons',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _homePageData.pokemonList?.results?.length ?? 0,
              itemBuilder: (context, index) {
                return PokemonTile(
                  pokemonUrl: _homePageData.pokemonList?.results?[index].url ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _favoritePokemonsList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favorite Pokemons',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _favoritePokemons.length,
              itemBuilder: (context, index) {
                return FavoritedPokemonCard(
                  pokemonUrl: _favoritePokemons[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
