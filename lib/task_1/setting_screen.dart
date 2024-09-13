import 'package:flutter/material.dart';

import 'components/setting_item_component.dart';
import 'components/switch_with_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('security settings'),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SwitchWithText(
              value: false,
              text: 'face id',
              onChanged: (bool newValue) {
                print('execute something');
              },
            ),
            SizedBox(
              height: screenHeight * 0.012,
            ),
            SwitchWithText(
              value: false,
              text: 'pin',
              onChanged: (bool newValue) {
                print('execute something');
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SettingItemComponent(
              text: 'change pin',
              onTap: () {
                print('go to change pin screen');
              },
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const Text('password'),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SettingItemComponent(
              text: 'change password',
              onTap: () {
                print('go to change password screen');
              },
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const Text('Approved addresses'),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SettingItemComponent(
              text: 'manage',
              onTap: () {
                print('go to manage screen');
              },
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const Text('Security Keys'),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SettingItemComponent(
              text: 'add security keys',
              containsSuffix: true,
              onTap: () {
                print('go to add security keys screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
