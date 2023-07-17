import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatchat/users/domain/entities/user.dart' as Usern;

abstract class PhoneAuthRepository {
  Future<void> verifyPhoneNumber(String username, String phoneNumber);
  Future<String?> signInWithPhoneNumber(String smsCode);
  Future<String?> existUser(String phoneNumber);
}

class FirebasePhoneAuthRepository implements PhoneAuthRepository {
  final FirebaseAuth firebaseAuth;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? verificationId;
  String? username;
  String? phone;
  String? usuarios;

  FirebasePhoneAuthRepository({required this.firebaseAuth});

  @override
  Future<void> verifyPhoneNumber(String username, String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // El número de teléfono se verificó automáticamente
        // Puedes usar `credential` para autenticar al usuario
      },
      verificationFailed: (FirebaseAuthException e) {
        // Ocurrió un error durante la verificación
        print('No se pudo verificar este numero de telefono $e');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        this.username = username;
        phone = phone;
        // El código de verificación se envió con éxito al número de teléfono
        // Puedes mostrar una pantalla para que el usuario ingrese el código
        // y luego llamar a `signInWithPhoneNumber` con `verificationId` y el código ingresado
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // El código de verificación no se recibió automáticamente después de cierto tiempo
        // Puedes mostrar una pantalla para que el usuario ingrese el código manualmente
        // y luego llamar a `signInWithPhoneNumber` con `verificationId` y el código ingresado
      },
    );
  }

  @override
  Future<String?> signInWithPhoneNumber(String smsCode) async {
    try {
      // Crea una instancia de PhoneAuthCredential utilizando el `verificationId` y el `smsCode`
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode,
      );

      // Autentica al usuario con el credential
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      // Obtiene el ID de usuario

      // Guarda los datos del usuario en Firestore
      final newUser =
          await db.collection('users').add({'phone': phone, 'user': username});

      // Asigna el ID del usuario a la variable "usuarios"
      usuarios = newUser.id;

      return usuarios;
      // El usuario se autenticó con éxito
      // Puedes acceder a `userCredential.user` para obtener información del usuario
    } catch (e) {
      // Ocurrió un error durante la autenticación
      print(e.toString());
      return null;
    }
  }

  @override
  Future<String?> existUser(String phoneNumber) async {
    CollectionReference collectionReferenceUserExist = db.collection('users');
    Query query = collectionReferenceUserExist.where('phone', isEqualTo: phoneNumber);

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      String? idUser = querySnapshot.docs[0].id;
      return idUser;
    } else {
      return null;
    }
  }

}
