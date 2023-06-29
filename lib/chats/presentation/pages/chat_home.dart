import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatchat/chats/presentation/pages/chat_page.dart';
import 'package:whatchat/contactos/data/prueba/prueba.dart';

import '../usecases.dart';

class ChatHome extends StatefulWidget {
  final UseCases useCases;
  ChatHome({required this.useCases});

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool newcontacto = false;
  TextEditingController phoneNumber = TextEditingController(text: '');
  TextEditingController apodoUser = TextEditingController(text: '');

  Future<void> guardarContacto() async {
    try {
      print(phoneNumber.text);
      widget.useCases.nuevoContacto?.execute(phoneNumber.text, apodoUser.text);
    } catch (error) {
      print('Este es el error a la hora de guardar un contacto$error');
    }
  }

  Future<List?> getContactos() async {
    List? contactosList = [];
    try {
      contactosList = await widget.useCases.mostrarContacto?.execute();
      print('--------');
      print(contactosList?.length);
      return contactosList;
    } catch (e) {
      print('error a la hora de obtener contactos$e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fondo_chat.png'),
              fit: BoxFit.cover,
              opacity: 20),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 40),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          newcontacto = false;
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                newcontacto ? Colors.transparent : Colors.white,
                            fixedSize: const Size(97, 10)),
                        child: Text(
                          'Contactos',
                          style: TextStyle(
                              color: newcontacto
                                  ? Colors.white
                                  : const Color(0xFF494FD4)),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            newcontacto = true;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: newcontacto
                                  ? Colors.white
                                  : Colors.transparent,
                              fixedSize: const Size(110, 10)),
                          child: Text(
                            'Nv Contacto',
                            style: TextStyle(
                                color: newcontacto
                                    ? const Color(0xFF494FD4)
                                    : Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ],
                )),
            if (newcontacto == true)
              Expanded(
                flex: 10,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30, left: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Agrega un nuevo contacto',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              )),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, left: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ingrese su número de teléfono',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: TextField(
                              controller: phoneNumber,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Número de teléfono',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, left: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ingrese el nombre',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: TextField(
                              controller: apodoUser,
                              decoration: const InputDecoration(
                                hintText: 'Nombre',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                              ),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              onPressed: guardarContacto,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF28B3B9),
                                  fixedSize: const Size(150, 40)),
                              child: const Text(
                                'Agregar',
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Expanded(
                flex: 10,
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )),
                    child: FutureBuilder(
                        future: getContactos(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Title(
                                    color: Colors.black,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 99,
                                              99, 99), // Color del borde
                                          width: 0.5, // Ancho del borde
                                        ),
                                      ),
                                      child: Row(children: [
                                        Container(
                                          width: 100,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              snapshot.data?[index]['apodo'],
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                  onTap: (() async {
                                    await Navigator.pushNamed(
                                      context,
                                      '/ChatPage',
                                    );
                                    setState(() {});
                                  }),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))),
              )
          ],
        ),
      ),
    );
  }
}
