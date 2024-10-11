import 'dart:convert';
/// _error : ""
/// _success : true

ResponseApiAppmasterDeleteBook responseApiAppmasterDeleteBookFromJson(String str) => ResponseApiAppmasterDeleteBook.fromJson(json.decode(str));
String responseApiAppmasterDeleteBookToJson(ResponseApiAppmasterDeleteBook data) => json.encode(data.toJson());
class ResponseApiAppmasterDeleteBook {
  ResponseApiAppmasterDeleteBook({
      String? error, 
      bool? success,}){
    _error = error;
    _success = success;
}

  ResponseApiAppmasterDeleteBook.fromJson(dynamic json) {
    _error = json['_error'];
    _success = json['_success'];
  }
  String? _error;
  bool? _success;
ResponseApiAppmasterDeleteBook copyWith({  String? error,
  bool? success,
}) => ResponseApiAppmasterDeleteBook(  error: error ?? _error,
  success: success ?? _success,
);
  String? get error => _error;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_error'] = _error;
    map['_success'] = _success;
    return map;
  }

}