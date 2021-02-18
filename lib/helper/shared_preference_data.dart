import 'package:shared_preferences/shared_preferences.dart';
import 'package:clash_of_cardz_flutter/model/arguments/shared_pref_user_model.dart';

class SharedPreferenceHelper {
  void readLogInUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final xApiKey = prefs.getInt('x_api_key') ?? 0;
    final memberId = prefs.getInt('memberId') ?? 0;
    //print('----read: $memberId');
  }

  void saveUserProfileData(
    String xApiKey,
    String memberId,
    String fullName,
    String photo,
    String points,
    String coins,
    String win,
    String loss,
    String matchPlayed,
    String redeem,
    String rank,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('xApiKey', xApiKey);
    prefs.setString('memberId', memberId);
    prefs.setString('fullName', fullName);
    prefs.setString('photo', photo);
    prefs.setString('points', points);
    prefs.setString('coins', coins);
    prefs.setString('win', win);
    prefs.setString('loss', loss);
    prefs.setString('matchPlayed', matchPlayed);
    prefs.setString('redeem', redeem);
    prefs.setString('rank', rank);
  }

  Future<SharedPrefUserProfileModel> getUserSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    print('------saved ${prefs.getString('memberId')}');

    return SharedPrefUserProfileModel(
        prefs.getString('xApiKey'),
        prefs.getString('fullName'),
        prefs.getString('memberId'),
        prefs.getString('win'),
        prefs.getString('loss'),
        prefs.getString('points'),
        prefs.getString('coins'),
        prefs.getString('redeem'),
        prefs.getString('rank'),
        prefs.getString('photo'),
        prefs.getString('matchPlayed')
    );
  }


  void saveUserApiKey(String xApiKey) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('x_api_key', xApiKey);
    //print('----saved $xApiKey');
  }

  void saveUserMemberId(String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('memberId', memberId);
    //print('----saved $xApiKey');
  }

  Future<String> getUserApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('x_api_key') ?? '0';
  }

  Future<String> getUserUserMemberId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('memberId') ?? '';
  }


  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fullName') ?? 0;
  }


  Future<String> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('photo') ?? 0;
  }

  void clearPrefData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void saveMusicOnOffState(bool isMusicOn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isMusicOn', isMusicOn);
    //print('----saved $xApiKey');
  }

  Future<bool> getMusicOnOffState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isMusicOn') ?? true;
  }

  void saveSfxOnOffState(bool isMusicOn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSfxOn', isMusicOn);
    //print('----saved $xApiKey');
  }

  Future<bool> getSfxOnOffState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSfxOn') ?? true;
  }

  void saveNotificationOnOffState(bool isNotificationOn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNotificationOn', isNotificationOn);
    //print('----saved $xApiKey');
  }

  Future<bool> getNotificationOnOffState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isNotificationOn') ?? true;
  }

}
