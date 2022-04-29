part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

class AppointmentStateLoading extends AppointmentState {}

class AppointmentStateGetDetail extends AppointmentState {
  final AppointmentDataModel data;

  AppointmentStateGetDetail({required this.data});

  @override
  List<Object?> get props => [data];
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

  AppointmentStateGetLoaner({required this.loaners});

  @override
  List<Object?> get props => [loaners];
}

class AppointmentStateCreateStatus extends AppointmentState {
  final bool isCompleted;

  AppointmentStateCreateStatus({required this.isCompleted});

  @override
  List<Object> get props => [isCompleted];
}

