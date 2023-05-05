import 'package:flutter/material.dart';
import 'package:uotp/models/otp_item.dart';
import 'package:uotp/pages/otp_item_page.dart';
import 'package:uotp/widgets/otp_item_row.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<OtpItem> _otpItems = [];

  Future<void> _loadOtpItems() async {
    List<OtpItem> items = [];
    items.add(OtpItem('DigitalOcean', 'test'));
    items.add(OtpItem('GitHub', 'test2'));
    setState(() {
      _otpItems.clear();
      _otpItems.addAll(items);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadOtpItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('the Ugly OTP manager'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadOtpItems,
        child: ListView.builder(
            itemCount: _otpItems.length,
            itemBuilder: (buildContext, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return OtpItemPage(
                        otpItem: _otpItems[index],
                      );
                    }),
                  );
                },
                child: OtpItemRow(otpItem: _otpItems[index]),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'add a new otp',
        child: const Icon(Icons.add),
      ),
    );
  }
}
