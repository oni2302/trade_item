import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trade_item/main_page.dart';
import 'package:trade_item/screen/LoginScreen.dart';
import 'firebase_options.dart';

import 'navigation/BottomNavigation.dart';

void main() async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var box = await Hive.openBox('user');

  var user = box.get('info');
  
  Widget screen = BottomNavigation(key: GlobalKey(),);
  if(user==null){
    screen = LoginScreen();
  }
  runApp(MainPage(screen: screen));
}

