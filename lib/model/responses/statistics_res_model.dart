/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"match_id":"1","no_card":"16","game_cat":"Cricket","match_data":[{"registration_id":"2","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"sam"},{"registration_id":"1","win":"1","loss":"0","points":"100","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"ram"},{"registration_id":"3","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"bam"},{"registration_id":"4","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"dgdg"}]},{"match_id":"2","no_card":"16","game_cat":"Football","match_data":[{"registration_id":"2","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"sam"},{"registration_id":"1","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"ram"},{"registration_id":"3","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"bam"},{"registration_id":"4","win":"1","loss":"0","points":"100","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"dgdg"}]},{"match_id":"3","no_card":"16","game_cat":"Cricket","match_data":[{"registration_id":"2","win":"1","loss":"1","points":"50","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"sam"},{"registration_id":"1","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"ram"}]},{"match_id":"4","no_card":"16","game_cat":"Football","match_data":[{"registration_id":"2","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"sam"},{"registration_id":"1","win":"1","loss":"0","points":"150","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"ram"}]},{"match_id":"5","no_card":"16","game_cat":"Cricket","match_data":[{"registration_id":"2","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"sam"},{"registration_id":"4","win":"1","loss":"0","points":"550","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"dgdg"}]}]

class StatisticsResModel {
  int _status;
  String _message;
  List<Response> _response;

  int get status => _status;
  String get message => _message;
  List<Response> get response => _response;

  StatisticsResModel({
      int status, 
      String message, 
      List<Response> response}){
    _status = status;
    _message = message;
    _response = response;
}

  StatisticsResModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    if (json["response"] != null) {
      _response = [];
      json["response"].forEach((v) {
        _response.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_response != null) {
      map["response"] = _response.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// match_id : "1"
/// no_card : "16"
/// game_cat : "Cricket"
/// match_data : [{"registration_id":"2","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"sam"},{"registration_id":"1","win":"1","loss":"0","points":"100","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"ram"},{"registration_id":"3","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"bam"},{"registration_id":"4","win":"0","loss":"1","points":"0","coins":"0","redeem":"0","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"dgdg"}]

class Response {
  String _matchId;
  String _noCard;
  String _gameCat;
  List<Match_data> _matchData;

  String get matchId => _matchId;
  String get noCard => _noCard;
  String get gameCat => _gameCat;
  List<Match_data> get matchData => _matchData;

  Response({
      String matchId, 
      String noCard, 
      String gameCat, 
      List<Match_data> matchData}){
    _matchId = matchId;
    _noCard = noCard;
    _gameCat = gameCat;
    _matchData = matchData;
}

  Response.fromJson(dynamic json) {
    _matchId = json["match_id"];
    _noCard = json["no_card"];
    _gameCat = json["game_cat"];
    if (json["match_data"] != null) {
      _matchData = [];
      json["match_data"].forEach((v) {
        _matchData.add(Match_data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["match_id"] = _matchId;
    map["no_card"] = _noCard;
    map["game_cat"] = _gameCat;
    if (_matchData != null) {
      map["match_data"] = _matchData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// registration_id : "2"
/// win : "0"
/// loss : "1"
/// points : "0"
/// coins : "0"
/// redeem : "0"
/// photo : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU"
/// fullname : "sam"

class Match_data {
  String _registrationId;
  String _win;
  String _loss;
  String _points;
  String _coins;
  String _redeem;
  String _photo;
  String _fullname;

  String get registrationId => _registrationId;
  String get win => _win;
  String get loss => _loss;
  String get points => _points;
  String get coins => _coins;
  String get redeem => _redeem;
  String get photo => _photo;
  String get fullname => _fullname;

  Match_data({
      String registrationId, 
      String win, 
      String loss, 
      String points, 
      String coins, 
      String redeem, 
      String photo, 
      String fullname}){
    _registrationId = registrationId;
    _win = win;
    _loss = loss;
    _points = points;
    _coins = coins;
    _redeem = redeem;
    _photo = photo;
    _fullname = fullname;
}

  Match_data.fromJson(dynamic json) {
    _registrationId = json["registration_id"];
    _win = json["win"];
    _loss = json["loss"];
    _points = json["points"];
    _coins = json["coins"];
    _redeem = json["redeem"];
    _photo = json["photo"];
    _fullname = json["fullname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["registration_id"] = _registrationId;
    map["win"] = _win;
    map["loss"] = _loss;
    map["points"] = _points;
    map["coins"] = _coins;
    map["redeem"] = _redeem;
    map["photo"] = _photo;
    map["fullname"] = _fullname;
    return map;
  }

}