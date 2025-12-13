import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab2/screens/favorites_screen.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/categoryDetails.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/screens/recipes.dart';

import 'package:lab2/models/meal_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab2/services/notification_service.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  await NotificationService().initFCM();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Рецепти - 221193',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      initialRoute: "/",

      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        }
        if (settings.name == "/categoryDetails") {
          final category = settings.arguments as Category;
          return MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(category: category),
          );
        }
        if (settings.name == '/recipeDetails') {
          final meal = settings.arguments as Meal;
          return MaterialPageRoute(
            builder: (_) => RecipeDetailsScreen(meal: meal),
          );
        }
        if (settings.name == "/favorites") {
          return MaterialPageRoute(
            builder: (context) => const FavoritesScreen(),
          );
        }

        return null;
      },
    );
  }
}