part of 'cred_cubit.dart';

abstract class CredState {
  const CredState();
}

class CredStateInitial extends CredState {
}

class CredStateLoading extends CredState {
}

class CredStateSuccess extends CredState {
  List<Credential> credList;
  CredStateSuccess ({required this.credList});
}

class CredStateError extends CredState {
}