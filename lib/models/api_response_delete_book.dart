import 'dart:convert';
/// _success : true
/// _error : ""

ApiResponseDeleteBook apiResponseDeleteBookFromJson(String str) => ApiResponseDeleteBook.fromJson(json.decode(str));
String apiResponseDeleteBookToJson(ApiResponseDeleteBook data) => json.encode(data.toJson());
class ApiResponseDeleteBook {
  ApiResponseDeleteBook({
      bool? success, 
      String? error,}){
    _success = success;
    _error = error;
}

  ApiResponseDeleteBook.fromJson(dynamic json) {
    _success = json['_success'];
    _error = json['_error'];
  }
  bool? _success;
  String? _error;
ApiResponseDeleteBook copyWith({  bool? success,
  String? error,
}) => ApiResponseDeleteBook(  success: success ?? _success,
  error: error ?? _error,
);
  bool? get success => _success;
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_success'] = _success;
    map['_error'] = _error;
    return map;
  }

}