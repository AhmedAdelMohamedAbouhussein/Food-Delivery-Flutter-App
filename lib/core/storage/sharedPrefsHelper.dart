import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  final SharedPreferences _prefs;
  SharedPrefsHelper(this._prefs);

  static Future<SharedPrefsHelper> init() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsHelper(prefs);
  }

  // Keys
  // static const String _isOnboardingCompletedKey = 'isOnboardingCompleted';
  static const String _phoneNumberKey = 'phoneNumber';


  // Onboarding (optional, keep commented out)
  // Future<void> setOnboardingCompleted(bool value) async =>
  //     await _prefs.setBool(_isOnboardingCompletedKey, value);

  // bool get isOnboardingCompleted =>
  //     _prefs.getBool(_isOnboardingCompletedKey) ?? false;

  // Phone number
  Future<void> setPhoneNumber(String phone) async =>
      await _prefs.setString(_phoneNumberKey, phone);

  String? get phoneNumber => _prefs.getString(_phoneNumberKey);
}
