import 'base.dart';

class SupabaseModel extends BaseModel<SupabaseModel> {
  String? URL;
  String? ANON_KEY;

  SupabaseModel({this.URL, this.ANON_KEY});

  @override
  SupabaseModel copyWith({String? URL, String? ANON_KEY}) {
    return SupabaseModel(
      URL: URL ?? this.URL,
      ANON_KEY: ANON_KEY ?? this.ANON_KEY,
    );
  }

  @override
  SupabaseModel fromJson(Map<String, dynamic> json) {
    return SupabaseModel(URL: json['URL'], ANON_KEY: json['ANON_KEY']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'URL': URL, 'ANON_KEY': ANON_KEY};
  }
}
