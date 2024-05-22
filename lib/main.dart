import 'package:example/data/pokemon_analytics.dart';
import 'package:example/data/rest/pokemon_rest_service.dart';
import 'package:example/domain/repository/pokemon_api.dart';
import 'package:example/ui/provider/theme_provider.dart';
import 'package:example/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         Provider<PokemonAnalytics>(
          create: (_) => PokemonAnalytics(),
        ),
        Provider<PokemonApi>(
          create: (context) => PokemonRestService(
            context.read<PokemonAnalytics>()
          ),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: Consumer<ThemeProvider>(builder: (context, provider, _) {
        final isLight = provider.isLight;
        return MaterialApp(
          title: 'Flutter pokemon',
          theme: isLight ? ThemeData.light() : ThemeData.dark(),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
