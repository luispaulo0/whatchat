import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatchat/chats/data/datasources/firebase_service_storage.dart';
import 'package:whatchat/chats/presentation/pages/chat_home.dart';
import 'package:whatchat/chats/presentation/usecases.dart';
import 'package:whatchat/contactos/data/datasource/firebase_service_contacto.dart';
import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';
import 'package:whatchat/users/presentation/pages/signup.dart';
import 'package:whatchat/users/presentation/usecases_config_user.dart';

import 'chats/presentation/pages/chat_page.dart';
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
    final firebasePhoneAuth =
        FirebasePhoneAuthRepository(firebaseAuth: FirebaseAuth.instance);
    final useCaseConfigUser = UseCasesConfigUser(firebasePhoneAuth);
    final UseCases useCases = UseCases(
        FirebaseServiceStorageImpl(storage: FirebaseStorage.instance),
        FirebaseServiceContactoImpl(db: FirebaseFirestore.instance));
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        // '/':(context) => ChatHome()
        // '/': (context) => Signup(
        //   registerUser: useCaseConfigUser.registerUser!,
        //   smsValidation: useCaseConfigUser.smsValidation!,
        //   verificar: useCaseConfigUser.verificacion!,
        // ),
        '/': (context) => ChatHome(
              useCases: useCases,
            ),

        '/ChatPage': (context) => ChatPage(
              useCases: useCases,
            )
      },
    );
  }
}
