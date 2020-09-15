import 'package:covid19fsy/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data_source.dart';

void main()async{


  runApp(
      MaterialApp(

          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ar'), // English
            const Locale('ar'), // Hebrew
            const Locale.fromSubtags(languageCode: 'ar'), // Chinese *See Advanced Locales below*
            // ... other locales the app supports
          ],
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Circular',
      primaryColor: primaryBlack

    ),

    home: new Home()
  ));
}

