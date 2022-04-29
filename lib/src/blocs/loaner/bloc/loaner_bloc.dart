import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loaner_event.dart';
part 'loaner_state.dart';

class LoanerBloc extends Bloc<LoanerEvent, LoanerState> {
  LoanerBloc() : super(LoanerInitial()) {
    on<LoanerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
