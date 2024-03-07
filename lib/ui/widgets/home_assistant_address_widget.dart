import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_state.dart';
class HomeAssistantAddressWidget extends StatelessWidget {
  final String homeAssistantAddress;

  const HomeAssistantAddressWidget({super.key, required this.homeAssistantAddress});

  @override
  Widget build(BuildContext context) {
    late TextEditingController textEditingController;
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Home Assistant Address',
            ),
          ],
        ),
        BlocBuilder<HomeAssistantAddressBloc, HomeAssistantAddressState>(
          builder: (context, state) {
            if (state is HomeAssistantAddressReadOnly) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: homeAssistantAddress),
                      readOnly: true,
                      autofocus: false,
                      canRequestFocus: false,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: 'Enter Home Assistant Address',
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
                            context.read<HomeAssistantAddressBloc>().add(
                              EditHomeAssistantAddress(homeAssistantAddress),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is HomeAssistantAddressEditing) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController = TextEditingController(text: state.homeAssistantAddress),
                      readOnly: false,
                      autofocus: true,
                      canRequestFocus: true,
                      decoration: InputDecoration(
                        labelText: null,
                        hintText: 'Enter Home Assistant Address',
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
                            context.read<HomeAssistantAddressBloc>().add(
                              SaveHomeAssistantAddress(textEditingController.text),
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
