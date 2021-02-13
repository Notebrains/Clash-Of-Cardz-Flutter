/// status : 1
/// message : "Data fetched succesfully"
/// response : {"page_title":"About Us","cms_meta":[{"title":"cricket","image":"https://predictfox.com/trumpcard/assets/uploads/cms/crickrtrules.png","content":"<p>dawdawdawdawdwadawd<br></p>"},{"title":"football","image":"https://predictfox.com/trumpcard/assets/uploads/cms/footballrules.jpg","content":"<p>dawdawdawdawdwadawd<br></p>"}]}

class CmsResModel {
  int _status;
  String _message;
  Response _response;

  int get status => _status;
  String get message => _message;
  Response get response => _response;

  CmsResModel({
      int status, 
      String message, 
      Response response}){
    _status = status;
    _message = message;
    _response = response;
}

  CmsResModel.fromJson(dynamic json) {
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

/// page_title : "About Us"
/// cms_meta : [{"title":"cricket","image":"https://predictfox.com/trumpcard/assets/uploads/cms/crickrtrules.png","content":"<p>dawdawdawdawdwadawd<br></p>"},{"title":"football","image":"https://predictfox.com/trumpcard/assets/uploads/cms/footballrules.jpg","content":"<p>dawdawdawdawdwadawd<br></p>"}]

class Response {
  String _pageTitle;
  List<Cms_meta> _cmsMeta;

  String get pageTitle => _pageTitle;
  List<Cms_meta> get cmsMeta => _cmsMeta;

  Response({
      String pageTitle, 
      List<Cms_meta> cmsMeta}){
    _pageTitle = pageTitle;
    _cmsMeta = cmsMeta;
}

  Response.fromJson(dynamic json) {
    _pageTitle = json["page_title"];
    if (json["cms_meta"] != null) {
      _cmsMeta = [];
      json["cms_meta"].forEach((v) {
        _cmsMeta.add(Cms_meta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["page_title"] = _pageTitle;
    if (_cmsMeta != null) {
      map["cms_meta"] = _cmsMeta.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "cricket"
/// image : "https://predictfox.com/trumpcard/assets/uploads/cms/crickrtrules.png"
/// content : "<p>dawdawdawdawdwadawd<br></p>"

class Cms_meta {
  String _title;
  String _image;
  String _content;

  String get title => _title;
  String get image => _image;
  String get content => _content;

  Cms_meta({
      String title, 
      String image, 
      String content}){
    _title = title;
    _image = image;
    _content = content;
}

  Cms_meta.fromJson(dynamic json) {
    _title = json["title"];
    _image = json["image"];
    _content = json["content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["image"] = _image;
    map["content"] = _content;
    return map;
  }

}