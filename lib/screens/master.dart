import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/myWidgets/my_credential_card.dart';
import 'package:trezor/screens/add_edit_cred.dart';
import 'package:trezor/screens/detail.dart';
import 'package:trezor/strings/strings.dart';

class Master extends StatelessWidget {
  const Master({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditCred()));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.appTitle),
      ),
      body: BlocBuilder<CredCubit, CredState>(
        builder: (context, state) {
          if (state is CredStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CredStateSuccess) {
            if (state.credList.isEmpty) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.emptyCredListText,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(Strings.addCredentialsInfo),
                ],
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: state.credList.length,
                    itemBuilder: (_, index) {
                      return MyCredentialCard(
                          credential: state.credList[index],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          credential: state.credList[index],
                                        )));
                          });
                    }),
              );
            }
          } else {
            return const Center(child: Text('Error-master-CredCubit'));
          }
        },
      ),
    );
  }
}
