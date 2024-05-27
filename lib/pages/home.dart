import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final reportsRef = FirebaseFirestore.instance.collection('reports');

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Uri iosUri = Uri(
      scheme: 'https',
      host: "apps.apple.com",
      path: "us/app/dave/id6477802709");
  final Uri androidUri = Uri(
    scheme: 'https',
    host: "play.google.com",
    path: "store/apps/details",
    queryParameters: {'id': 'com.dchateauvert.sm_app'},
  );
  final double maxWidth = 500.0;
  final double titleFactor = 0.18;
  final double dowloadFactor = 0.06;
  final double modalTitleFactor = 0.1;
  final double modalOptionsFactor = 0.05;
  final double logoFactor = 0.1;

  getResponseTextSize(context, double currentWidth, String type) {
    switch (type) {
      case 'title':
        if (currentWidth > maxWidth) {
          return 64;
        } else {
          return currentWidth * titleFactor;
        }
      case 'download':
        if (currentWidth > maxWidth) {
          return 32;
        } else {
          return currentWidth * dowloadFactor;
        }
      case 'modalTitle':
        if (currentWidth > maxWidth) {
          return 40;
        } else {
          return currentWidth * modalTitleFactor;
        }
      case 'modalOptions':
        if (currentWidth > maxWidth) {
          return 24;
        } else {
          return currentWidth * modalOptionsFactor;
        }
      case 'logo':
        if (currentWidth > maxWidth) {
          return 64;
        } else {
          return currentWidth * logoFactor;
        }
      default:
        return 32;
    }
  }

  showModalOldUser(parentContext, Uri uri, double currentWidth) {
    return showDialog(
      context: parentContext,
      builder: ((context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
          title: Text(
            AppLocalizations.of(context)!.message_from_dave,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontSize:
                  getResponseTextSize(context, currentWidth, "modalTitle"),
              fontWeight: FontWeight.w900,
            ),
          ),
          children: [
            Text(
              AppLocalizations.of(context)!.important_info_text_1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize:
                    getResponseTextSize(context, currentWidth, "modalOptions"),
                fontWeight: FontWeight.w800,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              AppLocalizations.of(context)!.important_info_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize:
                    getResponseTextSize(context, currentWidth, "modalOptions"),
                fontWeight: FontWeight.w800,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              AppLocalizations.of(context)!.important_info_text_2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize:
                    getResponseTextSize(context, currentWidth, "modalOptions"),
                fontWeight: FontWeight.w800,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            SimpleDialogOption(
              onPressed: () => launchUrl(uri),
              child: Text(
                AppLocalizations.of(context)!.ok,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 89, 36, 99),
                  fontFamily: 'Raleway',
                  fontSize: getResponseTextSize(
                      context, currentWidth, "modalOptions"),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  showModal(parentContext, Uri uri, double currentWidth) {
    return showDialog(
      context: parentContext,
      builder: ((context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
          title: Text(
            AppLocalizations.of(context)!.important_info,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontSize:
                  getResponseTextSize(context, currentWidth, "modalTitle"),
              fontWeight: FontWeight.w900,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showModalOldUser(context, uri, currentWidth);
              },
              child: Text(
                AppLocalizations.of(context)!.yes,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: getResponseTextSize(
                      context, currentWidth, "modalOptions"),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => launchUrl(uri),
              child: Text(
                AppLocalizations.of(context)!.no,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: getResponseTextSize(
                      context, currentWidth, "modalOptions"),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 121, 65, 63),
              Color.fromARGB(255, 89, 36, 99),
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: currentWidth > maxWidth ? 128.0 : 64.0,
              ),
              Text(
                AppLocalizations.of(context)!.want_dave,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: getResponseTextSize(context, currentWidth, "title"),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: currentWidth > maxWidth ? 128.0 : 64.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => showModal(context, iosUri, currentWidth),
                    child: Text(
                      AppLocalizations.of(context)!.on_ios,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: getResponseTextSize(
                            context, currentWidth, "download"),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Image.asset(
                    'assets/images/apple-logo.png',
                    height: getResponseTextSize(context, currentWidth, "logo"),
                  ),
                ],
              ),
              const SizedBox(height: 88.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () =>
                        showModal(context, androidUri, currentWidth),
                    child: Text(
                      AppLocalizations.of(context)!.on_android,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: getResponseTextSize(
                            context, currentWidth, "download"),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Image.asset(
                    'assets/images/android-logo.png',
                    height: getResponseTextSize(context, currentWidth, "logo"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
