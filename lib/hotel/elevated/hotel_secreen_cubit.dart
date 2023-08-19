import 'package:bloc/bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../commen/theme/light_color_schema.dart';
import 'hotel_secreen_state.dart';

class HotelSecreenCubit extends Cubit<HotelSecreenStates> {
  HotelSecreenCubit() : super(ElevatedInitial());

  static HotelSecreenCubit get(context) => BlocProvider.of(context);

  double price=700;
  String current = "USD";
  int roomSelectionCount = 0;
  List<String> selectedPayment=[];
  List<String> selectedSort = [];
  bool isChecked = false;
  bool isCardVisible = false;
  bool isButtonVisible = true;
  int countA1 = 0;
  int countA2 = 0;
  int num_room = 1;
  List selectedAge1 = [];
  List selectedAge2 = [];
  var dateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  chooseDateRangePicker({required BuildContext context}) async {
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 20),
        initialDateRange: dateRange,
        builder: (context, child) => Theme(
            data: ThemeData.from(
              colorScheme: ColorScheme.light(
                  primary: lightColorScheme.primary,
                  surface: lightColorScheme.background,
                  onSurface: Colors.white,
                  background: Colors.white),
            ),
            child: child!));

    if (picked != null && picked != dateRange) {
      dateRange = picked;
    }
    emit(DateRangePickerState());
  }

  isCardVisibility() {
    if (selectedAge1.length != 0 || countA1 != 0) isCardVisible = true;
    emit(IsCardVisibilityState());
  }

  isCardNotVisibility() {
    isCardVisible = false;
    emit(IsCardNotVisibilityState());
  }

  isButtonVisibility() {
    if (isCardVisible) {
      num_room = 2;
      isButtonVisible = false;
    } else
      isButtonVisible = true;
    emit(IsButtonVisibilityState());
  }

  selectFilter() {
    selectedAge1.length = 0;
    selectedAge2.length = 0;
    isCardVisible = false;
    isButtonVisible = true;
    num_room = 1;
    emit(SelectFilterState());
  }

  incrementA() {
    int sum = selectedAge1.length + countA1;
    if (sum != 4) countA1++;
    emit(IncrementAState());
  }

  incrementB() {
    int sum = selectedAge2.length + countA2;
    if (sum != 4) countA2++;
    emit(IncrementBState());
  }

  decrementA() {
    if (countA1 != 0) countA1--;
    emit(DecrementAState());
  }

  decrementB() {
    if (countA2 != 0) countA2--;
    emit(DecrementBState());
  }

  incrementC(String oldChildren) {
    selectedAge1..add(oldChildren);
    emit(IncrementCState());
  }

  incrementD(String oldChildren) {
    selectedAge2..add(oldChildren);
    emit(IncrementDState());
  }

  decrementC(String orderName) {
    if (selectedAge1.isNotEmpty) selectedAge1.remove(orderName);
    emit(DecrementCState());
  }

  decrementD(String orderName) {
    if (selectedAge2.isNotEmpty) selectedAge2.remove(orderName);
    emit(DecrementDState());
  }

  istoggleA({required BuildContext context}) {
    var controller1 = ExpandableController.of(context);
    if (selectedAge1.isEmpty) {
      controller1!.toggle();
    }
    emit(IsToggleAState());
  }

  istoggleB({required BuildContext context}) {
    var controller2 = ExpandableController.of(context);
    if (selectedAge2.isEmpty) {
      controller2!.toggle();
    }
    emit(IsToggleBState());
  }

  displayChildrenA() {
    emit(DisplayChildrenState());
    return Container(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
                side: BorderSide(color: Colors.black12)),
            child: RPadding(
              padding: const EdgeInsets.all(10.0),
              child: Text("child ${index + 1} :${selectedAge1[index]} "),
            ),
          );
        },
        itemCount: selectedAge1.length,
      ),
    );
  }

  displayChildrenB() {
    emit(DisplayChildrenState());
    return Container(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
                side: BorderSide(color: Colors.black12)),
            child: RPadding(
              padding: const EdgeInsets.all(10.0),
              child: Text("child ${index + 1} :${selectedAge2[index]} "),
            ),
          );
        },
        itemCount: selectedAge2.length,
      ),
    );
  }

  showButtomsheetA({required BuildContext context}) {
    int sum = selectedAge1.length + countA1;
    if (sum != 4) {
      return showModalBottomSheet(
        context: context,
        builder: (context) => ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50.h,
                  color: Colors.white60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Age of child 1",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        RSizedBox(
                          width: 190,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 16.sp),
                            ))
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("Under 1 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Under 1 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("1 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "1 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("2 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "2 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("3 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "3 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("4 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "4 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("5 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "5 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("6 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "6 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("7 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "7 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("8 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "8 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("9 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "9 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("10 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "10 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    incrementC("11 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "11 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ]),
      );
    }
    emit(ShowButtomsheetAState());
  }

  showButtomsheetB({required BuildContext context}) {
    int sum = selectedAge2.length + countA2;
    if (sum != 4) {
      return showModalBottomSheet(
        context: context,
        builder: (context) => ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50.h,
                  color: Colors.white60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Age of child 1",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        RSizedBox(
                          width: 190,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 16.sp),
                            ))
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("Under 1 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Under 1 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("1 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "1 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("2 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "2 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("3 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "3 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("4 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "4 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("5 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "5 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("6 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "6 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("7 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "7 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("8 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "8 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("9 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "9 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("10 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "10 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<HotelSecreenCubit>(context)
                        .incrementD("11 year old");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "11 year old",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ]),
      );
    }
    emit(ShowButtomsheetBState());
  }

  void updateSelectedImageIndex(int index) {
    emit(ImageSelectedState(index));
  }
  void toggleSort(String selcted_sort) {
    if (selectedSort.contains(selcted_sort)) {
      selectedSort.remove(selcted_sort);
      print("remove");
    } else {
      selectedSort.clear();
      selectedSort.add(selcted_sort);
      print("add");
    }
    emit(SelectedSortState());
  }

  void togglePayment(String selcted_payment) {

    if (selectedPayment.contains(selcted_payment)) {
      selectedPayment.remove(selcted_payment);
    } else {
      selectedPayment.clear();
      selectedPayment.add(selcted_payment);
    }
    emit(SelectedPaymentState());
  }
  filterPrice(value){
    price=value;
    emit(FilterPriceState());
  }
  countRoom(){
    if(roomSelectionCount<3)
      roomSelectionCount++;
    print ("$roomSelectionCount");
    emit(countRoomState());
  }

  Current(value){
    current = value;
    emit(selectCurrentState());
  }
}
