import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthRepository {
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String verificationId, String smsCode);
}

class FirebasePhoneAuthRepository implements PhoneAuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebasePhoneAuthRepository(this._firebaseAuth);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // El número de teléfono se verificó automáticamente
        // Puedes usar `credential` para autenticar al usuario
      },
      verificationFailed: (FirebaseAuthException e) {
        // Ocurrió un error durante la verificación
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
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
  Future<void> signInWithPhoneNumber(String verificationId, String smsCode) async {
    try {
      // Crea una instancia de PhoneAuthCredential utilizando el `verificationId` y el `smsCode`
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Autentica al usuario con el credential
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      // El usuario se autenticó con éxito
      // Puedes acceder a `userCredential.user` para obtener información del usuario
    } catch (e) {
      // Ocurrió un error durante la autenticación
      print(e.toString());
    }
  }
}
