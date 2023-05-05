import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:uotp/models/otp_item.dart';

class OtpItemPage extends StatefulWidget {
  final OtpItem otpItem;
  const OtpItemPage({super.key, required this.otpItem});

  @override
  State<OtpItemPage> createState() => _OtpItemPageState();
}

class _OtpItemPageState extends State<OtpItemPage> {
  String getOtp() {
    return OTP.generateTOTPCodeString(
        widget.otpItem.secret, DateTime.now().millisecondsSinceEpoch,
        algorithm: Algorithm.SHA1, isGoogle: true, interval: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('the Ugly OTP manager'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(widget.otpItem.name),
            Text(widget.otpItem.secret),
            Text(getOtp()),
          ],
        ),
      ),
    );
  }
}
