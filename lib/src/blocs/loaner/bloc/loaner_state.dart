part of 'loaner_bloc.dart';

abstract class LoanerState extends Equatable {
  const LoanerState();

  @override
  List<Object?> get props => [];
}

class LoanerStateLoading extends LoanerState {}

class LoanerStateGetAll extends LoanerState {
  final List<LoanerModel> data;

  LoanerStateGetAll({required this.data});

  @override
  List<Object?> get props => [data];
}

class LoanerStateSearchTpye extends LoanerState {
  final String textSearch;

  LoanerStateSearchTpye({required this.textSearch});

  @override
  List<Object?> get props => [textSearch];
}

class LoanerStateGetType extends LoanerState {
  final List<DropdownModel> data;

  LoanerStateGetType({required this.data});

    @override
  List<Object?> get props => [data];
}
