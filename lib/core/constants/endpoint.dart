enum Endpoint {
  CREATE_USER("create-user"),
  CHECK_USERNAME("check-username"),
  UPDATE_USER("update-user")
  ;

  final String value;
  const Endpoint(this.value);
}
