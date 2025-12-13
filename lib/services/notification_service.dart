import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lab2/services/api_service.dart';
import '../main.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final ApiService _api = ApiService();

  Future<void> initFCM() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    print("FCM token: $token");

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _openDailyRandomRecipe();
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _openDailyRandomRecipe();
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    });
  }

  Future<void> _openDailyRandomRecipe() async {
    final meal = await _api.loadRandomRecipe();

    navigatorKey.currentState?.pushNamed(
      "/recipeDetails",
      arguments: meal,
    );
  }
}