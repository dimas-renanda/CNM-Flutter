import 'package:shared_preferences/shared_preferences.dart';
import 'globalspublic.dart' as globals;

class FileHandler {
  Future<void> _loadUserID() async {
    final prefs = await SharedPreferences.getInstance();

    globals.setUserID((prefs.getInt("UID") ?? 0));
  }

  Future<void> _saveUserID() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("UID", globals.getUserID());
  }

  Future<void> _loadTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    globals.tokenString = (prefs.getString("tokenString") ?? "0");
  }

  Future<void> _saveTokenString() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tokenString", globals.tokenString);
  }
}
