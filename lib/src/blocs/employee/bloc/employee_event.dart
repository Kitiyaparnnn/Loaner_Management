part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class EmployeeManage extends EmployeeEvent {
  final EmployeeDataModel employee;

  EmployeeManage({required this.employee});

  @override
  List<Object?> get props => [employee];
}

class EmployeeGetAll extends EmployeeEvent {}

class EmployeeGetSearchType extends EmployeeEvent {
  final String textSearch;

  EmployeeGetSearchType({required this.textSearch});

  @override
  List<Object?> get props => [textSearch];
}

class EmployeeSearchType extends EmployeeEvent {
  final String textSearch;

  EmployeeSearchType({required this.textSearch});

  @override
  List<Object?> get props => [textSearch];
}

class EmployeeGetDetail extends EmployeeEvent {
  final String id;

  EmployeeGetDetail({required this.id});

    @override
  List<Object?> get props => [id];
}
