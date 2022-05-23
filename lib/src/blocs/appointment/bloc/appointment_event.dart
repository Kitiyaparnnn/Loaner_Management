part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class AppointmentLoading extends AppointmentEvent {}

class AppointmentGetDetail extends AppointmentEvent {
  final AppointmentDataModel app;

  AppointmentGetDetail({required this.app});

  @override
  List<Object> get props => [app];

  //database
  // final String appNo;
  // AppointmentGetDetail({required this.appNo});
  // @override
  // List<Object> get props => [appNo];
}

class AppointmentGetEmpId extends AppointmentEvent {
  final AppointmentDataModel app;

  AppointmentGetEmpId({required this.app});

  @override
  List<Object> get props => [app];
}

class AppointmentButtonOnPress extends AppointmentEvent {
  final AppointmentDataModel appointment;
  final bool isEdit;
  final EmployeeModel employee;

  AppointmentButtonOnPress(
      {required this.appointment,
      required this.isEdit,
      required this.employee});

  @override
  List<Object> get props => [appointment, employee];
}

class AppointmentButtonOnPress2 extends AppointmentEvent {
  final bool isEdit;

  AppointmentButtonOnPress2({required this.isEdit});

  @override
  List<Object> get props => [isEdit];
}

class AppointmentAddLoaner extends AppointmentEvent {
  final LoanerModel loaner;

  AppointmentAddLoaner({required this.loaner});

  @override
  List<Object> get props => [loaner];
}

class AppointmentCountLoaner extends AppointmentEvent {}

class AppointmentGetLoaner extends AppointmentEvent {}

class AppointmentMinusLoaner extends AppointmentEvent {
  final int index;

  AppointmentMinusLoaner({required this.index});

  @override
  List<Object> get props => [index];
}

class AppointmentPlusLoaner extends AppointmentEvent {
  final int index;

  AppointmentPlusLoaner({required this.index});

  @override
  List<Object> get props => [index];
}

class AppointmentGetAll extends AppointmentEvent {}

class AppointmentGetBySearch extends AppointmentEvent {
  final AppointmentSearchModel search;

  AppointmentGetBySearch({required this.search});

  @override
  List<Object> get props => [search];
}

class AppointmentGetConfirmStatus extends AppointmentEvent {}

class AppointmentGetByStatus extends AppointmentEvent {
  final String status;

  AppointmentGetByStatus({required this.status});

  @override
  List<Object> get props => [status];
}

class AppointmentGetToEdit extends AppointmentEvent {}

class AppointmentClear extends AppointmentEvent {}

class AppointmentGetGetSupEmpandHos extends AppointmentEvent {
  final String supId;

  AppointmentGetGetSupEmpandHos({required this.supId});

  @override
  List<Object> get props => [supId];
}

class AppointmentGetHospital extends AppointmentEvent {}

class AppointmentGetHosDetail extends AppointmentEvent {
  final String hosId;
  AppointmentGetHosDetail({required this.hosId});

    @override
  List<Object> get props => [hosId];
}
