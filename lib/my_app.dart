import 'package:flutter/material.dart';
import 'utils/helpers/screen_util.dart';
import 'utils/routing/app_router.dart';
import 'utils/routing/routes.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context); // Initialize ScreenUtil
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.lightTheme,
      title: 'Dollars',
      initialRoute: Routes.splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}