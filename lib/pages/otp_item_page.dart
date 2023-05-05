import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:uotp/helpers/network_helpers.dart';
import 'package:uotp/models/otp_item.dart';

class OtpItemPage extends StatefulWidget {
  final OtpItem otpItem;
  const OtpItemPage({super.key, required this.otpItem});

  @override
  State<OtpItemPage> createState() => _OtpItemPageState();
}

class _OtpItemPageState extends State<OtpItemPage> {
  late Timer _timer;
  String _token = '';
  int _updatingIn = 30;

  void _updateToken() {
    var token = OTP.generateTOTPCodeString(
        widget.otpItem.secret, DateTime.now().millisecondsSinceEpoch,
        algorithm: Algorithm.SHA1, isGoogle: true, interval: 30);
    setState(() {
      _token = token;
      _updatingIn = 30 - (DateTime.now().second % 30);
    });
  }

  @override
  void initState() {
    super.initState();
    _updateToken();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _updateToken());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('the Ugly OTP manager'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: NetworkHelpers.getSiteIcon(widget.otpItem.host, 24),
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
                Expanded(
                  child: Text(
                    widget.otpItem.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ]
            ),
            const SizedBox(height: 12,),
            Text(widget.otpItem.host),
            Center(
              child: Text(
                _token,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            Center(
              child: Text(
                'updating in $_updatingIn seconds',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
