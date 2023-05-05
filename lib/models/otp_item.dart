class OtpItem {
  final String name;
  final String secret;
  String host = '';

  OtpItem({required this.name, required this.secret, this.host = ''});
}
