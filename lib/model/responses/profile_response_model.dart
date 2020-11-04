/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"fullname":"ram","memberid":"MEM000001","win":"2","loss":"2","points":"250","coins":"0","redeem":"0","rank":2,"photo":""}]

class StatisticsResponseModel {
  int _status;
  String _message;
  List<Response> _response;

  int get status => _status;
  String get message => _message;
  List<Response> get response => _response;

  StatisticsResponseModel({
      int status, 
      String message, 
      List<Response> response}){
    _status = status;
    _message = message;
    _response = response;
}

  StatisticsResponseModel.fromJson(dynamic json) {
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

/// fullname : "ram"
/// memberid : "MEM000001"
/// win : "2"
/// loss : "2"
/// points : "250"
/// coins : "0"
/// redeem : "0"
/// rank : 2
/// photo : ""

class Response {
  String _fullname;
  String _memberid;
  String _win;
  String _loss;
  String _points;
  String _coins;
  String _redeem;
  int _rank;
  String _photo;

  String get fullname => _fullname;
  String get memberid => _memberid;
  String get win => _win;
  String get loss => _loss;
  String get points => _points;
  String get coins => _coins;
  String get redeem => _redeem;
  int get rank => _rank;
  String get photo => _photo;

  Response({
      String fullname, 
      String memberid, 
      String win, 
      String loss, 
      String points, 
      String coins, 
      String redeem, 
      int rank, 
      String photo}){
    _fullname = fullname;
    _memberid = memberid;
    _win = win;
    _loss = loss;
    _points = points;
    _coins = coins;
    _redeem = redeem;
    _rank = rank;
    _photo = photo;
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
    _photo = json["photo"];
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
    map["photo"] = _photo;
    return map;
  }

}