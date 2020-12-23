/// status : 1
/// message : "Data fetched succesfully"
/// response : {"catagory":"sports","subcatagory":"cricket","card_count":"14","cards":[{"card_name":"MS Dhoni","card_img":"https://predictfox.com/trumpcard/assets/uploads/carddetails/1608629874.jpeg","nationality":"indian","flag_image":"https://predictfox.com/trumpcard/assets/uploads/carddetails/1608629874.png","attribute":[{"name":"MATCHES","value":"500","win_basis":"Highest Value","win_points":"10"},{"name":"WICKETS","value":"1000","win_basis":"Highest Value","win_points":"15"},{"name":"RUNS","value":"25000","win_basis":"Highest Value","win_points":"25"},{"name":"CATCHES","value":"200","win_basis":"Highest Value","win_points":"5"},{"name":"SEASONS","value":"12","win_basis":"Highest Value","win_points":"20"}]}]}

class CardsResModel {
  int _status;
  String _message;
  Response _response;

  int get status => _status;
  String get message => _message;
  Response get response => _response;

  CardsResModel({
      int status, 
      String message, 
      Response response}){
    _status = status;
    _message = message;
    _response = response;
}

  CardsResModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _response = json["response"] != null ? Response.fromJson(json["response"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_response != null) {
      map["response"] = _response.toJson();
    }
    return map;
  }

}

/// catagory : "sports"
/// subcatagory : "cricket"
/// card_count : "14"
/// cards : [{"card_name":"MS Dhoni","card_img":"https://predictfox.com/trumpcard/assets/uploads/carddetails/1608629874.jpeg","nationality":"indian","flag_image":"https://predictfox.com/trumpcard/assets/uploads/carddetails/1608629874.png","attribute":[{"name":"MATCHES","value":"500","win_basis":"Highest Value","win_points":"10"},{"name":"WICKETS","value":"1000","win_basis":"Highest Value","win_points":"15"},{"name":"RUNS","value":"25000","win_basis":"Highest Value","win_points":"25"},{"name":"CATCHES","value":"200","win_basis":"Highest Value","win_points":"5"},{"name":"SEASONS","value":"12","win_basis":"Highest Value","win_points":"20"}]}]

class Response {
  String _catagory;
  String _subcatagory;
  String _cardCount;
  List<Cards> _cards;

  String get catagory => _catagory;
  String get subcatagory => _subcatagory;
  String get cardCount => _cardCount;
  List<Cards> get cards => _cards;

  Response({
      String catagory, 
      String subcatagory, 
      String cardCount, 
      List<Cards> cards}){
    _catagory = catagory;
    _subcatagory = subcatagory;
    _cardCount = cardCount;
    _cards = cards;
}

  Response.fromJson(dynamic json) {
    _catagory = json["catagory"];
    _subcatagory = json["subcatagory"];
    _cardCount = json["card_count"];
    if (json["cards"] != null) {
      _cards = [];
      json["cards"].forEach((v) {
        _cards.add(Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["catagory"] = _catagory;
    map["subcatagory"] = _subcatagory;
    map["card_count"] = _cardCount;
    if (_cards != null) {
      map["cards"] = _cards.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// card_name : "MS Dhoni"
/// card_img : "https://predictfox.com/trumpcard/assets/uploads/carddetails/1608629874.jpeg"
/// nationality : "indian"
/// flag_image : "https://predictfox.com/trumpcard/assets/uploads/carddetails/1608629874.png"
/// attribute : [{"name":"MATCHES","value":"500","win_basis":"Highest Value","win_points":"10"},{"name":"WICKETS","value":"1000","win_basis":"Highest Value","win_points":"15"},{"name":"RUNS","value":"25000","win_basis":"Highest Value","win_points":"25"},{"name":"CATCHES","value":"200","win_basis":"Highest Value","win_points":"5"},{"name":"SEASONS","value":"12","win_basis":"Highest Value","win_points":"20"}]

class Cards {
  String _cardName;
  String _cardImg;
  String _nationality;
  String _flagImage;
  List<Attribute> _attribute;

  String get cardName => _cardName;
  String get cardImg => _cardImg;
  String get nationality => _nationality;
  String get flagImage => _flagImage;
  List<Attribute> get attribute => _attribute;

  Cards({
      String cardName, 
      String cardImg, 
      String nationality, 
      String flagImage, 
      List<Attribute> attribute}){
    _cardName = cardName;
    _cardImg = cardImg;
    _nationality = nationality;
    _flagImage = flagImage;
    _attribute = attribute;
}

  Cards.fromJson(dynamic json) {
    _cardName = json["card_name"];
    _cardImg = json["card_img"];
    _nationality = json["nationality"];
    _flagImage = json["flag_image"];
    if (json["attribute"] != null) {
      _attribute = [];
      json["attribute"].forEach((v) {
        _attribute.add(Attribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["card_name"] = _cardName;
    map["card_img"] = _cardImg;
    map["nationality"] = _nationality;
    map["flag_image"] = _flagImage;
    if (_attribute != null) {
      map["attribute"] = _attribute.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "MATCHES"
/// value : "500"
/// win_basis : "Highest Value"
/// win_points : "10"

class Attribute {
  String _name;
  String _value;
  String _winBasis;
  String _winPoints;

  String get name => _name;
  String get value => _value;
  String get winBasis => _winBasis;
  String get winPoints => _winPoints;

  Attribute({
      String name, 
      String value, 
      String winBasis, 
      String winPoints}){
    _name = name;
    _value = value;
    _winBasis = winBasis;
    _winPoints = winPoints;
}

  Attribute.fromJson(dynamic json) {
    _name = json["name"];
    _value = json["value"];
    _winBasis = json["win_basis"];
    _winPoints = json["win_points"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["value"] = _value;
    map["win_basis"] = _winBasis;
    map["win_points"] = _winPoints;
    return map;
  }

}