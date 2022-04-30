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

class AppointmentButtonOnPress extends AppointmentEvent {
  final AppointmentDataModel appointment;

  AppointmentButtonOnPress({required this.appointment});

  @override
  List<Object> get props => [appointment];
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

  AppointmentGetBySearch(
      {required this.search});

  @override
  List<Object> get props => [search];
}
