/// status : 1
/// message : "login successfully"
/// responce : {"x_api_key":"o8rCYx2wFuX88F0vQ6BkUOUpf","memberid":"MEM000004"}

class LoginResModel {
  int _status;
  String _message;
  Responce _responce;

  int get status => _status;
  String get message => _message;
  Responce get responce => _responce;

  LoginResModel({
      int status, 
      String message, 
      Responce responce}){
    _status = status;
    _message = message;
    _responce = responce;
}

  LoginResModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _responce = json["responce"] != null ? Responce.fromJson(json["responce"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_responce != null) {
      map["responce"] = _responce.toJson();
    }
    return map;
  }

}

/// x_api_key : "o8rCYx2wFuX88F0vQ6BkUOUpf"
/// memberid : "MEM000004"

class Responce {
  String _xApiKey;
  String _memberid;

  String get xApiKey => _xApiKey;
  String get memberid => _memberid;

  Responce({
      String xApiKey, 
      String memberid}){
    _xApiKey = xApiKey;
    _memberid = memberid;
}

  Responce.fromJson(dynamic json) {
    _xApiKey = json["x_api_key"];
    _memberid = json["memberid"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["x_api_key"] = _xApiKey;
    map["memberid"] = _memberid;
    return map;
  }

}