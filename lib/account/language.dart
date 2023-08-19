import 'package:booking/hotel/elevated/hotel_secreen_cubit.dart';
import 'package:booking/hotel/elevated/hotel_secreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              subtitle: Text(cubit.selectedLanguage.getLangName),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Select Language"),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            height: 95.h,
                            child: ListView.builder(
                              itemCount: AppLanguage.values.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                  title: Text(
                                    AppLanguage.values[index].getLangName,
                                  ),
                                  value: AppLanguage.values[index],
                                  groupValue: cubit.selectedLanguage,
                                  onChanged: (value) {
                                      cubit.selectedLanguage = value!;
                                      cubit.changeLang(value.getLangName);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            cubit.changeLang(cubit.selectedLanguage.getLangName);
                            Navigator.pop(context, cubit.selectedLanguage);
                          },
                        ),
                      ],
                    );
                  },
                ).then((selectedLanguage) {
                  if (selectedLanguage != null) {

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

extension LanguageExtension on AppLanguage {
  String get getLangName {
    switch (this) {
      case AppLanguage.ar:
        return "العربية";
      case AppLanguage.en:
        return "English";
      default:
        return "";
    }
  }
}
