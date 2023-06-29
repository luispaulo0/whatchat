import 'package:cloud_firestore/cloud_firestore.dart';

Future<List> getContactosPB() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    List contactosM = [];

    CollectionReference collectionReferenceHomeworks =
        db.collection('contactos_prueba');
    QuerySnapshot queryHomeworks = await collectionReferenceHomeworks.get();

    for (var element in queryHomeworks.docs) {
      final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      final contac = {
        'phone': data['phone'],
        'apodo': data['apodo'],
      };

      contactosM.add(contac);
    }

    return contactosM;
  } catch (error) {
    print('Este es el maldito error $error');
    return [];
  }
}
