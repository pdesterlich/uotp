import 'package:flutter/material.dart';
import 'package:uotp/models/otp_item.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final txtNameController = TextEditingController();
  final txtSecretController = TextEditingController();
  final txtDetailsController = TextEditingController();
  final txtHostController = TextEditingController();

  void _onSave() {
    if (txtNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name is required'),
        ),
      );
      return;
    }
    if (txtSecretController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Secret is required'),
        ),
      );
      return;
    }
    var result = OtpItem(name: txtNameController.text, secret: txtSecretController.text, details: txtDetailsController.text, host: txtHostController.text);
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert new OTP'),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: txtNameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: txtSecretController,
              decoration: const InputDecoration(
                labelText: 'Secret',
              ),
            ),
            TextField(
              controller: txtDetailsController,
              decoration: const InputDecoration(
                labelText: 'Details',
              ),
            ),
            TextField(
              controller: txtHostController,
              decoration: const InputDecoration(
                labelText: 'Host',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Expanded(child: SizedBox(height: 10,),),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onSave,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
