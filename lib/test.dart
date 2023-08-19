


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  Room(
      this.type, //duplicity or single  or king
      this.space,
      this.price,
      this.internet,
      this.conditioning,
      this.view,
      this.avaliable,
      this.image1,
      this.image2,
      this.hotelname,
      this.id);

  String type; //duplicity or single  or king
  int space;
  int price;
  bool internet;
  bool conditioning;
  bool view;
  bool avaliable;
  String image1;
  String image2;
  String hotelname;
  int id;

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  List<Room> DataRoom = [


    Room("duplicity", 42, 1100, true, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/433/433359907.jpg","https://cf.bstatic.com/images/hotel/max1024x768/433/433360180.jpg","Atlantic Hamburg", 1),
    Room("single", 32, 665, false, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/433/433359886.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/433/433360134.jpg", "Atlantic Hamburg", 2),
    Room("king", 42, 1150, false, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/433/433359896.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/433/433360134.jpg","Atlantic Hamburg", 3),


    Room("single", 26, 720, false, true, false, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/90061766.jpg?k=792e0dea4b53104f72b2b8b64411b1caf52c14b6d29b9e452947ef1f3030072d&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/245808501.jpg?k=be23a3f06ecd5cf4a2e074ecb630b40594eb746301dcef1d6a696fe5dcb0af07&o=&hp=1","Citadines", 4),
    Room("duplicity", 32, 910, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/245808341.jpg?k=57fef6b798961a8a3837577547a89f70c8555bcc7a1c3da049ac52be240dde6d&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/90061787.jpg?k=8db91f724b2af26769756637c53ea207ff55409988551ce8e85fdba5af21a49f&o=&hp=1", "Citadines", 5),
    Room("king", 40, 1130, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/89366262.jpg?k=15044a46801f2762c00cf033809a08320f5727bca1b5f321d40f456a7570da13&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/89366292.jpg?k=ba21b67ac93dccfc161116323364d3517e7f66e1b24b511de6238339d7adad07&o=&hp=1", "Citadines", 6),


    Room("single", 32, 665, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/426615670.jpg?k=09af8881d889c03ed4bfa7ee60f8d182016bd66f4287d7a85c605b8575a024de&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/426615695.jpg?k=1c582db9398cd3d154e07acc0eede9b061e266b006770207626fcfaac4308d75&o=&hp=1", "The Ritz-Carlton", 7),
    Room("king", 42, 1150, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/426615671.jpg?k=51029b1c94a3962e95c189e6487262056f0c54f4e6983e6c22094468d0a650d2&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/426615941.jpg?k=200a9ae35daa65c73fba9dde7cbee5971a57ff60fa42e77111820c6ebc84e408&o=&hp=1","The Ritz-Carlton", 8),
    Room("duplicity", 42, 1100, true, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/426615827.jpg?k=c59d740772ccded01f00d856897bf94f15d6b091b316aab79ff3a0d81add06af&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/426615819.jpg?k=0e23b1f0a95bdfebeba8e56ec234b1baf950c50534b763908b49692b242100eb&o=&hp=1","The Ritz-Carlton", 9),




    Room("single", 30, 750, true, false, true, true,"https://cf.bstatic.com/images/hotel/max1024x768/185/185971402.jpg","https://cf.bstatic.com/images/hotel/max1024x768/215/215875057.jpg", "Narcissus", 10),

    Room("duplicity", 32, 880, true, false, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/476/476074129.jpg","https://cf.bstatic.com/images/hotel/max1024x768/476/476076235.jpg","Narcissus", 11),

    Room("king", 35, 1025, true, false, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/185/185957349.jpg","https://cf.bstatic.com/images/hotel/max1024x768/185/185957372.jpg", "Narcissus",12),

    Room("single", 32, 665, false, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/238/238921702.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/338/338373449.jpg", "Pullman Sharjah", 13),
    Room("king", 42, 1150, false, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/339/339034231.jpg","https://cf.bstatic.com/images/hotel/max1024x768/338/338374244.jpg","Pullman Sharjah", 14),
    Room("duplicity", 42, 1100, true, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/338/338374254.jpg","https://cf.bstatic.com/images/hotel/max1024x768/238/238916265.jpg","Pullman Sharjah", 15),


    Room("single", 26, 726, false, true, false, true, "https://cf.bstatic.com/images/hotel/max1024x768/217/217331975.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/217/217331952.jpg","Novotel Sharjah", 16),
    Room("duplicity", 32, 918, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/279051502.jpg?k=4e0703e2eede3f55f3248aede65d443841e984ae2558b9aa223053ec06a5583c&o=&hp=1", "https://cf.bstatic.com/images/hotel/max1024x768/217/217333451.jpg", "Novotel Sharjah", 17),
    Room("king", 40, 1135, false, true, true, true,"https://cf.bstatic.com/images/hotel/max1024x768/217/217331567.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/237/237637684.jpg", "Novotel Sharjah", 18),



    Room("single", 30, 700, true, true, false, true, "https://cf.bstatic.com/images/hotel/max1024x768/447/447082045.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/447/447082047.jpg", "Izmir Marriott", 19),
    Room("duplicity", 45, 1075, true, false, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/447/447082021.jpg","https://cf.bstatic.com/images/hotel/max1024x768/447/447082052.jpg","Izmir Marriott", 20),
    Room("king", 40, 1180, true, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/447/447082048.jpg", "https://cf.bstatic.com/images/hotel/max1024x768/447/447082041.jpg","Izmir Marriott", 21),

    Room("single", 22, 710, true, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/322/322589910.jpg","https://cf.bstatic.com/images/hotel/max1024x768/365/365420387.jpg","Mövenpick", 22),
    Room("duplicity", 28, 820, true, false, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/456/456892868.jpg","https://cf.bstatic.com/images/hotel/max1024x768/456/456892885.jpg", "Mövenpick", 23),
    Room("king", 25, 955, true, true, true, true, "https://cf.bstatic.com/images/hotel/max1024x768/456/456892864.jpg","https://cf.bstatic.com/images/hotel/max1024x768/322/322589927.jpg", "Mövenpick ", 24),


    Room("single", 30, 700, true, true, false, true, "", "", "Grassias Resort", 13),
    Room("duplicity", 45, 1075, true, false, true, true, "", "","Grassias Resort", 100),
    Room("king", 40, 1180, true, true, true, true, "", "","Grassias Resort", 96),


    Room("single", 30, 750, true, false, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/120700001.jpg?k=f7b8d72442e2153b7adfb65b8fa70d7ce9f37699ee7048f6a77ea18edebc74ea&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/284397358.jpg?k=292000de4041c593673cb47d0aaedf107a3e435af34bea1bbadab42ff88bfb31&o=&hp=1", "Aquarius Touristic Resort", 25),
    Room("duplicity", 32, 880, true, false, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/187316765.jpg?k=5295395b5f65b35f6ffa3eb6949ddfeddae5dddd6a4dab304f4914ce7f3d4687&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/284399427.jpg?k=6f4acfc502c72a78d982572886a0f4ca85de07e554f6c794905d60a87ebe5c7b&o=&hp=1", "Aquarius Touristic Resort", 26),
    Room("king", 35, 1025, true, false, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/284397373.jpg?k=8a5a4b29c509f0983d66f4bfac0b1ce6f0af6605fc3429b659249aa3bda282aa&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/11760732.jpg?k=f4a158def22ad542d06426233efcf60e8f4faba7ff745c5d073999a9f510ed6d&o=&hp=1", "Aquarius Touristic Resort",27),

    Room("single", 32, 665, false, true, true, true, "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.trvl-media.com%2Flodging%2F43000000%2F42580000%2F42575000%2F42574953%2F68152e44.jpg%3Fimpolicy%3Dfcrop%26w%3D1200%26h%3D800%26p%3D1%26q%3Dmedium&tbnid=Pkz4Qk5mG8KSqM&vet=12ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMygjegUIARD-AQ..i&imgrefurl=https%3A%2F%2Fwww.expedia.com%2FAlexandria-Hotels-SUNRISE-Alex-Avenue-Hotel.h42574953.Hotel-Information&docid=mfGQ3YaUlQobsM&w=1200&h=800&q=Sunrise%20Alex%20Avenue%20booking&ved=2ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMygjegUIARD-AQ", "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.trvl-media.com%2Flodging%2F43000000%2F42580000%2F42575000%2F42574953%2Fabcb7e77.jpg%3Fimpolicy%3Dfcrop%26w%3D1200%26h%3D800%26p%3D1%26q%3Dmedium&tbnid=t1QqmeBv5vSaVM&vet=10CBoQMyh0ahcKEwjA45y2l6OAAxUAAAAAHQAAAAAQDw..i&imgrefurl=https%3A%2F%2Fwww.hotels.com%2Fho1363398496%2Fsunrise-alex-avenue-hotel-alexandria-egypt%2F&docid=eVdeXEDiZ3gBkM&w=1200&h=800&q=Sunrise%20Alex%20Avenue%20booking&ved=0CBoQMyh0ahcKEwjA45y2l6OAAxUAAAAAHQAAAAAQDw", "Sunrise Alex Avenue", 28),
    Room("king", 42, 1150, false, true, true, true, "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmediterranean-azur-hotel-alexandria.booked.net%2Fdata%2FPhotos%2FOriginalPhoto%2F12041%2F1204166%2F1204166218%2FSunrise-Alex-Avenue-Hotel-Alexandria-Exterior.JPEG&tbnid=o3ifO5n7-kVe_M&vet=12ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyglegUIARCCAg..i&imgrefurl=https%3A%2F%2Fmediterranean-azur-hotel-alexandria.booked.net%2F&docid=otJrozqtk41hUM&w=1280&h=883&q=Sunrise%20Alex%20Avenue%20booking&ved=2ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyglegUIARCCAg", "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.trvl-media.com%2Flodging%2F43000000%2F42580000%2F42575000%2F42574953%2F84e0ff15.jpg%3Fimpolicy%3Dfcrop%26w%3D1200%26h%3D800%26p%3D1%26q%3Dmedium&tbnid=fLc8PN4HHsuBRM&vet=12ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyhkegUIARCqAQ..i&imgrefurl=https%3A%2F%2Fwww.hotels.com%2Fho1363398496%2Fsunrise-alex-avenue-hotel-alexandria-egypt%2F&docid=eVdeXEDiZ3gBkM&w=1200&h=800&q=Sunrise%20Alex%20Avenue%20booking&ved=2ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyhkegUIARCqAQ","Sunrise Alex Avenue", 29),
    Room("duplicity", 42, 1100, true, true, true, true, "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.trvl-media.com%2Flodging%2F43000000%2F42580000%2F42575000%2F42574953%2F9f38d805.jpg%3Fimpolicy%3Dfcrop%26w%3D1200%26h%3D800%26p%3D1%26q%3Dmedium&tbnid=bmFyFmLKKTlWhM&vet=12ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyhNegQIARB3..i&imgrefurl=https%3A%2F%2Fwww.hotels.com%2Fho1363398496%2Fsunrise-alex-avenue-hotel-alexandria-egypt%2F&docid=eVdeXEDiZ3gBkM&w=1200&h=800&q=Sunrise%20Alex%20Avenue%20booking&ved=2ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyhNegQIARB3", "https://www.google.com/imgres?imgurl=https%3A%2F%2Fc.otcdn.com%2Fimglib%2Fhotelfotos%2F8%2F379%2Fresort-mediterranean-azur-alejandria-000.jpg&tbnid=6R9AKoZzNjIYdM&vet=12ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyhTegUIARCDAQ..i&imgrefurl=https%3A%2F%2Fdestinia.com%2Fen%2Fh%2Fh379585-hotel-sunrise-alex-avenue&docid=KqdIqpBetBFHQM&w=820&h=560&q=Sunrise%20Alex%20Avenue%20booking&ved=2ahUKEwi_7Zqxl6OAAxVj_bsIHTzPCSUQMyhTegUIARCDAQ","Sunrise Alex Avenue", 30),


    Room("single", 30, 655, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/31104435.jpg?k=670aa25edc6929e839c99cac1d7e2a31f2dc79c3ce9c7674169af837ed39e1f0&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/427293720.jpg?k=11cdfdd88626f0490ecc013d3e0ae2767eb6c27aa8376ada7abd0d84c6178d82&o=&hp=1", "Hilton", 31),
    Room("king", 44, 1350, false, true, true, true, "https://cf.bstatic.com/xdata/images/hotel/max1024x768/427290064.jpg?k=3bb2ff8ebf9404460df46414050a4ac469a894663eed142f2565485144c89484&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/427294220.jpg?k=8eace528c23fae8758e3476aaaf4cc906993f6a2ce88058a2f0b01dcad77adf5&o=&hp=1","Hilton", 32),
    Room("duplicity", 40, 1050, true, true, true, true, "3https://cf.bstatic.com/xdata/images/hotel/max1024x768/34704593.jpg?k=5965e51a46e5d0951493e2da431be49addf838a393f15d7f7aa51d8d22f29a62&o=&hp=1", "https://cf.bstatic.com/xdata/images/hotel/max1024x768/54020072.jpg?k=9b292a1ed3edb350b24047b416ff4f2b488c42dae46914f63b773b6beb6db23c&o=&hp=1","Hilton", 33),





















  ];

  CollectionReference data = FirebaseFirestore.instance.collection("room");


  void addData() async {
    for (Room room in DataRoom) {
      data.add({
        'type': room.type,
        'space': room.space,
        'price': room.price,
        'internet': room.internet,
        'conditioning': room.conditioning,
        'avaliable': room.avaliable,
        'view': room.view,
        'image1': room.image1,
        'image2': room.image2,
        'hotelname': room.hotelname,
        'id': room.id
      });
      print(DataRoom);
    }
    await data.orderBy("hotelname").get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        print("======================================");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            addData();
          },
          color: Colors.blue,
        ),
      ),
    );
  }
}