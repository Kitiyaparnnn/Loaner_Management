import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/my_app.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeStateLoading()) {
    on<EmployeeCreate>(_mapEmployeeCreateToState);
  }

  _mapEmployeeCreateToState(EmployeeCreate event, Emitter emit) {
    // final _result =
    //     await _appointmentService.createAppointment(employee: event.employee);
    logger.d(event.employee.toJson());
  }
}
