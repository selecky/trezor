import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';

class MockCredRepo extends Mock implements CredRepo {}

main() {

  late MockCredRepo mockCredRepo;
  late CredCubit credCubit;
  late Credential testCred;
  late Credential testCred2;

  setUp((){
    mockCredRepo = MockCredRepo();
    credCubit = CredCubit(repo: mockCredRepo);
    testCred = Credential(id: 'id', title: 'title', username: 'username', password: 'password');
    testCred2 = Credential(id: 'id', title: 'title2', username: 'username2', password: 'password2');
  });

  group('CredCubit tests', (){

    blocTest<CredCubit, CredState>(
      'test init()',
      build: () {
        when(() => mockCredRepo.fetchCredentials()).thenReturn([]);
        return credCubit;
      },
      act: (bloc) {
        bloc.init();
      },
      expect: () => <CredState>[CredStateLoading(), const CredStateSuccess(credList: [])],
    );

    blocTest<CredCubit, CredState>(
      'test addCredential()',
      build: () {

        return credCubit;
      },
      act: (bloc) {
        bloc.addCredential(testCred);
      },
      expect: () => <CredState>[CredStateLoading(), CredStateSuccess(credList: [testCred])],
    );

    blocTest<CredCubit, CredState>(
      'test editCredential()',
      build: () => credCubit,
      act: (bloc) {
        bloc..addCredential(testCred)..editCredential(testCred2);
      },
      expect: () => <CredState>[
        CredStateLoading(), CredStateSuccess(credList: [testCred]),
        CredStateLoading(), CredStateSuccess(credList: [testCred2]),
      ],
    );

    blocTest<CredCubit, CredState>(
      'test deleteCredential()',
      build: () => credCubit,
      act: (bloc) {
        bloc..addCredential(testCred)..deleteCredential(testCred.id);
      },
      expect: () => <CredState>[
        CredStateLoading(), CredStateSuccess(credList: [testCred]),
        CredStateLoading(), const CredStateSuccess(credList: []),
      ],
    );

  });

}