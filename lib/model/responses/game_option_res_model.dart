/// status : 1
/// message : "Data fetched succesfully"
/// response : [{"category_name":"Sports","category_icon":"https://predictfox.com/trumpcard/assets/uploads/category/<i class=\"fas fa-icons\"></i>","category_details":[{"sub1category_name":"Cricket","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613028617cricket.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613048400crickrtrules.png","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613028617Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[{"sub2category_name":"ALL PLAYERS","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892cricket.svg","sub2category_details":[{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game1.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]},{"sub2category_name":"IPL","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892crickrtrules.png","sub2category_details":[{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/1613553533game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161295438816129543881612954388cricket1.svg","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]}]},{"sub1category_name":"Badminton","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613029477badminton.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613029477footballrules.jpg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613029477Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[{"sub2category_name":"ALL TIME PLAYER","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/1612956779badminton.svg","sub2category_details":[]}]},{"sub1category_name":"Football","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613049333football-ball.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613049333footballrules.jpg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613049333Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[]},{"sub1category_name":"formula 1","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613032646racing-car.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613032646footballrules.jpg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/161303261916130326191613032619Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[]}]},{"category_name":"TEST","category_icon":"https://predictfox.com/trumpcard/assets/uploads/category/<i class=\"fas fa-icons\"></i>","category_details":[{"sub1category_name":"testing","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/161304963616130496361613049636crickrtrules.png","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/161304963616130496361613049636index.jpeg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/161304963616130496361613049636Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[{"sub2category_name":"tst","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161305027416130502741613050274cricket.svg","sub2category_details":[{"sub3category_name":"skjdfkjsdfhjkdhf","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161305047816130504781613050478football-ball.svg","card_type":[]}]},{"sub2category_name":"tcjuhsdfljhcv","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161305034616130503461613050346badminton.svg","sub2category_details":[]}]}]}]

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
/// category_icon : "https://predictfox.com/trumpcard/assets/uploads/category/<i class=\"fas fa-icons\"></i>"
/// category_details : [{"sub1category_name":"Cricket","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613028617cricket.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613048400crickrtrules.png","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613028617Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[{"sub2category_name":"ALL PLAYERS","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892cricket.svg","sub2category_details":[{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game1.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]},{"sub2category_name":"IPL","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892crickrtrules.png","sub2category_details":[{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/1613553533game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161295438816129543881612954388cricket1.svg","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]}]},{"sub1category_name":"Badminton","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613029477badminton.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613029477footballrules.jpg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613029477Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[{"sub2category_name":"ALL TIME PLAYER","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/1612956779badminton.svg","sub2category_details":[]}]},{"sub1category_name":"Football","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613049333football-ball.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613049333footballrules.jpg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613049333Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[]},{"sub1category_name":"formula 1","sub1category_icon":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613032646racing-car.svg","sub1category_background":"https://predictfox.com/trumpcard/assets/uploads/subcategory/1613032646footballrules.jpg","sub1category_audio":"https://predictfox.com/trumpcard/assets/uploads/subcategory/161303261916130326191613032619Somebody-Like-You_15_SHK013501.mp3","sub1category_details":[]}]

class Response {
  String _categoryName;
  String _categoryIcon;
  List<Category_details> _categoryDetails;

  String get categoryName => _categoryName;
  String get categoryIcon => _categoryIcon;
  List<Category_details> get categoryDetails => _categoryDetails;

  Response({
      String categoryName, 
      String categoryIcon, 
      List<Category_details> categoryDetails}){
    _categoryName = categoryName;
    _categoryIcon = categoryIcon;
    _categoryDetails = categoryDetails;
}

  Response.fromJson(dynamic json) {
    _categoryName = json["category_name"];
    _categoryIcon = json["category_icon"];
    if (json["category_details"] != null) {
      _categoryDetails = [];
      json["category_details"].forEach((v) {
        _categoryDetails.add(Category_details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_name"] = _categoryName;
    map["category_icon"] = _categoryIcon;
    if (_categoryDetails != null) {
      map["category_details"] = _categoryDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// sub1category_name : "Cricket"
/// sub1category_icon : "https://predictfox.com/trumpcard/assets/uploads/subcategory/1613028617cricket.svg"
/// sub1category_background : "https://predictfox.com/trumpcard/assets/uploads/subcategory/1613048400crickrtrules.png"
/// sub1category_audio : "https://predictfox.com/trumpcard/assets/uploads/subcategory/1613028617Somebody-Like-You_15_SHK013501.mp3"
/// sub1category_details : [{"sub2category_name":"ALL PLAYERS","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892cricket.svg","sub2category_details":[{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game1.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]},{"sub2category_name":"IPL","sub2category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892crickrtrules.png","sub2category_details":[{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/1613553533game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161295438816129543881612954388cricket1.svg","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]}]

class Category_details {
  String _sub1categoryName;
  String _sub1categoryIcon;
  String _sub1categoryBackground;
  String _sub1categoryAudio;
  List<Sub1category_details> _sub1categoryDetails;

  String get sub1categoryName => _sub1categoryName;
  String get sub1categoryIcon => _sub1categoryIcon;
  String get sub1categoryBackground => _sub1categoryBackground;
  String get sub1categoryAudio => _sub1categoryAudio;
  List<Sub1category_details> get sub1categoryDetails => _sub1categoryDetails;

  Category_details({
      String sub1categoryName, 
      String sub1categoryIcon, 
      String sub1categoryBackground, 
      String sub1categoryAudio, 
      List<Sub1category_details> sub1categoryDetails}){
    _sub1categoryName = sub1categoryName;
    _sub1categoryIcon = sub1categoryIcon;
    _sub1categoryBackground = sub1categoryBackground;
    _sub1categoryAudio = sub1categoryAudio;
    _sub1categoryDetails = sub1categoryDetails;
}

  Category_details.fromJson(dynamic json) {
    _sub1categoryName = json["sub1category_name"];
    _sub1categoryIcon = json["sub1category_icon"];
    _sub1categoryBackground = json["sub1category_background"];
    _sub1categoryAudio = json["sub1category_audio"];
    if (json["sub1category_details"] != null) {
      _sub1categoryDetails = [];
      json["sub1category_details"].forEach((v) {
        _sub1categoryDetails.add(Sub1category_details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["sub1category_name"] = _sub1categoryName;
    map["sub1category_icon"] = _sub1categoryIcon;
    map["sub1category_background"] = _sub1categoryBackground;
    map["sub1category_audio"] = _sub1categoryAudio;
    if (_sub1categoryDetails != null) {
      map["sub1category_details"] = _sub1categoryDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// sub2category_name : "ALL PLAYERS"
/// sub2category_icon : "https://predictfox.com/trumpcard/assets/uploads/subsubcategory/161294089216129408921612940892cricket.svg"
/// sub2category_details : [{"sub3category_name":"1991-2000","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]},{"sub3category_name":"2001-2010","sub3category_icon":"https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game1.png","card_type":[{"type":"BOWLER"},{"type":"BATSMEN"}]}]

class Sub1category_details {
  String _sub2categoryName;
  String _sub2categoryIcon;
  List<Sub2category_details> _sub2categoryDetails;

  String get sub2categoryName => _sub2categoryName;
  String get sub2categoryIcon => _sub2categoryIcon;
  List<Sub2category_details> get sub2categoryDetails => _sub2categoryDetails;

  Sub1category_details({
      String sub2categoryName, 
      String sub2categoryIcon, 
      List<Sub2category_details> sub2categoryDetails}){
    _sub2categoryName = sub2categoryName;
    _sub2categoryIcon = sub2categoryIcon;
    _sub2categoryDetails = sub2categoryDetails;
}

  Sub1category_details.fromJson(dynamic json) {
    _sub2categoryName = json["sub2category_name"];
    _sub2categoryIcon = json["sub2category_icon"];
    if (json["sub2category_details"] != null) {
      _sub2categoryDetails = [];
      json["sub2category_details"].forEach((v) {
        _sub2categoryDetails.add(Sub2category_details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["sub2category_name"] = _sub2categoryName;
    map["sub2category_icon"] = _sub2categoryIcon;
    if (_sub2categoryDetails != null) {
      map["sub2category_details"] = _sub2categoryDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// sub3category_name : "1991-2000"
/// sub3category_icon : "https://predictfox.com/trumpcard/assets/uploads/subsubsubcategory/161355371716135537171613553717game.png"
/// card_type : [{"type":"BOWLER"},{"type":"BATSMEN"}]

class Sub2category_details {
  String _sub3categoryName;
  String _sub3categoryIcon;
  List<Card_type> _cardType;

  String get sub3categoryName => _sub3categoryName;
  String get sub3categoryIcon => _sub3categoryIcon;
  List<Card_type> get cardType => _cardType;

  Sub2category_details({
      String sub3categoryName, 
      String sub3categoryIcon, 
      List<Card_type> cardType}){
    _sub3categoryName = sub3categoryName;
    _sub3categoryIcon = sub3categoryIcon;
    _cardType = cardType;
}

  Sub2category_details.fromJson(dynamic json) {
    _sub3categoryName = json["sub3category_name"];
    _sub3categoryIcon = json["sub3category_icon"];
    if (json["card_type"] != null) {
      _cardType = [];
      json["card_type"].forEach((v) {
        _cardType.add(Card_type.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["sub3category_name"] = _sub3categoryName;
    map["sub3category_icon"] = _sub3categoryIcon;
    if (_cardType != null) {
      map["card_type"] = _cardType.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "BOWLER"

class Card_type {
  String _type;

  String get type => _type;

  Card_type({
      String type}){
    _type = type;
}

  Card_type.fromJson(dynamic json) {
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    return map;
  }

}