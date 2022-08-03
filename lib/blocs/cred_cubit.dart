import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';

part 'cred_state.dart';

class CredCubit extends Cubit<CredState> {

  final CredRepo repo;
  List<Credential>? _credList;

  CredCubit({required this.repo}) : super(CredStateInitial());

  void init () async{
    emit(CredStateLoading());
    _credList = repo.fetchCredentials();
    emit(CredStateInitial());
  }

  // void decrement({required int removeValue}) {
  //   _value -= removeValue;
  //   emit(CounterStateData(newValue: _value));
  // }

}
