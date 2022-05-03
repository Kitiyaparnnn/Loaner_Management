part of 'loaner_bloc.dart';

abstract class LoanerEvent extends Equatable {
  const LoanerEvent();

  @override
  List<Object?> get props => [];
}

class LoanerLoading extends LoanerEvent {}

class LoanerCreate extends LoanerEvent {
  final LoanerDataModel loaner;

  LoanerCreate({required this.loaner});


    @override
  List<Object?> get props => [loaner];
}

class LoanerGetAll extends LoanerEvent {
  
}

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