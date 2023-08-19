import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custms/CalenderR.dart';
import '../custms/Listtile_custm.dart';
import '../custms/Search_button.dart';
import '../custms/calenderD.dart';
class FlightPage extends StatelessWidget {
  FlightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color(0XFF1baedf),
              title: const Text('Flights Search'),
              bottom: const TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 0.0, color: Color(0XFF4CBB17)),
                ),
                tabs: [
                  Tab(
                    child: Text('ONE-WAY'),
                  ),
                  Tab(
                    child: Text('ROUND TRIP'),
                  )
                ],
              )),
          body: TabBarView(
            children: [
              Column(
                children: [
                  ListtilecustmPlan(
                    text2: 'Departure',
                    icons: const Icon(
                      FontAwesomeIcons.planeDeparture,
                      color: Color(0XFF808080),
                    ),
                    push: 'FromCountriesPage',
                  ),
                  ListtilecustmPlan(
                    text2: 'Destination',
                    icons: const Icon(
                      FontAwesomeIcons.planeArrival,
                      color: Color(0XFF808080),
                    ),
                    push: 'ToCountriesPage',
                  ),
                  listtilePassanger(
                    text2: 'Passangers',
                    icons: const Icon(
                      Icons.people_alt,
                      color: Color(0XFF808080),
                    ),
                    push: 'PassangersPage',
                  ),
                  listtileCabin(
                    text2: 'Cabin Class',
                    icons: const Icon(
                      Icons.card_travel,
                      color: Color(0XFF808080),
                      size: 28,
                    ),
                    push: 'CabinClassPage',
                  ),
                  listtilePayment(
                    text2: 'Payment Type',
                    icons: const Icon(
                      Icons.credit_card,
                      color: Color(0XFF808080),
                      size: 28,
                    ),
                    push: 'TypePaymentPage',
                    endint: 500,
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListtilecustmPlan(
                      text2: 'Departure',
                      icons: const Icon(
                        FontAwesomeIcons.planeDeparture,
                        color: Color(0XFF808080),
                      ),
                      push: 'FromCountriesPage',
                    ),
                    ListtilecustmPlan(
                      text2: 'Destination',
                      icons: const Icon(
                        FontAwesomeIcons.planeArrival,
                        color: Color(0XFF808080),
                      ),
                      push: 'ToCountriesPage',

                    ),
                    listtilePassanger(
                      text2: 'Passangers',
                      icons: const Icon(
                        Icons.people_alt,
                        color: Color(0XFF808080),
                      ),
                      push: 'PassangersPage',
                    ),
                    listtileCabin(
                      text2: 'Cabin Class',
                      icons: const Icon(
                        Icons.card_travel,
                        color: Color(0XFF808080),
                        size: 28,
                      ),
                      push: 'CabinClassPage',
                    ),
                    listtilePayment(
                      text2: 'Payment Type',
                      icons: const Icon(
                        Icons.credit_card,
                        color: Color(0XFF808080),
                        size: 28,
                      ),
                      push: 'TypePaymentPage',
                      endint: 500,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
