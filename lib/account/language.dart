import 'package:booking/hotel/elevated/hotel_secreen_cubit.dart';
import 'package:booking/hotel/elevated/hotel_secreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../commen/theme/light_color_schema.dart';
import '../l10n/app_localizations.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key? key}) : super(key: key);
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit=HotelSecreenCubit.get(context);
        if (state is LanguageChangedStates) {
          print(state.locale);
          print(cubit.selectedLanguage);
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(241, 241, 241, 1),
                ),
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.language,
                color: lightColorScheme.primary,
              ),
              title:  Text(AppLocalizations.of(context)!.language),
              trailing: const Icon(Icons.chevron_right),
              subtitle: Text(cubit.selectedLanguage),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Select Language"),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RadioListTile(
                                title: const Text("English"),
                                value: "English",
                                groupValue: cubit.selectedLanguage,
                                onChanged: (value) {
                                  setState(() {
                                    cubit.selectedLanguage = value!;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("العربية"),
                                value: "العربية",
                                groupValue: cubit.selectedLanguage,
                                onChanged: (value) {
                                  setState(() {
                                    cubit.selectedLanguage = value!;
                                    cubit.changeLang(cubit.selectedLanguage);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            cubit.changeLang(cubit.selectedLanguage);
                            Navigator.pop(context, cubit.selectedLanguage);
                            print(cubit.selectedLanguage);
                            cubit.getSharedLanguage();
                          },
                        ),
                      ],
                    );
                  },
                ).then((selectedLanguage) {
                  if (selectedLanguage != null) {
                    cubit.getSharedLanguage();
                  }
                });
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}