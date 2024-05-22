import 'package:example/domain/model/pokemon.dart';
import 'package:example/domain/repository/pokemon_api.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    // this.pokemonList,
    required this.pokemonApi,
  });
  final PokemonApi pokemonApi; //api de pokemon
  List<Pokemon>? pokemonList; //listado del json

  Future<void> loadPokemons() async {
    pokemonList = await pokemonApi.getPokemons();
    notifyListeners();
  }
}
