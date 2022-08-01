import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';

part 'cred_state.dart';

class CredCubit extends Cubit<CredState> {

  final CredRepo repo;
  late final Box<dynamic> _box;
  List<Credential>? _credList;


  @override
  Future<void> close() async{
    await _box.close();
    super.close();
  }

  CredCubit({required this.repo}) : super(CredStateInitial());

  void init () async{
    emit(CredStateLoading());
    _box = await Hive.openBox('credentials');
    _credList = repo.fetchCredentials();
    emit(CredStateInitial());
  }

  // void decrement({required int removeValue}) {
  //   _value -= removeValue;
  //   emit(CounterStateData(newValue: _value));
  // }

}
