class MyVariables {
  static var navBarSelectedOption = 0;

  static var username = '';
  static var password = '';

  static var username2 = '';
  static var password2 = '';

  static var checkBrightnessMode = false;

  static String errorMsg = '';
  static String connectedMsg = '';
}

class CredentialsData {
  static List<Credentials> items = [];
  static List<Credentials> items2 = [];
  static List<Credentials> checkData = [];
}

class Credentials {
  int? id;
  String? username;
  String? password;

  Credentials({this.id, this.username, this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
        id: json['id'] as int?,
        username: json['username'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
      };
}

class CredentialsNoId {
  String? username;
  String? password;

  CredentialsNoId({this.username, this.password});

  factory CredentialsNoId.fromJson(Map<String, dynamic> json) =>
      CredentialsNoId(
        username: json['username'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
