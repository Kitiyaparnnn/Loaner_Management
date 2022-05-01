import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/EmployeeService.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final _employeeService = EmployeeService();

  EmployeeBloc() : super(EmployeeStateLoading()) {
    on<EmployeeCreate>(_mapEmployeeCreateToState);
    on<EmployeeGetAll>(_mapEmployeeGatAllToState);
    on<EmployeeSearch>(_mapEmployeeSearchToSate);
  }

  _mapEmployeeCreateToState(EmployeeCreate event, Emitter emit) {
    // final _result =
    //     await _employeeService.createEmployee(employee: event.employee);
    logger.d(event.employee.toJson());
  }

  _mapEmployeeGatAllToState(EmployeeGetAll event, Emitter emit) {
    List<EmployeeModel> _result = [];
    // final _result =
    //     await _employeeService.getAllEmployees();

    emit(EmployeeStateGetAll(data: _result));
  }

  _mapEmployeeSearchToSate(EmployeeSearch event, Emitter emit) {
    List<EmployeeModel> _result = [];
        // final _result =
    //     await _employeeService.getEmployeeBySearch(textSearch : event.textSearch);
    logger.d(event.textSearch);

    emit(EmployeeStateGetAll(data: _result));
  }
}
