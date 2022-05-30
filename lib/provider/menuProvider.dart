import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuProvider with ChangeNotifier, DiagnosticableTreeMixin{
  MenuProvider(){

  }
  int _currentIndex = 0;

}