import 'package:flutter/material.dart';
import 'package:uotp/models/otp_item.dart';
import 'package:uotp/widgets/site_icon_widget.dart';

class OtpItemRow extends StatelessWidget {
  final OtpItem otpItem;
  const OtpItemRow({super.key, required this.otpItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SiteIconWidget(hostname: otpItem.host),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              otpItem.name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
