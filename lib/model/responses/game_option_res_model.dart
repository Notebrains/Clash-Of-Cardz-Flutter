/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"category_name":"Sports","category_icon":"https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg","subcategory":[{"subcategory_name":"Cricket","subcategory_icon":"https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg","subcategory_details":[{"cards_to_be_played":["14","22","30"],"gametype_name":"Player vs Player","no_of_player_played":"2"},{"cards_to_be_played":["15","20","25"],"gametype_name":"Player vs Computer","no_of_player_played":"2"},{"cards_to_be_played":["10","12","14"],"gametype_name":"Tournament","no_of_player_played":"2"},{"cards_to_be_played":["20","28","40","75"],"gametype_name":"Player vs Multi Players","no_of_player_played":"4"}]}]},{"category_name":"TEST","category_icon":"https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg","subcategory":[{"subcategory_name":"Hockey","subcategory_icon":"https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg","subcategory_details":[{"cards_to_be_played":["20","28","40","75"],"gametype_name":"Player vs Multi Players","no_of_player_played":"4"}]},{"subcategory_name":"Car Racing","subcategory_icon":"https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg","subcategory_details":[{"cards_to_be_played":["20","28","40","75"],"gametype_name":"Player vs Multi Players","no_of_player_played":"4"}]}]}]

class GameOptionResModel {
  int _status;
  String _message;
  List<Response> _response;

  int get status => _status;
  String get message => _message;
  List<Response> get response => _response;

  GameOptionResModel({
      int status, 
      String message, 
      List<Response> response}){
    _status = status;
    _message = message;
    _response = response;
}

  GameOptionResModel.fromJson(dynamic json) {
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

/// category_name : "Sports"
/// category_icon : "https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg"
/// subcategory : [{"subcategory_name":"Cricket","subcategory_icon":"https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg","subcategory_details":[{"cards_to_be_played":["14","22","30"],"gametype_name":"Player vs Player","no_of_player_played":"2"},{"cards_to_be_played":["15","20","25"],"gametype_name":"Player vs Computer","no_of_player_played":"2"},{"cards_to_be_played":["10","12","14"],"gametype_name":"Tournament","no_of_player_played":"2"},{"cards_to_be_played":["20","28","40","75"],"gametype_name":"Player vs Multi Players","no_of_player_played":"4"}]}]

class Response {
  String _categoryName;
  String _categoryIcon;
  List<Subcategory> _subcategory;

  String get categoryName => _categoryName;
  String get categoryIcon => _categoryIcon;
  List<Subcategory> get subcategory => _subcategory;

  Response({
      String categoryName, 
      String categoryIcon, 
      List<Subcategory> subcategory}){
    _categoryName = categoryName;
    _categoryIcon = categoryIcon;
    _subcategory = subcategory;
}

  Response.fromJson(dynamic json) {
    _categoryName = json["category_name"];
    _categoryIcon = json["category_icon"];
    if (json["subcategory"] != null) {
      _subcategory = [];
      json["subcategory"].forEach((v) {
        _subcategory.add(Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_name"] = _categoryName;
    map["category_icon"] = _categoryIcon;
    if (_subcategory != null) {
      map["subcategory"] = _subcategory.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// subcategory_name : "Cricket"
/// subcategory_icon : "https://www.flaticon.com/svg/static/icons/svg/2636/2636890.svg"
/// subcategory_details : [{"cards_to_be_played":["14","22","30"],"gametype_name":"Player vs Player","no_of_player_played":"2"},{"cards_to_be_played":["15","20","25"],"gametype_name":"Player vs Computer","no_of_player_played":"2"},{"cards_to_be_played":["10","12","14"],"gametype_name":"Tournament","no_of_player_played":"2"},{"cards_to_be_played":["20","28","40","75"],"gametype_name":"Player vs Multi Players","no_of_player_played":"4"}]

class Subcategory {
  String _subcategoryName;
  String _subcategoryIcon;
  List<Subcategory_details> _subcategoryDetails;

  String get subcategoryName => _subcategoryName;
  String get subcategoryIcon => _subcategoryIcon;
  List<Subcategory_details> get subcategoryDetails => _subcategoryDetails;

  Subcategory({
      String subcategoryName, 
      String subcategoryIcon, 
      List<Subcategory_details> subcategoryDetails}){
    _subcategoryName = subcategoryName;
    _subcategoryIcon = subcategoryIcon;
    _subcategoryDetails = subcategoryDetails;
}

  Subcategory.fromJson(dynamic json) {
    _subcategoryName = json["subcategory_name"];
    _subcategoryIcon = json["subcategory_icon"];
    if (json["subcategory_details"] != null) {
      _subcategoryDetails = [];
      json["subcategory_details"].forEach((v) {
        _subcategoryDetails.add(Subcategory_details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subcategory_name"] = _subcategoryName;
    map["subcategory_icon"] = _subcategoryIcon;
    if (_subcategoryDetails != null) {
      map["subcategory_details"] = _subcategoryDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// cards_to_be_played : ["14","22","30"]
/// gametype_name : "Player vs Player"
/// no_of_player_played : "2"

class Subcategory_details {
  List<String> _cardsToBePlayed;
  String _gametypeName;
  String _noOfPlayerPlayed;

  List<String> get cardsToBePlayed => _cardsToBePlayed;
  String get gametypeName => _gametypeName;
  String get noOfPlayerPlayed => _noOfPlayerPlayed;

  Subcategory_details({
      List<String> cardsToBePlayed, 
      String gametypeName, 
      String noOfPlayerPlayed}){
    _cardsToBePlayed = cardsToBePlayed;
    _gametypeName = gametypeName;
    _noOfPlayerPlayed = noOfPlayerPlayed;
}

  Subcategory_details.fromJson(dynamic json) {
    _cardsToBePlayed = json["cards_to_be_played"] != null ? json["cards_to_be_played"].cast<String>() : [];
    _gametypeName = json["gametype_name"];
    _noOfPlayerPlayed = json["no_of_player_played"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cards_to_be_played"] = _cardsToBePlayed;
    map["gametype_name"] = _gametypeName;
    map["no_of_player_played"] = _noOfPlayerPlayed;
    return map;
  }

}