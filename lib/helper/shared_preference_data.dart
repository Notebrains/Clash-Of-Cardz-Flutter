import 'package:shared_preferences/shared_preferences.dart';
import 'package:trump_card_game/model/arguments/shared_pref_user_model.dart';

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

/*
    SharedPrefUserProfileModel.xApiKey = prefs.getString('xApiKey') ?? '';
    SharedPrefUserProfileModel().memberId = prefs.getString('memberId') ?? '';
    SharedPrefUserProfileModel().win = prefs.getString('win') ?? '';
    SharedPrefUserProfileModel().loss = prefs.getString('loss') ?? '';
    SharedPrefUserProfileModel().points = prefs.getString('points') ?? '';
    SharedPrefUserProfileModel().coins = prefs.getString('coins') ?? '';
    SharedPrefUserProfileModel().redeem = prefs.getString('redeem') ?? '';
    SharedPrefUserProfileModel().rank = prefs.getString('rank') ?? '';
    SharedPrefUserProfileModel().photo = prefs.getString('photo') ?? '';
    SharedPrefUserProfileModel().matchPlayed = prefs.getString('matchPlayed') ?? '';*/

    SharedPrefUserProfileModel(
        prefs.getString('xApiKey'),
        prefs.getString('memberId'),
        prefs.getString('fullName'),
        prefs.getString('win'),
        prefs.getString('loss'),
        prefs.getString('points'),
        prefs.getString('coins'),
        prefs.getString('redeem'),
        prefs.getString('rank'),
        prefs.getString('photo'),
        prefs.getString('matchPlayed')
    );

    return SharedPrefUserProfileModel();
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
    return prefs.getString('x_api_key') ?? 0;
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
}
