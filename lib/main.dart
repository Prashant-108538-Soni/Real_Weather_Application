import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_application/Model/History_model.dart';
import 'package:real_weather_application/Provider/weather_provider.dart';
import 'package:real_weather_application/Screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox<HistoryModel>("history");
  await Hive.openBox<String>("fav");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>WeatherProvider(),
    child: MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
    );

  }
}
