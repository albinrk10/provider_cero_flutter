import 'package:example/domain/repository/pokemon_api.dart';
import 'package:example/ui/provider/home_provider.dart';
import 'package:example/ui/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen._({super.key});

  static Widget create({Key? key}) => ChangeNotifierProvider(
        lazy: false,
        create: (context) => HomeProvider(
          pokemonApi: context.read<PokemonApi>(),
        )..loadPokemons(),
        child: HomeScreen._(
          key: key,
        ),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // context.read<HomeProvider>().loadPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = context.watch<HomeProvider>().pokemonList;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
     
        body: SafeArea(
          child: result == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Pokedex',
                              style: textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          IconButton(
                            onPressed: () {
                              context.read<ThemeProvider>().changeTheme();
                            },
                            icon: const Icon(Icons.light_mode),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Search your pokemon'),
                      const SizedBox(
                        height: 5,
                      ),
                      const TextField(
                          decoration: InputDecoration(
                              hintText: 'Name or Number',
                              fillColor: Color.fromARGB(255, 246, 245, 245),
                              filled: true,
                              prefixIcon: Icon(Icons.search),
                              enabledBorder: InputBorder.none)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(child: PokemonGrid()),
                    ],
                  ),
                ),
        ));
  }
}

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.read<HomeProvider>().pokemonList;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: result?.length,
      itemBuilder: (context, index) {
        final pokemon = result![index];
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  pokemon.imageurl,
                  height: 150,
                ),
              ),
              Text(pokemon.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              Text(pokemon.id,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        );
      },
    );
  }
}
