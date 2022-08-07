part of 'cred_cubit.dart';

abstract class CredState extends Equatable{
  const CredState();
}

class CredStateInitial extends CredState {
  @override
  List<Object?> get props => [];
}

class CredStateLoading extends CredState {
  @override
  List<Object?> get props => [];
}

class CredStateSuccess extends CredState {
  final List<Credential> credList;
  const CredStateSuccess ({required this.credList});
  @override
  List<Object> get props => [credList];
}