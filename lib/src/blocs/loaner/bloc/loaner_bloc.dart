import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/DropdownModel.dart';
import 'package:loaner/src/models/loaner/LoanerDataModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/LoanerService.dart';

part 'loaner_event.dart';
part 'loaner_state.dart';

class LoanerBloc extends Bloc<LoanerEvent, LoanerState> {
  final _loanerService = LoanerService();
  LoanerBloc() : super(LoanerStateLoading()) {
    on<LoanerCreate>(_mapLoanerCreateToState);
    on<LoanerGetAll>(_mapLoanerGetAllToState);
    on<LoanerGetSearchType>(_maploanerGetSearchTypeToState);
    on<LoanerSearchType>(_maploanerSearchTypeToState);
    on<LoanerGetType>(_mapLoanerGetTypeToState);
  }

  _mapLoanerCreateToState(LoanerCreate event, Emitter emit) async {
    final _result = await _loanerService.createLoaner(loaner: event.loaner);

    logger.d(event.loaner.toJson());

    add(LoanerGetAll());
  }

  _mapLoanerGetAllToState(LoanerGetAll event, Emitter<LoanerState> emit) async {
    emit(LoanerStateLoading());
    final _result = await _loanerService.getAllLoaners();

    emit(LoanerStateGetAll(data: _result));
  }

  _maploanerGetSearchTypeToState(
      LoanerGetSearchType event, Emitter emit) async {
    emit(LoanerStateLoading());
    final _result =
        await _loanerService.getLoanerBySearch(textSearch: event.textSearch);

    emit(LoanerStateGetAll(data: _result));
  }

  _maploanerSearchTypeToState(LoanerSearchType event, Emitter emit) {
    emit(LoanerStateSearchTpye(textSearch: event.textSearch));
    add(LoanerGetSearchType(textSearch: event.textSearch));
  }

  _mapLoanerGetTypeToState(LoanerGetType event, Emitter emit) async {
    emit(LoanerStateLoading());

    final List<DropdownModel> _result = await _loanerService.getLoanerType();

    emit(LoanerStateGetType(data: _result));
  }
}
