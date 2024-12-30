import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class ClientIdManager {
  static Future<String> getClientId() async {
    final prefs = await SharedPreferences.getInstance();
    String? clientId = prefs.getString('clientId');
    
    if (clientId == null) {
      clientId = _generateUniqueId();
      await prefs.setString('clientId', clientId);
    }
    
    return clientId;
  }

  static String _generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final random = Random();
    final randomSuffix = random.nextInt(1000).toString();
    return '$timestamp-$randomSuffix';
  }
}
