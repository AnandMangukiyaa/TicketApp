part of 'helpers.dart';

class FirestoreCollections {
  //
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection
  static const String _tickets = 'tickets';

  CollectionReference<Map<String, dynamic>> ticketRef =
      _firestore.collection(_tickets);


  DocumentReference<Map<String, dynamic>> ticketDoc(String? id) {
    return ticketRef.doc(id);
  }



  String get tickets => _tickets;
}

class FirestoreFields {
  FirestoreFields._();

  static const String id = 'id';
  static const String problemTitle = 'problemTitle';
  static const String problemDescription = 'problemDescription';
  static const String createdAt = 'createdAt';
  static const String storedImage = 'storedImage';
  static const String location = 'location';
}
