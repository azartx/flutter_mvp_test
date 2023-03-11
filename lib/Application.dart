import 'package:flutter/material.dart';

import 'data/resources/Localization.dart';
import 'presentation/screens/home/HomeScreen.dart';

class ApplicationWidget extends StatelessWidget {
  const ApplicationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVP app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      localizationsDelegates: [
        AppLocalizationDelegate()
      ],
    );
  }
}
