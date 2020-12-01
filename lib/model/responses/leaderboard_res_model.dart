/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"memberid":"MEM000004","fullname":"dgdg","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"650","rank":1},{"memberid":"MEM000001","fullname":"ram","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"250","rank":2},{"memberid":"MEM000002","fullname":"sam","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"250","rank":3},{"memberid":"MEM000003","fullname":"bam","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"0","rank":4},{"memberid":"MEM000022","fullname":"drververv","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"0","rank":5},{"memberid":"MEM000023","fullname":"gdrgd","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"0","rank":6},{"memberid":"MEM000024","fullname":"drververv","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"0","rank":7},{"memberid":"MEM000025","fullname":"drververv","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"0","rank":8},{"memberid":"MEM000026","fullname":"drververv","photo":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU","points":"0","rank":9}]

class LeaderboardResModel {
  int _status;
  String _message;
  List<Response> _response;

  int get status => _status;
  String get message => _message;
  List<Response> get response => _response;

  LeaderboardResModel({
      int status, 
      String message, 
      List<Response> response}){
    _status = status;
    _message = message;
    _response = response;
}

  LeaderboardResModel.fromJson(dynamic json) {
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

/// memberid : "MEM000004"
/// fullname : "dgdg"
/// photo : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRiO1D51PX-BWFxtKFukrymxo_iSk-5rBu3Fg&usqp=CAU"
/// points : "650"
/// rank : 1

class Response {
  String _memberid;
  String _fullname;
  String _photo;
  String _points;
  int _rank;

  String get memberid => _memberid;
  String get fullname => _fullname;
  String get photo => _photo;
  String get points => _points;
  int get rank => _rank;

  Response({
      String memberid, 
      String fullname, 
      String photo, 
      String points, 
      int rank}){
    _memberid = memberid;
    _fullname = fullname;
    _photo = photo;
    _points = points;
    _rank = rank;
}

  Response.fromJson(dynamic json) {
    _memberid = json["memberid"];
    _fullname = json["fullname"];
    _photo = json["photo"];
    _points = json["points"];
    _rank = json["rank"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["memberid"] = _memberid;
    map["fullname"] = _fullname;
    map["photo"] = _photo;
    map["points"] = _points;
    map["rank"] = _rank;
    return map;
  }

}