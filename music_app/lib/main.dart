import 'package:flutter/material.dart';
import 'package:music_app/Model/playlist_provider.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:music_app/theme/light_mode.dart';
import 'package:music_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Step 2: Provide the CounterProvider
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context)=> ThemeProvider()),
          ChangeNotifierProvider(create: (context)=> PlaylistProvider()),
         ],
          child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Flutter Demo',
      home:  HomePage(),
      // Step 3: Access the provider using context

      theme:Provider.of<ThemeProvider>(context).themeData,
    );
  }
}


