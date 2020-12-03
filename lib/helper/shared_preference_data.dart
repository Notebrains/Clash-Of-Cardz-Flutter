import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  void readLogInUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final xApiKey = prefs.getInt('x_api_key') ?? 0;
    final memberId = prefs.getInt('memberId') ?? 0;
    print('----read: $memberId');
  }

  void saveUserProfileData(
    String memberId,
    String fullname,
    String photo,
    String points,
    String coins,
    String win,
    String loss,
    String matchPlayed,
    String rank,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('memberId', memberId);
    prefs.setString('fullName', fullname);
    prefs.setString('photo', photo);
    prefs.setString('points', points);
    prefs.setString('coins', coins);
    prefs.setString('win', win);
    prefs.setString('loss', loss);
    prefs.setString('matchPlayed', matchPlayed);
    prefs.setString('rank', rank);
  }

  void saveUserApiKey(String xApiKey) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('x_api_key', xApiKey);
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
