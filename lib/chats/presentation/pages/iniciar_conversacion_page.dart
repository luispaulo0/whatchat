import 'package:flutter/material.dart';
import 'package:whatchat/chats/presentation/usecases.dart';

class IniciarConversacion extends StatefulWidget {
  final UseCases useCases;
  IniciarConversacion({required this.useCases});
  @override
  State<IniciarConversacion> createState() => _IniciarConversacionState();
}

class _IniciarConversacionState extends State<IniciarConversacion> {
  String? idReceptor;
  String? uidMen;
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

  Future<String> getIdMensajes(String idReceptor) async {
    String? uidMensajes;
    uidMensajes = await widget.useCases.searchChat?.execute(idReceptor);
    return uidMensajes!;
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ))),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 35, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Contactos',
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.7, color: Colors.grey),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
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
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  snapshot.data?[index]
                                                      ['apodo'],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                onTap: (() async {
                                  idReceptor =
                                      snapshot.data?[index]['uidContacto'];
                                  uidMen = await getIdMensajes(idReceptor!);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamed(context, '/ChatPage',
                                      arguments: {
                                        'apodo': snapshot.data?[index]['apodo'],
                                        'idReceptor': snapshot.data?[index]
                                            ['uidContacto'],
                                        'idMensajes': uidMen
                                      });
                                  setState(() {});
                                }),
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
