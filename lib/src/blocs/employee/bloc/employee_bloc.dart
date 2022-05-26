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
    on<EmployeeManage>(_mapEmployeeManageToState);
    on<EmployeeGetAll>(_mapEmployeeGatAllToState);
    on<EmployeeSearchType>(_mapEmployeeSearchToSate);
    on<EmployeeGetSearchType>(_mapEmployeeGetSearchTypeToState);
    on<EmployeeGetDetail>(_mapEmployeeGetDetailToState);
  }
  _mapEmployeeGetDetailToState(EmployeeGetDetail event, Emitter emit) async {
    emit(EmployeeStateLoading());

    final _result = await _employeeService.getEmployeeDetail(empId: event.id);

    emit(EmployeeStateGetDetail(data: _result));
  }

  _mapEmployeeManageToState(EmployeeManage event, Emitter emit) async {
    emit(EmployeeStateLoading());
    event.employee.type = "2";
    logger.d(event.employee.toJson());
    final _result =
        await _employeeService.manageEmployee(employee: event.employee);
  }

  _mapEmployeeGatAllToState(EmployeeGetAll event, Emitter emit) async {
    emit(EmployeeStateLoading());

    final _result = await _employeeService.getAllEmployees();

    emit(EmployeeStateGetAll(data: _result));
  }

  _mapEmployeeSearchToSate(EmployeeSearchType event, Emitter emit) {
    emit(EmployeeStateSearchType(textSearch: event.textSearch));
    add(EmployeeGetSearchType(textSearch: event.textSearch));
  }

  _mapEmployeeGetSearchTypeToState(
      EmployeeGetSearchType event, Emitter emit) async {
    emit(EmployeeStateLoading());
    final _result = await _employeeService.getEmployeeBySearch(
        textSearch: event.textSearch);

    emit(EmployeeStateGetAll(data: _result));
  }
}
