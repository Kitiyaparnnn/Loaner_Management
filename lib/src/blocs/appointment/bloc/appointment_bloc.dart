import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/appointment/AppointmentSearchModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/AppointmentService.dart';
import 'package:loaner/src/services/EmployeeService.dart';
import 'package:loaner/src/utils/Constants.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentDataModel appointment =
      AppointmentDataModel(status: "0", loaners: []);
  EmployeeModel employee = EmployeeModel();
  final _appointmentService = AppointmentService();
  final _employeeService = EmployeeService();

  AppointmentBloc() : super(AppointmentStateLoading()) {
    on<AppointmentClear>(_mapAppointmentClearToState);
    on<AppointmentGetEmpId>(_mapAppointmentGetEmpIdToState);
    on<AppointmentGetDetail>(_mapAppointmentGetDetailToState);
    on<AppointmentButtonOnPress>(_mapAppointmentButtonOnPressToState);
    on<AppointmentButtonOnPress2>(_mapAppointmentButtonOnPress2ToState);
    on<AppointmentAddLoaner>(_mapAppointmentAddLoanerToState);
    on<AppointmentCountLoaner>(_mapAppointmentCountLoanerToState);
    on<AppointmentGetLoaner>(_mapAppointmentGetLoanerToState);
    on<AppointmentMinusLoaner>(_mapAppointmentMinusLoanerToState);
    on<AppointmentPlusLoaner>(_mapAppointmentPlusLoanerToState);
    on<AppointmentGetAll>(_mapAppointmentGetAllToState);
    on<AppointmentGetBySearch>(_mapAppointmentGetBySearchToState);
    on<AppointmentGetByStatus>(_mapAppointmentGetByStatusToState);
    on<AppointmentGetToEdit>(_mapAppointmentGetToEditToState);
  }

  _mapAppointmentClearToState(AppointmentClear event, Emitter emit) {
    // emit(AppointmentStateLoading());
    appointment.loaners!.clear();
  }

  _mapAppointmentGetEmpIdToState(AppointmentGetEmpId event, Emitter emit) {
    //  final _result =
    // await _employeeService.getEmployeeDetail(status: appointment.empid)
    employee = EmployeeModel(
        empId: "1",
        username: "นาย ข",
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        isTrained: false);

    add(AppointmentGetDetail(app: event.app));
  }

  _mapAppointmentGetDetailToState(
      AppointmentGetDetail event, Emitter emit) async {
    emit(AppointmentStateLoading());
    // final _result =
    //     await _appointmentService.getAppointmentDetail(appNo: event.appNo);

    appointment = event.app;

    emit(AppointmentStateGetDetail(data: event.app, employee: employee));
    // emit(AppointmentStateLoading());
  }

//fill appointment form
  _mapAppointmentButtonOnPressToState(
      AppointmentButtonOnPress event, Emitter emit) async {
    appointment = event.appointment;
    employee = event.employee;

    if (appointment.loaners!.length != 0) {
      // final _result =
      //     await _appointmentService.createAppointment(app: appointment);

      // emit(AppointmentStateButtonOnPressed(result: _result, isLoading: false));

      // add(AppointmentGetDetail(appNo: _result.appNo!));
      if (!event.isEdit) {
        appointment.loaners = [];
      } else {
        emit(AppointmentStateLoading());
        logger.d(employee.toJson());
        // add(AppointmentGetDetail(app: appointment));
        //update employee data
      }
    } else {
      logger.w("loaner is empty");
    }

    logger.d(appointment.toJson());
  }

  //loaner_sum_page
  _mapAppointmentButtonOnPress2ToState(
      AppointmentButtonOnPress2 event, Emitter emit) async {
    if (!event.isEdit) {
      //update appointment loaner data to database
      appointment.loaners = [];
    }

    //create new appointment to database
    // final _result =
    //     await _appointmentService.createAppointment(app: appointment);

    logger.d(appointment.toJson());
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
    emit(AppointmentStateCountLoaner(
        loanerCount:
            appointment.loaners == null ? 0 : appointment.loaners!.length));
  }

  _mapAppointmentGetLoanerToState(AppointmentGetLoaner event, Emitter emit) {
    emit(AppointmentStateGetLoaner(
        loaners: appointment.loaners!, status: appointment.status!));
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

  _mapAppointmentGetAllToState(AppointmentGetAll event, Emitter emit) async {
    final List<AppointmentDataModel> _result = [];

    //  final _result =
    //     await _appointmentService.getAppointments();
    emit(AppointmentStateGetAll(data: _result));
  }

  _mapAppointmentGetBySearchToState(
      AppointmentGetBySearch event, Emitter emit) async {
    emit(AppointmentStateLoading());
    logger.d(event.search.toJson());
    final List<AppointmentDataModel> _result = [];
    //  final _result = await _appointmentService.getAppointmentsBySearch(status: event.search.status,hospital: event.search.hospital,date: event.search.date);

    emit(AppointmentStateGetAll(data: _result));
  }

  _mapAppointmentGetByStatusToState(
      AppointmentGetByStatus event, Emitter emit) async {
    emit(AppointmentStateLoading());
    final List<AppointmentDataModel> _result = [];

    //  final _result =
    // await _appointmentService.getAppointmentsByStatus(status: event.status);

    emit(AppointmentStateGetAll(data: _result));
  }

  _mapAppointmentGetToEditToState(AppointmentGetToEdit event, Emitter emit) {
    emit(AppointmentStateLoading());

    emit(AppointmentStateGetDetail(
      data: appointment,
      employee: employee,
    ));
  }
}
