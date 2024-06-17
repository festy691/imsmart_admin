part of 'master_bloc.dart';

abstract class MasterState extends Equatable {
  const MasterState();
}

class MasterInitial extends MasterState {
  @override
  List<Object> get props => [];
}
