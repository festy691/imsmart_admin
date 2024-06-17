import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'master_event.dart';
part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterBloc() : super(MasterInitial());

  @override
  Stream<MasterState> mapEventToState(
    MasterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
