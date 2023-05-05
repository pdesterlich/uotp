import 'package:flutter/material.dart';
import 'package:uotp/helpers/network_helpers.dart';
import 'package:uotp/models/otp_item.dart';

class OtpItemRow extends StatelessWidget {
  final OtpItem otpItem;
  const OtpItemRow({super.key, required this.otpItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          FutureBuilder(
            future: NetworkHelpers.getSiteIcon(otpItem.host, 24),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            children: [
              Text(
                otpItem.name,
                style: const TextStyle(fontSize: 20),
              ),
              if (otpItem.details.isNotEmpty)
                Text(
                  otpItem.details,
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
