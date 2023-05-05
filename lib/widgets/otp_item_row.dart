import 'package:flutter/material.dart';
import 'package:uotp/models/otp_item.dart';
import 'package:otp/otp.dart';

class OtpItemRow extends StatelessWidget {
  final OtpItem otpItem;
  const OtpItemRow({super.key, required this.otpItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Text(otpItem.name),
          ),
          Text(OTP.generateTOTPCodeString(
              otpItem.secret, DateTime.now().millisecondsSinceEpoch,
              algorithm: Algorithm.SHA1, isGoogle: true, interval: 30)),
        ],
      ),
    );
  }
}
