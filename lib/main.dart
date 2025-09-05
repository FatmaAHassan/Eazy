import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/routing/app_router.dart';
import 'package:eazy/eazy.dart';
import 'package:flutter/foundation.dart';

void main() async {
  // await ServicesInitializer.init();
  // runApp(Eazy(appRouter: AppRouter()));
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => Eazy(appRouter: AppRouter()),
    ),
  );
}