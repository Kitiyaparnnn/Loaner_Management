import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/loaner/LoanerDataModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';

part 'loaner_event.dart';
part 'loaner_state.dart';

class LoanerBloc extends Bloc<LoanerEvent, LoanerState> {
  LoanerBloc() : super(LoanerStateLoading()) {
    on<LoanerCreate>(_mapLoanerCreateToState);
    on<LoanerGetAll>(_mapLoanerGetAllToState);
    on<LoanerGetSearchType>(_maploanerGetSearchTypeToState);
    on<LoanerSearchType>(_maploanerSearchTypeToState);
  }

  _mapLoanerCreateToState(LoanerCreate event, Emitter emit) {
    // final _result =
    //     await _loanerService.createLoaner(app: event.loaner);
    logger.d(event.loaner.toJson());

    add(LoanerGetAll());
  }

  _mapLoanerGetAllToState(LoanerGetAll event, Emitter<LoanerState> emit) {
    emit(LoanerStateLoading());

    // final _result =
    //     await _loanerService.getLoaners();
    final List<LoanerModel> _result = [];

    emit(LoanerStateGetAll(data: _result));
  }

  _maploanerGetSearchTypeToState(LoanerGetSearchType event, Emitter emit) {
    emit(LoanerStateLoading());

    // final _result =
    //     await _loanerService.getLoanerBySearch(textSearch : event.textSearch);
    final List<LoanerModel> _result = [];
    logger.d(event.textSearch);

    emit(LoanerStateGetAll(data: _result));
  }

    _maploanerSearchTypeToState(LoanerSearchType event, Emitter emit) {
    emit(LoanerStateSearchTpye(textSearch:event.textSearch));
  }
}
