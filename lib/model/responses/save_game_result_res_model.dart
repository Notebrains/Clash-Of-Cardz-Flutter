/// match_result : [{"unique_id":"gamePlay-MEM000037-MEM000028-1627387792-931672874","member_id":"MEM000037","no_card":"14","win":"1","loss":"0","points":"20"},{"unique_id":"gamePlay-MEM000037-MEM000028-1627387792-931672874","member_id":"MEM000028","no_card":"14","win":"0","loss":"1","points":"0"}]
/// category : "Cricket"

class SaveGameResultResModel {
  List<Match_result> _matchResult;
  String _category;

  List<Match_result> get matchResult => _matchResult;
  String get category => _category;

  SaveGameResultResModel({
      List<Match_result> matchResult, 
      String category}){
    _matchResult = matchResult;
    _category = category;
}

  SaveGameResultResModel.fromJson(dynamic json) {
    if (json["match_result"] != null) {
      _matchResult = [];
      json["match_result"].forEach((v) {
        _matchResult.add(Match_result.fromJson(v));
      });
    }
    _category = json["category"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_matchResult != null) {
      map["match_result"] = _matchResult.map((v) => v.toJson()).toList();
    }
    map["category"] = _category;
    return map;
  }

}

/// unique_id : "gamePlay-MEM000037-MEM000028-1627387792-931672874"
/// member_id : "MEM000037"
/// no_card : "14"
/// win : "1"
/// loss : "0"
/// points : "20"

class Match_result {
  String _uniqueId;
  String _memberId;
  String _noCard;
  String _win;
  String _loss;
  String _points;

  String get uniqueId => _uniqueId;
  String get memberId => _memberId;
  String get noCard => _noCard;
  String get win => _win;
  String get loss => _loss;
  String get points => _points;

  Match_result({
      String uniqueId, 
      String memberId, 
      String noCard, 
      String win, 
      String loss, 
      String points}){
    _uniqueId = uniqueId;
    _memberId = memberId;
    _noCard = noCard;
    _win = win;
    _loss = loss;
    _points = points;
}

  Match_result.fromJson(dynamic json) {
    _uniqueId = json["unique_id"];
    _memberId = json["member_id"];
    _noCard = json["no_card"];
    _win = json["win"];
    _loss = json["loss"];
    _points = json["points"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["unique_id"] = _uniqueId;
    map["member_id"] = _memberId;
    map["no_card"] = _noCard;
    map["win"] = _win;
    map["loss"] = _loss;
    map["points"] = _points;
    return map;
  }

}