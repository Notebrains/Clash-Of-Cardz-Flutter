
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{

  void readLogInUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final xApiKey = prefs.getInt('x_api_key') ?? 0;
    final memberId = prefs.getInt('memberId') ?? 0;
    print('----read: $memberId');
  }

  void saveLogInUserData(String xApiKey, String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('x_api_key', xApiKey);
    prefs.setString('memberId', memberId);
    print('----saved $xApiKey');
  }

  Future<int> getUserApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('x_api_key') ?? 0;
  }

  Future<int> getUserUserMemberId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('memberId') ?? 0;
  }

}