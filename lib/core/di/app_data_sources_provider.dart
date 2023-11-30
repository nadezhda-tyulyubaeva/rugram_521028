import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram_521028/core/di/app_services.dart';
import 'package:rugram_521028/data_sources/post/post_data_source.dart';

class AppDataSourcesProvider extends StatefulWidget {
  final Widget child;

  const AppDataSourcesProvider({
    super.key,
    required this.child
  });

  @override
  State<StatefulWidget> createState() => _AppDataSourcesProviderState();
}

class _AppDataSourcesProviderState extends State<AppDataSourcesProvider>{
  late final Dio dio;
  late final PostDataSource postDataSource;

  @override
  void initState(){
    dio = context.read<AppServices>().dio;
    initDataSources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: postDataSource),
      ],
      child: widget.child,
    );
  }

  void initDataSources() {
    postDataSource = PostDataSource(dio);
  }
}