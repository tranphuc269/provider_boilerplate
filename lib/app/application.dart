import 'dart:async';

import 'package:provider/provider.dart';

class Application {
  Application(this.read) : super();

  final Locator read;
}
