part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

class AppointmentStateLoading extends AppointmentState {}

class AppointmentStateGetDetail extends AppointmentState {
  final AppointmentDataModel data;
  final EmployeeModel employee;
  AppointmentStateGetDetail({required this.data, required this.employee});

  @override
  List<Object?> get props => [data,employee];
}

class AppointmentStateButtonOnPressed extends AppointmentState {
  final AppointmentDataModel result;
  final bool isLoading;

  AppointmentStateButtonOnPressed(
      {required this.result, required this.isLoading});

  @override
  List<Object?> get props => [result, isLoading];
}

class AppointmentStateCountLoaner extends AppointmentState {
  final int loanerCount;

  AppointmentStateCountLoaner({required this.loanerCount});

  @override
  List<Object?> get props => [loanerCount];
}

class AppointmentStateGetLoaner extends AppointmentState {
  final List<LoanerModel> loaners;
  final String status;

  AppointmentStateGetLoaner({required this.loaners, required this.status});

  @override
  List<Object?> get props => [loaners, status];
}

class AppointmentStateGetAll extends AppointmentState {
  final List<AppointmentDataModel> data;

  AppointmentStateGetAll({required this.data});

  @override
  List<Object?> get props => [data];
}
