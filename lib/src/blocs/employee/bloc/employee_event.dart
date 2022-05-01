part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class EmployeeCreate extends EmployeeEvent {
  final EmployeeDataModel employee;

  EmployeeCreate({required this.employee});

    @override
  List<Object?> get props => [employee];

}

class EmployeeGetAll extends EmployeeEvent {

}

class EmployeeSearch extends EmployeeEvent {
  final String textSearch;

  EmployeeSearch({required this.textSearch});

    @override
  List<Object?> get props => [textSearch];

}