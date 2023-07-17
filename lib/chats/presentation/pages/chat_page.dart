import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatchat/chats/domain/entities/mensaje.dart';
import 'package:whatchat/chats/presentation/pages/maps.dart';
import 'package:whatchat/chats/presentation/usecases.dart';
import 'package:whatchat/chats/presentation/widgets/header_chat.dart';
import 'package:whatchat/chats/presentation/widgets/message_audio.dart';
import 'package:whatchat/chats/presentation/widgets/message_img.dart';
import 'package:whatchat/chats/presentation/widgets/message_pdf.dart';
import 'package:whatchat/chats/presentation/widgets/message_text.dart';
import 'package:whatchat/chats/presentation/widgets/message_ubication.dart';
import 'package:whatchat/chats/presentation/widgets/message_video.dart';

class ChatPage extends StatefulWidget {
  final UseCases useCases;

  ChatPage({required this.useCases});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController mensajeController = TextEditingController(text: '');
  File? _getImg;
  File? _getVideo;
  File? _getAudio;
  File? _getPdf;
  String? miuserid;
  File? audio;

  void initSate() {
    super.initState();
    setState(() {});
  }

  Future<void> _getAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      _getAudio = File(result.files.single.path!);
    }
  }

  Future<void> _getImgFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      _getImg = File(result.files.single.path!);
    }
  }

  Future<void> _getVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      _getVideo = File(result.files.single.path!);
    }
  }

  Future<void> _getPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      _getPdf = File(result.files.single.path!);
    }
  }

  Future<void> enviarMensaje(String uidChat, String emisorId, String receptorId,
      String contenido) async {
    final mensaje = Mensaje(
      text: contenido,
      imagenFile: _getImg,
      videoFile: _getVideo,
      audioFile: _getAudio,
      pdfFile: _getPdf,
    );

    if (_getAudio != null ||
        _getImg != null ||
        _getVideo != null ||
        _getPdf != null) {
      print('enviar mensaje tipo media');
      await widget.useCases.enviarMensajeUseCase
          ?.execute(uidChat, emisorId, receptorId, mensaje);
    } else {
      print('Enviar mensaje tipo text');
      await widget.useCases.enviarMensajeText
          ?.execute(uidChat, emisorId, receptorId, mensaje);
    }

    setState(() {
      _getImg = null;
      _getVideo = null;
      _getAudio = null;
    });
  }

  Future<List?> getMensajes(String? uidMensajes) async {
    // print('este es el argumento uidMensaje  ' + uidMensajes!);
    List? mensajes = [];
    mensajes = await widget.useCases.obtenerMensajes?.execute(uidMensajes!);
    return mensajes;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String uidM = arguments['idMensajes'];
    String idReceptor = arguments['idReceptor'];
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
                  padding: const EdgeInsets.only(top: 40, left: 20),
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
                HeaderChat(apodo: arguments['apodo'])
              ],
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: getMensajes(uidM),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: 380,
                        height: 600,
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              miuserid = snapshot.data?[index]['miId'];
                              final emisorId =
                                  snapshot.data?[index]['idEmisor'];

                              final String? urlimg =
                                  snapshot.data?[index]['urlimg'];
                              final String? text =
                                  snapshot.data?[index]['contenido'];
                              final String? urlvideo =
                                  snapshot.data?[index]['videoUrl'];
                              final String? audioUrl =
                                  snapshot.data?[index]['audioUrl'];
                              final String? pdfUrl =
                                  snapshot.data?[index]['pdfUrl'];
                              final GeoPoint? ubication =
                                  snapshot.data?[index]['location'];
                              if (miuserid == emisorId) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      color: const Color(0xFF28B3B9),
                                      width: 200,
                                      child: Column(
                                        children: [
                                          if (text != null)
                                            MessageText(
                                              text: text,
                                              emisor: true,
                                            ),
                                          if (urlimg != null)
                                            MessageImg(urlimg: urlimg),
                                          if (urlvideo != null)
                                            MessageVideo(urlvideo: urlvideo),
                                          if (audioUrl != null)
                                            MessageAudio(audioUrl: audioUrl),
                                          if (pdfUrl != null)
                                            MessagePdf(pdfUrl: pdfUrl),
                                          if (ubication != null)
                                            MessageUbication(
                                                latitude: ubication.latitude,
                                                longitude: ubication.longitude),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                'yo',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      color: Colors.white,
                                      width: 200,
                                      child: Column(
                                        children: [
                                          if (text != null)
                                            MessageText(
                                              text: text,
                                              emisor: false,
                                            ),
                                          if (urlimg != null)
                                            MessageImg(urlimg: urlimg),
                                          if (urlvideo != null)
                                            MessageVideo(urlvideo: urlvideo),
                                          if (audioUrl != null)
                                            MessageAudio(audioUrl: audioUrl),
                                          if (pdfUrl != null)
                                            MessagePdf(pdfUrl: pdfUrl),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Manda un mensaje',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: 280,
                      child: TextFormField(
                        controller: mensajeController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'Escribe tu mensaje',
                            hintStyle: TextStyle(color: Colors.black)),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: () {
                        final RenderBox button =
                            context.findRenderObject() as RenderBox;
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;
                        final RelativeRect position = RelativeRect.fromRect(
                          Rect.fromPoints(
                            button.localToGlobal(const Offset(10, 500),
                                ancestor: overlay),
                            button.localToGlobal(
                                button.size
                                    .bottomRight(Offset(0, button.size.width)),
                                ancestor: overlay),
                          ),
                          Offset.zero & overlay.size,
                        );

                        final themeData = Theme.of(context);
                        final popupMenuThemeData = themeData.popupMenuTheme;

                        showMenu<String>(
                          context: context,
                          position: position,
                          elevation: popupMenuThemeData.elevation,
                          shape: popupMenuThemeData.shape,
                          color: popupMenuThemeData.color,
                          items: [
                            const PopupMenuItem<String>(
                              value: 'imagen',
                              child: ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Imagen'),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'video',
                              child: ListTile(
                                leading: Icon(Icons.video_library),
                                title: Text('Video'),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'audio',
                              child: ListTile(
                                leading: Icon(Icons.audiotrack),
                                title: Text('Audio'),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'pdf',
                              child: ListTile(
                                leading: Icon(Icons.picture_as_pdf),
                                title: Text('Pdf'),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'ubicacion',
                              child: ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text('Ubicación'),
                              ),
                            ),
                          ],
                        ).then((value) {
                          if (value != null) {
                            if (value == 'imagen') {
                              _getImgFile();
                            }
                            if (value == 'video') {
                              _getVideoFile();
                            }
                            if (value == 'audio') {
                              _getAudioFile();
                            }
                            if (value == 'pdf') {
                              _getPdfFile();
                            }
                            if (value == 'ubicacion') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Maps(
                                    emisorId: miuserid!,
                                    receptorId: idReceptor,
                                    uidM: uidM,
                                    useCases: widget.useCases,
                                  ),
                                ),
                              );
                              setState(() {});
                            }
                            print('Opción seleccionada: $value');
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.attach_file,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          final String contenido = mensajeController.text;
                          enviarMensaje(uidM, miuserid!, idReceptor, contenido);
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 40,
                          color: Color(0xFF0CB5BD),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
