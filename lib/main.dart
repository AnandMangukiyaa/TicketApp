import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticket/core/routes/app_routes.dart';
import 'package:flutter_ticket/core/utils/utils.dart';

import 'core/constants/constants.dart';
import 'firebase_options.dart';
import 'injector.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Injector.init();

  runApp(const ProviderScope(child: MyApp()));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      navigatorKey: navigatorKey,
      theme: ThemeUtils.theme,
      initialRoute: Routes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehaviorModified(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              ScreenUtil.init(
                constraints,
                designSize: Size(constraints.maxWidth, constraints.maxHeight),
              );
              return child ?? const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}


