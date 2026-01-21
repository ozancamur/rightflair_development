import 'base.dart';

class ResponseModel extends BaseModel<ResponseModel> {
  bool? success;
  String? message;
  Object? data;

  ResponseModel({this.success, this.message, this.data});

  @override
  ResponseModel copyWith({bool? success, String? message, Object? data}) {
    return ResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  ResponseModel fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as Object?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }
}
