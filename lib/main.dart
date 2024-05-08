import 'package:admin_app/pages/contactUs.dart';
import 'package:admin_app/pages/deleteUser.dart';
import 'package:admin_app/pages/deleteUserConfirmation.dart';
import 'package:admin_app/pages/home.dart';
import 'package:admin_app/pages/privacyPolicy.dart';
import 'package:admin_app/providers/locale_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDSBBIJnN5cWAyVZGnTGfiq36wcsnynyz4",
    authDomain: "sm-app-4347b.firebaseapp.com",
    projectId: "sm-app-4347b",
    storageBucket: "sm-app-4347b.appspot.com",
    messagingSenderId: "988198906820",
    appId: "1:988198906820:web:f7ca3ecea79c36bbbc5291",
    measurementId: "G-28XPKPS3EJ",
  ));
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        DeleteUser.route: (context) => const DeleteUser(),
        DeleteUserConfirmation.route: (context) =>
            const DeleteUserConfirmation(),
        PrivacyPolicy.route: (context) => const PrivacyPolicy(),
        ContactUs.route: (context) => const ContactUs(),
      },
      title: 'Dave',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          primary: Color.fromARGB(255, 89, 36, 99),
          primaryContainer: Color.fromARGB(255, 89, 36, 99),
          secondaryContainer: Colors.grey,
          secondary: Color.fromARGB(255, 244, 186, 184),
          onBackground: Colors.black,
        ),
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Provider.of<LocaleProvider>(context).locale,
    );
  }
}
