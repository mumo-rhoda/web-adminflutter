

import 'package:bloc/bloc.dart';
import 'package:flutter_web_dashboard/bloc/sortingEvents.dart';

class SortingBloc extends Bloc<SortingEvent, String>{
  @override
  // TODO: implement initialState
  String get initialState => "All";

  @override
  Stream<String> mapEventToState(SortingEvent event) async*{



    switch (event){
      case SortingEvent.SortAll: yield "All";
      break;
      case SortingEvent.SortToday: yield "Today";
      break;
      case SortingEvent.SortThisMonth: yield "This Month";
      break;
      case SortingEvent.SortThisYear: yield "This Year";
      break;


    }
  }

  @override
  void onTransition(Transition<SortingEvent, String> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }





}