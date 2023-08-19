import 'package:booking/hotel/elevated/hotel_secreen_cubit.dart';
import 'package:booking/hotel/elevated/hotel_secreen_state.dart';
import 'package:booking/screens/CabinClass_page.dart';
import 'package:booking/screens/Finish_page.dart';
import 'package:booking/screens/From_Countries_page.dart';
import 'package:booking/screens/Passangers_page.dart';
import 'package:booking/screens/RegPage.dart';
import 'package:booking/screens/To_Countries_page.dart';
import 'package:booking/screens/flight_search_page.dart';
import 'package:booking/screens/information_passport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'account/payment.dart';
import 'commen/theme/app_theme.dart';
import 'hotel/secreens/Hotelsection.dart';
import 'hotel/secreens/base_page.dart';
import 'hotel/secreens/go.dart';
import 'hotel/secreens/image_room.dart';
import 'hotel/secreens/option_secreen.dart';
import 'hotel/secreens/splashscreen.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit=HotelSecreenCubit.get(context);
        if (state is LanguageChangedStates) {
          print(state.locale);
          return ScreenUtilInit(
            designSize: const Size(380, 700),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                routes: {
                  'FromCountriesPage': (context) => FromCountriesPage(),
                  'ToCountriesPage': (context) => ToCountriesPage(),
                  'FlightPage': (context) => FlightPage(),
                  'PassangersPage': (context) => PassangersPage(),
                  'CabinClassPage': (context) => CabinClassPage(),
                  'TypePaymentPage': (context) =>
                      PaymentSelectionPage(con: true),
                  'RegPage': (context) => RegPage(edit: false),
                  'PassportPage': (context) => InfoPassportPage(edit: false),
                  'BasePage': (context) => BasePage(),
                  'FinishPage': (context) => FinishPage(),
                  'HomeSecreen': (context) => SectionHome(),
                  'HotelSection': (context) => HotelSection(),
                  'OptionSecreen': (context) => OptionSecreen(),
                  'ImageRoom': (context) => ImageSecreen(
                        images: [],
                      )
                },
                locale:state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate, // Add this line
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                localeResolutionCallback: localCallBack,
                home: BasePage(),
                debugShowCheckedModeBanner: false,
                theme: getAppTheme(ThemeMode.light, context),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  Locale localCallBack(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.last;
    }
    for (var supportedLocale in supportedLocales) {
      if (locale.languageCode == supportedLocale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.last;
  }
}
