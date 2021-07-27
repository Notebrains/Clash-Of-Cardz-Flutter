/// match_result : [{"member_id":"MEM000028","no_card":"14","win":"1","loss":"0","points":"40"},{"member_id":"MEM000037","no_card":"14","win":"0","loss":"1","points":"40"}]
/// category : "Cricket"
/// unique_id : "gamePlay-MEM000028-MEM000037-1627394850-1539459674"

class SaveGameResultResModel {
  List<Match_result> _matchResult;
  String _category;
  String _uniqueId;

  List<Match_result> get matchResult => _matchResult;
  String get category => _category;
  String get uniqueId => _uniqueId;

  SaveGameResultResModel({
      List<Match_result> matchResult, 
      String category, 
      String uniqueId}){
    _matchResult = matchResult;
    _category = category;
    _uniqueId = uniqueId;
}

  SaveGameResultResModel.fromJson(dynamic json) {
    if (json["match_result"] != null) {
      _matchResult = [];
      json["match_result"].forEach((v) {
        _matchResult.add(Match_result.fromJson(v));
      });
    }
    _category = json["category"];
    _uniqueId = json["unique_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_matchResult != null) {
      map["match_result"] = _matchResult.map((v) => v.toJson()).toList();
    }
    map["category"] = _category;
    map["unique_id"] = _uniqueId;
    return map;
  }

}

/// member_id : "MEM000028"
/// no_card : "14"
/// win : "1"
/// loss : "0"
/// points : "40"

class Match_result {
  String _memberId;
  String _noCard;
  String _win;
  String _loss;
  String _points;

  String get memberId => _memberId;
  String get noCard => _noCard;
  String get win => _win;
  String get loss => _loss;
  String get points => _points;

  Match_result({
      String memberId, 
      String noCard, 
      String win, 
      String loss, 
      String points}){
    _memberId = memberId;
    _noCard = noCard;
    _win = win;
    _loss = loss;
    _points = points;
}

  Match_result.fromJson(dynamic json) {
    _memberId = json["member_id"];
    _noCard = json["no_card"];
    _win = json["win"];
    _loss = json["loss"];
    _points = json["points"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["member_id"] = _memberId;
    map["no_card"] = _noCard;
    map["win"] = _win;
    map["loss"] = _loss;
    map["points"] = _points;
    return map;
  }

}