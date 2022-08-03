import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/myWidgets/my_credential_card.dart';
import 'package:trezor/strings/strings.dart';

class Master extends StatelessWidget {
  const Master({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      body: BlocBuilder<CredCubit, CredState>(
        builder: (context, state) {
          if (state is CredStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CredStateSuccess) {
            if (state.credList?.isEmpty ?? true) {
              return Center(child: Text(Strings.emptyCredListText));
            } else {
              return ListView.builder(
                  itemCount: state.credList?.length,
                  itemBuilder: (_, index) {
                    return MyCredentialCard(credential: state.credList![index]);
                  }
              );
            }
          }

          else {
            return const Center(child: Text('Error-master-CredCubit'));
          }
        },
      ),
    );
  }
}
