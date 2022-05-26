part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class AppointmentLoading extends AppointmentEvent {}

class AppointmentGetDetail extends AppointmentEvent {
  final String appointId;

  AppointmentGetDetail({required this.appointId});

  @override
  List<Object> get props => [appointId];

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

class AppointmentButtonOnSave extends AppointmentEvent {
  final bool isEdit;

  AppointmentButtonOnSave({required this.isEdit});

  @override
  List<Object> get props => [isEdit];
}

class AppointmentChangeStatus extends AppointmentEvent {
  final String appId;
  final String status;

  AppointmentChangeStatus({required this.appId, required this.status});

  @override
  List<Object> get props => [appId, status];
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
  final String limit;

  AppointmentGetByStatus({required this.status,required this.limit});

  @override
  List<Object> get props => [status,limit];
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

class AppointmentSetAppoint extends AppointmentEvent {
  final AppointmentDataModel app;
  AppointmentSetAppoint({required this.app});

  @override
  List<Object> get props => [app];
}

class AppointmentGetEachDetail extends AppointmentEvent {
  final String appId;

  AppointmentGetEachDetail({required this.appId});

  @override
  List<Object> get props => [appId];
}
