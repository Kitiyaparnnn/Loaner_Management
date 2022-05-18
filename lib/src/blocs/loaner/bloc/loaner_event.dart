part of 'loaner_bloc.dart';

abstract class LoanerEvent extends Equatable {
  const LoanerEvent();

  @override
  List<Object?> get props => [];
}

class LoanerLoading extends LoanerEvent {}

class LoanerCreate extends LoanerEvent {
  final LoanerDataModel loaner;
  final bool isEdit;

  LoanerCreate({required this.loaner, required this.isEdit});

  @override
  List<Object?> get props => [loaner, isEdit];
}

class LoanerGetAll extends LoanerEvent {}

class LoanerSearchType extends LoanerEvent {
  final String textSearch;

  LoanerSearchType({required this.textSearch});

  @override
  List<Object?> get props => [textSearch];
}

class LoanerGetSearchType extends LoanerEvent {
  final String textSearch;

  LoanerGetSearchType({required this.textSearch});

  @override
  List<Object?> get props => [textSearch];
}

class LoanerGetType extends LoanerEvent {}

class LoanerGetDetail extends LoanerEvent {
  final String id;

  LoanerGetDetail({required this.id});


  @override
  List<Object?> get props => [id];
}
