import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatchat/chats/data/datasources/firebase_service_storage.dart';
import 'package:whatchat/chats/presentation/pages/chat_page.dart';
import 'package:whatchat/chats/presentation/usecases.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UseCases useCases =
        UseCases(FirebaseServiceStorageImpl(storage: FirebaseStorage.instance));
    return MaterialApp(title: 'Material App', 
    initialRoute: '/',
    routes: {
      '/':(context) =>  ChatPage(useCases: useCases,)
      },
    );
  }
}
