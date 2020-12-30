/// member_id : "MEM000004"
/// win : "1"
/// loss : "0"
/// points : "550"

class GameResultApiBody {
  String _memberId;
  String _win;
  String _loss;
  String _points;

  String get memberId => _memberId;
  String get win => _win;
  String get loss => _loss;
  String get points => _points;

  GameResultApiBody({
      String memberId, 
      String win, 
      String loss, 
      String points}){
    _memberId = memberId;
    _win = win;
    _loss = loss;
    _points = points;
}

  GameResultApiBody.fromJson(dynamic json) {
    _memberId = json["member_id"];
    _win = json["win"];
    _loss = json["loss"];
    _points = json["points"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["member_id"] = _memberId;
    map["win"] = _win;
    map["loss"] = _loss;
    map["points"] = _points;
    return map;
  }

}