import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrpmile/views/ActivitySplash.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'my_family',
        ),
        home: ActivitySplash(),
      ),
    );
  });
}
