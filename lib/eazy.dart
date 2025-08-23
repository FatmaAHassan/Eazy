
import 'package:Easy/core/routing/routes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';


class Eazy extends StatelessWidget {
  final AppRouter _appRouter;
  const Eazy({super.key, required AppRouter appRouter}) : _appRouter = appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: _appRouter.generateRoute,
      ),
    );
  }
}