class MyException implements Exception {

  int code;
  String message;

  MyException({this.code, this.message});

  factory MyException.fromJson(Map<String, dynamic> json) {
    return MyException(
        code: json['code'],
        message: json['message']
    );
  }
}
