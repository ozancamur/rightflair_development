import 'base.dart';

class SupabaseModel extends BaseModel<SupabaseModel> {
  String? URL;
  String? ANON_KEY;
  String? BASE_URL;

  SupabaseModel({this.URL, this.ANON_KEY, this.BASE_URL});

  @override
  SupabaseModel copyWith({String? URL, String? ANON_KEY, String? BASE_URL}) {
    return SupabaseModel(
      URL: URL ?? this.URL,
      ANON_KEY: ANON_KEY ?? this.ANON_KEY,
      BASE_URL: BASE_URL ?? this.BASE_URL,
    );
  }

  @override
  SupabaseModel fromJson(Map<String, dynamic> json) {
    return SupabaseModel(
      URL: json['URL'],
      ANON_KEY: json['ANON_KEY'],
      BASE_URL: json['BASE_URL'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'URL': URL, 'ANON_KEY': ANON_KEY, 'BASE_URL': BASE_URL};
  }
}
