import 'package:flutter/material.dart';

import '../usecases.dart';

class ObtenerChatsProvider extends ChangeNotifier {
  final UseCases useCases;

  ObtenerChatsProvider({required this.useCases});
}
