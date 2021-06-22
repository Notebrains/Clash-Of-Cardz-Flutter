/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"fullname":"Sudeep Panda","memberid":"MEM000031","win":"4","loss":"0","points":"1650","coins":"0","redeem":"0","rank":1,"image":"https://lh3.googleusercontent.com/a-/AOh14GiQee_Qjd4yWuE9NLbiWiKSeMFuvajShP_ooUMIq5w=s96-c","match_played":"46","joined_on":"22nd January,2021"}]

class ProfileResModel {
  int _status;
  String _message;
  List<Response> _response;

  int get status => _status;
  String get message => _message;
  List<Response> get response => _response;

  ProfileResModel({
      int status, 
      String message, 
      List<Response> response}){
    _status = status;
    _message = message;
    _response = response;
}

  ProfileResModel.fromJson(dynamic json) {
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

/// fullname : "Sudeep Panda"
/// memberid : "MEM000031"
/// win : "4"
/// loss : "0"
/// points : "1650"
/// coins : "0"
/// redeem : "0"
/// rank : 1
/// image : "https://lh3.googleusercontent.com/a-/AOh14GiQee_Qjd4yWuE9NLbiWiKSeMFuvajShP_ooUMIq5w=s96-c"
/// match_played : "46"
/// joined_on : "22nd January,2021"

class Response {
  String _fullname;
  String _memberid;
  String _win;
  String _loss;
  String _points;
  String _coins;
  String _redeem;
  int _rank;
  String _image;
  String _matchPlayed;
  String _joinedOn;

  String get fullname => _fullname;
  String get memberid => _memberid;
  String get win => _win;
  String get loss => _loss;
  String get points => _points;
  String get coins => _coins;
  String get redeem => _redeem;
  int get rank => _rank;
  String get image => _image;
  String get matchPlayed => _matchPlayed;
  String get joinedOn => _joinedOn;

  Response({
      String fullname, 
      String memberid, 
      String win, 
      String loss, 
      String points, 
      String coins, 
      String redeem, 
      int rank, 
      String image, 
      String matchPlayed, 
      String joinedOn}){
    _fullname = fullname;
    _memberid = memberid;
    _win = win;
    _loss = loss;
    _points = points;
    _coins = coins;
    _redeem = redeem;
    _rank = rank;
    _image = image;
    _matchPlayed = matchPlayed;
    _joinedOn = joinedOn;
}

  Response.fromJson(dynamic json) {
    _fullname = json["fullname"];
    _memberid = json["memberid"];
    _win = json["win"];
    _loss = json["loss"];
    _points = json["points"];
    _coins = json["coins"];
    _redeem = json["redeem"];
    _rank = json["rank"];
    _image = json["image"];
    _matchPlayed = json["match_played"];
    _joinedOn = json["joined_on"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["fullname"] = _fullname;
    map["memberid"] = _memberid;
    map["win"] = _win;
    map["loss"] = _loss;
    map["points"] = _points;
    map["coins"] = _coins;
    map["redeem"] = _redeem;
    map["rank"] = _rank;
    map["image"] = _image;
    map["match_played"] = _matchPlayed;
    map["joined_on"] = _joinedOn;
    return map;
  }

}