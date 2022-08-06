import 'package:bloc/bloc.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';

part 'cred_state.dart';

class CredCubit extends Cubit<CredState> {
  final CredRepo repo;
  List<Credential>? _credList = [];

  CredCubit({required this.repo}) : super(CredStateInitial());

  void init() async {
    emit(CredStateLoading());
    _credList = repo.fetchCredentials();
    emit(CredStateSuccess(credList: _credList!));
  }

  void addCredential(Credential credential) {
    emit(CredStateLoading());
    repo.addCredential(credential: credential);
    _credList!.add(credential);
    emit(CredStateSuccess(credList: _credList!));
  }

  void editCredential(Credential credential) {
    emit(CredStateLoading());
    repo.editCredential(credential: credential);
    _credList!.map((e) => e.id == credential.id ? credential : e);
    emit(CredStateSuccess(credList: _credList!));
  }
}
