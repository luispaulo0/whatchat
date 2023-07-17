import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatchat/users/domain/entities/user.dart';
import 'package:whatchat/users/domain/usescases/registro_usecase.dart';
import 'package:whatchat/users/domain/usescases/verficacion_existencia_user_usecase.dart';

class Signup extends StatefulWidget {
  final RegisterUser registerUser;
  final SmsValidation smsValidation;
  final VerificacionExistenciaUserUserCase verificar;
  Signup(
      {required this.registerUser,
      required this.smsValidation,
      required this.verificar});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController(text: '');
  TextEditingController phoneNumber = TextEditingController(text: '');
  TextEditingController codigo = TextEditingController(text: '');
  List<User>? usuario;

  Future<void> _registro() async {
    String mex = '+52';
    final number = mex + phoneNumber.text;
    final userName = username.text;
    print('--------------------NUMERO------------------' + number);
    final user = User(phone: number, username: userName);

    try {
      await widget.registerUser.execute(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _validar() async {
    final String? nuevoUser;
    String? idUser;
    final sms = codigo.text;
    final phone = phoneNumber.text;
    try {
      nuevoUser = await widget.verificar.execute(phone);
      if (nuevoUser != null) {
        print("Usuario Verificado");
        setState(() {
          Navigator.of(context).pushNamed('/chat');
        });
      } else {
        idUser = await widget.smsValidation.execute(sms);
        setState(() {
          Navigator.of(context)
              .pushNamed('/chat', arguments: {'idUser': idUser});
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF293E4E),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ingresa tu número de teléfono',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 200.0,
                  height: 40.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: phoneNumber,
                    decoration: const InputDecoration(
                        hintText: 'Tu número de teléfono',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ingresa tu nombre de usuario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 200.0, // Establece el ancho deseado del TextField
                  height: 40.0, // Establece la altura deseada del TextField
                  child: TextFormField(
                    controller: username,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: _registro,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28B3B9),
                        fixedSize: const Size(200, 50)),
                    child: const Text(
                      'Enviar código',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ingresa el código de verificación',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 200.0, // Establece el ancho deseado del TextField
                  height: 40.0, // Establece la altura deseada del TextField
                  child: TextFormField(
                    controller: codigo,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: 'Código',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: _validar,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28B3B9),
                        fixedSize: const Size(200, 50)),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
