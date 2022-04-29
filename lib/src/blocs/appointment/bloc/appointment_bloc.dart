import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/AppointmentService.dart';
import 'package:loaner/src/utils/Constants.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentDataModel appointment = AppointmentDataModel(loaners: []);
  final _appointmentService = AppointmentService();

  AppointmentBloc() : super(AppointmentStateLoading()) {
    on<AppointmentGetDetail>(_mapAppointmentGetDetailToState);
    on<AppointmentButtonOnPress>(_mapAppointmentButtonOnPressToState);
    on<AppointmentButtonOnPress2>(_mapAppointmentButtonOnPress2ToState);
    on<AppointmentAddLoaner>(_mapAppointmentAddLoanerToState);
    on<AppointmentCountLoaner>(_mapAppointmentCountLoanerToState);
    on<AppointmentGetLoaner>(_mapAppointmentGetLoanerToState);
    on<AppointmentMinusLoaner>(_mapAppointmentMinusLoanerToState);
    on<AppointmentPlusLoaner>(_mapAppointmentPlusLoanerToState);
  }

  _mapAppointmentGetDetailToState(
      AppointmentGetDetail event, Emitter emit) async {
    emit(AppointmentStateLoading());

    final _result =
        await _appointmentService.getAppointmentDetail(appNo: event.appNo);
    emit(AppointmentStateGetDetail(data: _result));
  }

  _mapAppointmentButtonOnPressToState(
      AppointmentButtonOnPress event, Emitter emit) async {
    appointment = event.appointment;

    if (appointment.loaners!.length != 0) {
      // final _result =
      //     await _appointmentService.createAppointment(app: appointment);

      // emit(AppointmentStateButtonOnPressed(result: _result, isLoading: false));

      // add(AppointmentGetDetail(appNo: _result.appNo!));
      logger.d(appointment.toJson());
    }

    appointment.loaners = [];
  }

  _mapAppointmentButtonOnPress2ToState(
      AppointmentButtonOnPress2 event, Emitter emit) async {
    // final _result =
    //     await _appointmentService.createAppointment(app: appointment);

    // emit(AppointmentStateButtonOnPressed(result: _result, isLoading: false));

    // add(AppointmentGetDetail(appNo: _result.appNo!));

    logger.d(appointment.toJson());
    appointment.loaners = [];
  }

  _mapAppointmentAddLoanerToState(
      AppointmentAddLoaner event, Emitter emit) async {
    if (appointment.loaners!.length == 0 ||
        !appointment.loaners!.contains(event.loaner)) {
      appointment.loaners!.add(event.loaner);
    } else {
      LoanerModel loaner = appointment.loaners!
          .firstWhere((element) => element.name == event.loaner.name);
      if (loaner.detail != event.loaner.detail) {
        appointment.loaners!.add(event.loaner);
      } else {
        loaner.rent = event.loaner.rent! + loaner.rent!;
      }

      logger.d(loaner.toJson());
    }
    logger.d(appointment.toJson());
  }

  _mapAppointmentCountLoanerToState(
      AppointmentCountLoaner event, Emitter emit) {
    logger.d("loanerCount : ${appointment.loaners!.length}");
    emit(AppointmentStateCountLoaner(loanerCount: appointment.loaners!.length));
  }

  _mapAppointmentGetLoanerToState(AppointmentGetLoaner event, Emitter emit) {
    emit(AppointmentStateGetLoaner(loaners: appointment.loaners!));
  }

  _mapAppointmentMinusLoanerToState(
      AppointmentMinusLoaner event, Emitter emit) {
    emit(AppointmentStateLoading());
    appointment.loaners![event.index].rent =
        appointment.loaners![event.index].rent! - 1;
    if (appointment.loaners![event.index].rent == 0) {
      appointment.loaners!.removeAt(event.index);
    }
    logger.d(appointment.loaners![event.index].toJson());

    add(AppointmentGetLoaner());
  }

  _mapAppointmentPlusLoanerToState(AppointmentPlusLoaner event, Emitter emit) {
    emit(AppointmentStateLoading());
    appointment.loaners![event.index].rent =
        appointment.loaners![event.index].rent! + 1;

    logger.d(appointment.loaners![event.index].toJson());

    add(AppointmentGetLoaner());
  }
}
