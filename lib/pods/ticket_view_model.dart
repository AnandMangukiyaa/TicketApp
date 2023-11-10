import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticket/models/models.dart';
import 'package:flutter_ticket/repositories/task_repository.dart';
import 'package:get_it/get_it.dart';

final ticketViewModelProvider = StateNotifierProvider<TicketViewModel,bool>((ref) => TicketViewModel());


class TicketViewModel extends StateNotifier<bool>{
  TicketViewModel() : super(false);

  TicketRepository repository = GetIt.I<TicketRepository>();


  Future<bool> addTicket(Ticket ticket,File file) async{
    try{
      state = true;
       bool result = await repository.raiseTicket(ticket, file);
       if(!result){
         return false;
       }
      state = false;
      return true;

    } catch (e){
      return false;
    }

  }

  Stream<List<Ticket>> getTickets() {
    return repository.getRaisedTickets();
  }

}