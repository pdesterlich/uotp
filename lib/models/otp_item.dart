class OtpItem {
  final String name;
  String details = '';
  final String secret;
  String host = '';

  OtpItem(
      {required this.name, required this.secret, this.details = '', this.host = ''});

  OtpItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        details = json['details'],
        secret = json['secret'],
        host = json['host'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'details': details,
        'secret': secret,
        'host': host,
      };

  static List<OtpItem> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OtpItem.fromJson(json)).toList();
  }
}