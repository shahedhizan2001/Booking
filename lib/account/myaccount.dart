import 'package:booking/account/payment.dart';
import 'package:booking/account/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../commen/theme/global_functions.dart';
import '../commen/theme/light_color_schema.dart';
import '../hotel/app_bar.dart';
import '../hotel/elevated/hotel_secreen_cubit.dart';
import '../hotel/elevated/hotel_secreen_state.dart';
import '../screens/From_Countries_page.dart';
import 'currency.dart';
import 'help.dart';
import 'login.dart';

class booking extends StatefulWidget {
  const booking({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return bookingstate();
  }
}

class bookingstate extends State<booking> {
  String? lang;
  String selectedCountry = "syria";
  String? ValueNotifier;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<HotelSecreenCubit,HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit=HotelSecreenCubit.get(context);
        return Scaffold(
            appBar: appBar(
              title: "Account",
              weight: FontWeight.normal,
              centre: true,
            ),
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: FutureBuilder(
                    future: GlobalFunctions().isAuth(),
                    builder: (context, snapshot) {
                      return ListTile(
                          leading: Icon(Icons.login_outlined,
                              color: lightColorScheme.primary),
                          title: snapshot.hasData
                              ? snapshot.requireData
                              ? const Text("Profile")
                              : const Text('Login')
                              : const SizedBox(),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            snapshot.requireData
                                ? Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return UserProfileScreen();
                            }))
                                : Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return Login(
                                  con: true,
                                );
                              }),
                            );
                          });
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 7, color: Color.fromRGBO(241, 241, 241, 1)),
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(241, 241, 241, 1))),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.flag, color: lightColorScheme.primary),
                    title: const Text("Region"),
                    trailing: const Icon(Icons.chevron_right),
                    subtitle: Text(selectedCountry),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FromCountriesPage()),
                      );
                      if (result != null) {
                        setState(() {
                          selectedCountry = result;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(241, 241, 241, 1))),
                  ),
                  child: ListTile(
                    leading:
                    Icon(Icons.attach_money, color: lightColorScheme.primary),
                    title: const Text("Currency"),
                    trailing: const Icon(Icons.chevron_right),
                    subtitle:  cubit.selectedCurrency.isNotEmpty
                        ? Text(cubit.selectedCurrency.last)
                        : null,
                    onTap: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrencyListPage()),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(241, 241, 241, 1),
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.payment, color: lightColorScheme.primary),
                    title: const Text("Payment types"),
                    trailing: const Icon(Icons.chevron_right),
                    subtitle: cubit.selectedPayment.isNotEmpty
                        ? Text(cubit.selectedPayment.last)
                        : null,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSelectionPage(con: true),
                        ),
                      );
                      if(result!=null)
                        cubit.changepayment(result);
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 13, color: Color.fromRGBO(241, 241, 241, 1)),
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(241, 241, 241, 1))),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.help, color: lightColorScheme.primary),
                    title: const Text("Help center"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return help();
                      }));
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(241, 241, 241, 1))),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.thumb_up, color: lightColorScheme.primary),
                    title: const Text("Rate us"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ),
              ],
            ));
      },
    );
  }
}
