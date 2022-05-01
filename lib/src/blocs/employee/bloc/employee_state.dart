part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeStateLoading extends EmployeeState {}

class EmployeeStateGetAll extends EmployeeState {
  final List<EmployeeModel> data;

  EmployeeStateGetAll({required this.data});

  @override
  List<Object?> get props => [data];
  
}
