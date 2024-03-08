import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_event.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_state.dart';

class AccessTokenWidget extends StatelessWidget {
  const AccessTokenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    late TextEditingController textEditingController;
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Access Token',
            ),
          ],
        ),
        BlocBuilder<AccessTokenBloc, AccessTokenState>(
          builder: (context, state) {
            if (state is AccessTokenLoaded) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          TextEditingController(text: state.accessToken),
                      readOnly: true,
                      autofocus: false,
                      canRequestFocus: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: 'Enter Access Token',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            context.read<AccessTokenBloc>().add(
                                  EditAccessToken(state.accessToken),
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is AccessTokenEditing) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController =
                          TextEditingController(text: state.accessToken),
                      readOnly: false,
                      autofocus: true,
                      canRequestFocus: true,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: 'Enter Access Token',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.done),
                          onPressed: () {
                            context.read<AccessTokenBloc>().add(
                                  SaveAccessToken(textEditingController.text),
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
