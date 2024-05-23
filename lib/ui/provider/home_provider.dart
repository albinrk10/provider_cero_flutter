import 'dart:async';

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
  List<Pokemon>? searchList;
  final debouncer = Debouncer();

  Future<void> loadPokemons() async {
    pokemonList = await pokemonApi.getPokemons();
    searchList = List<Pokemon>.from(pokemonList ?? []);
    _setInitialList();
    notifyListeners();
  }

  void _setInitialList() {
    searchList = List<Pokemon>.from(pokemonList ?? []);
  }

  void searchPokemon(String filter) {
    debouncer.execute(() {
      final filterLowercase = filter.toLowerCase();
      print('Filter $filter');
      if (filter == "") {
        _setInitialList();
      } else {
        searchList = List<Pokemon>.from(
          pokemonList!.where(
            (element) =>
                element.name.toLowerCase().contains(
                      filterLowercase,
                    ) ||
                element.id.toLowerCase().contains(filterLowercase),
          ),
        );
      }
      notifyListeners();
    });
  }
}

class Debouncer {
  Timer? timer;

  void execute(VoidCallback action) {
    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), action);
  }
}
