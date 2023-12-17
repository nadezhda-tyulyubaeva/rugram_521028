import 'package:flutter/material.dart';
import 'package:rugram_521028/core/di/app_providers.dart';
import 'package:rugram_521028/features/navigation/app_router_widget.dart';

import 'di/app_services.dart';

class MyApp extends StatelessWidget {
  final AppServices appServices;

  const MyApp({
    required this.appServices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      appServices: appServices,
      child: const AppRouterWidget(),
    );
  }
}
