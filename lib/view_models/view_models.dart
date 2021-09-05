import 'package:flutter/material.dart';
import 'package:flutter_provider_example/infrastructure/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class ViewModels extends ChangeNotifier {
  ViewModels(this.context) : super();

  final BuildContext context;

  AuthRepository get _auth => context.read<AuthRepository>();

  Future<bool> isOnline() async {
    return _auth.isOnline();
  }
}
