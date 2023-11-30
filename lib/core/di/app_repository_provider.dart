import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRepositoriesProvider extends StatefulWidget {
  final Widget child;

  const AppRepositoriesProvider({
    super.key,
    required this.child
  });


  @override
  State<StatefulWidget> createState() => _AppRepositoriesProviderState();
}

class _AppRepositoriesProviderState extends State<AppRepositoriesProvider>{
  @override
  Widget build(BuildContext context) {

  return widget.child;
  }
  
}

