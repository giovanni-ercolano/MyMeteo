import 'package:MyMeteo/providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyMeteo/firebase/firebase_analytics.dart';
import 'package:MyMeteo/firebase_options.dart';
import 'package:MyMeteo/pages/authpage.dart';
import 'package:MyMeteo/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.deepPurpleAccent,
    // Aggiungi altre personalizzazioni qui...
  );

  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.orangeAccent,
    // Aggiungi altre personalizzazioni qui...
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [AnalyticsService.analyticsObserver],
            theme: model.isDarkMode ? darkTheme : lightTheme,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return HomePage();
                  } else {
                    return const AuthPage();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
