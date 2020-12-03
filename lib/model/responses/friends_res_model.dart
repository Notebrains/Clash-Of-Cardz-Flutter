/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"freind_id":"MEM000004","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"dgdg","match_played":"6","points":"1200"},{"freind_id":"MEM000022","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"drververv","match_played":"0","points":"0"},{"freind_id":"MEM000023","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"gdrgd","match_played":"0","points":"0"},{"freind_id":"MEM000024","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"drververv","match_played":"0","points":"0"},{"freind_id":"MEM000026","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","fullname":"drververv","match_played":"0","points":"0"}]

class FriendsResModel {
  int _status;
  String _message;
  List<Response> _response;

  int get status => _status;
  String get message => _message;
  List<Response> get response => _response;

  FriendsResModel({
      int status, 
      String message, 
      List<Response> response}){
    _status = status;
    _message = message;
    _response = response;
}

  FriendsResModel.fromJson(dynamic json) {
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

/// freind_id : "MEM000004"
/// photo : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU"
/// fullname : "dgdg"
/// match_played : "6"
/// points : "1200"

class Response {
  String _freindId;
  String _photo;
  String _fullname;
  String _matchPlayed;
  String _points;

  String get freindId => _freindId;
  String get photo => _photo;
  String get fullname => _fullname;
  String get matchPlayed => _matchPlayed;
  String get points => _points;

  Response({
      String freindId, 
      String photo, 
      String fullname, 
      String matchPlayed, 
      String points}){
    _freindId = freindId;
    _photo = photo;
    _fullname = fullname;
    _matchPlayed = matchPlayed;
    _points = points;
}

  Response.fromJson(dynamic json) {
    _freindId = json["freind_id"];
    _photo = json["photo"];
    _fullname = json["fullname"];
    _matchPlayed = json["match_played"];
    _points = json["points"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["freind_id"] = _freindId;
    map["photo"] = _photo;
    map["fullname"] = _fullname;
    map["match_played"] = _matchPlayed;
    map["points"] = _points;
    return map;
  }

}