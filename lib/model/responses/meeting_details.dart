/// status : 1
/// message : "Success"
/// response : {"category":[{"id":"1","name":"Engineering & Environmental","slug":"engineering-environmental","image":"https://thehotelproducts.com/ghra/uploads/CMS/EE1.png"},{"id":"2","name":"Food & Beverage","slug":"food-beverage","image":"https://thehotelproducts.com/ghra/uploads/CMS/FB1.png"},{"id":"3","name":"Executive Housekeeping","slug":"executive-housekeeping","image":"https://thehotelproducts.com/ghra/uploads/CMS/EHC1.png"},{"id":"4","name":"HR & Education","slug":"hr-educational","image":"https://thehotelproducts.com/ghra/uploads/CMS/HRE1.png"},{"id":"5","name":"Safety & Security","slug":"safety-security","image":"https://thehotelproducts.com/ghra/uploads/CMS/SS1.png"}],"meetings":[{"category_id":"1","category":"Engineering & Environmental","list":[]},{"category_id":"2","category":"Food & Beverage","list":[]},{"category_id":"3","category":"Executive Housekeeping","list":[]},{"category_id":"4","category":"HR & Education","list":[]},{"category_id":"5","category":"Safety & Security","list":[]}]}

class MeetingDetails {
  int _status;
  String _message;
  Response _response;

  int get status => _status;
  String get message => _message;
  Response get response => _response;

  MeetingDetails({
      int status, 
      String message, 
      Response response}){
    _status = status;
    _message = message;
    _response = response;
}

  MeetingDetails.fromJson(dynamic json) {
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

/// category : [{"id":"1","name":"Engineering & Environmental","slug":"engineering-environmental","image":"https://thehotelproducts.com/ghra/uploads/CMS/EE1.png"},{"id":"2","name":"Food & Beverage","slug":"food-beverage","image":"https://thehotelproducts.com/ghra/uploads/CMS/FB1.png"},{"id":"3","name":"Executive Housekeeping","slug":"executive-housekeeping","image":"https://thehotelproducts.com/ghra/uploads/CMS/EHC1.png"},{"id":"4","name":"HR & Education","slug":"hr-educational","image":"https://thehotelproducts.com/ghra/uploads/CMS/HRE1.png"},{"id":"5","name":"Safety & Security","slug":"safety-security","image":"https://thehotelproducts.com/ghra/uploads/CMS/SS1.png"}]
/// meetings : [{"category_id":"1","category":"Engineering & Environmental","list":[]},{"category_id":"2","category":"Food & Beverage","list":[]},{"category_id":"3","category":"Executive Housekeeping","list":[]},{"category_id":"4","category":"HR & Education","list":[]},{"category_id":"5","category":"Safety & Security","list":[]}]

class Response {
  List<Category> _category;
  List<Meetings> _meetings;

  List<Category> get category => _category;
  List<Meetings> get meetings => _meetings;

  Response({
      List<Category> category, 
      List<Meetings> meetings}){
    _category = category;
    _meetings = meetings;
}

  Response.fromJson(dynamic json) {
    if (json["category"] != null) {
      _category = [];
      json["category"].forEach((v) {
        _category.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_category != null) {
      map["category"] = _category.map((v) => v.toJson()).toList();
    }
    if (_meetings != null) {
      map["meetings"] = _meetings.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_id : "1"
/// category : "Engineering & Environmental"
/// list : []

class Meetings {
  String _categoryId;
  String _category;
  List<dynamic> _list;

  String get categoryId => _categoryId;
  String get category => _category;
  List<dynamic> get list => _list;

  Meetings({
      String categoryId, 
      String category, 
      List<dynamic> list}){
    _categoryId = categoryId;
    _category = category;
    _list = list;
}



  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = _categoryId;
    map["category"] = _category;
    if (_list != null) {
      map["list"] = _list.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Engineering & Environmental"
/// slug : "engineering-environmental"
/// image : "https://thehotelproducts.com/ghra/uploads/CMS/EE1.png"

class Category {
  String _id;
  String _name;
  String _slug;
  String _image;

  String get id => _id;
  String get name => _name;
  String get slug => _slug;
  String get image => _image;

  Category({
      String id, 
      String name, 
      String slug, 
      String image}){
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
}

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _slug = json["slug"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["slug"] = _slug;
    map["image"] = _image;
    return map;
  }

}