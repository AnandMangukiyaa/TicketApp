import 'dart:async';
import 'dart:io';

import 'package:flutter_ticket/core/helpers/helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ticket/models/models.dart';
import 'package:uuid/uuid.dart';

class TicketRepository {
  final FirestoreCollections collections;
  TicketRepository({required this.collections});




  Future<void> updateTicketField({
    required String? taskLocationId,
    required String fieldName,
    required dynamic value,
  }) {
    return collections.ticketDoc(taskLocationId).update({
      fieldName: value,
    });
  }

  Future<bool> raiseTicket(Ticket ticket, File file) async {
    ticket.id = const Uuid().v4();
    ticket.createdAt = DateTime.now().toIso8601String();
    ticket.storedImage = await uploadTicketAttachment(file);
    return collections
        .ticketDoc(ticket.id)
        .set(ticket.toMap()).then((value) => true).catchError((error)=> false);
  }

  Future<String?> uploadTicketAttachment(File file) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child(collections.tickets)
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    return await reference.putFile(file).then((snapshot) async {
      return await snapshot.ref.getDownloadURL();
    });
  }


  Stream<List<Ticket>> getRaisedTickets() {
    return collections.ticketRef
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Ticket.fromMap(e.data())).toList();
    });
  }
}


