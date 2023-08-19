import 'package:equatable/equatable.dart';
abstract class hotelEvent extends Equatable{
@override
  List<Object> get props => [];
}
class Create extends hotelEvent{
  final String city;
  final String country;
  final int evaluation;
  final String image;
  final String name;

  Create({  required this.city,
     required this.country,
     required this.evaluation,
     required this.image,
     required this.name
  } );
}
class getData extends hotelEvent{
  getData();
}