abstract class HotelSecreenStates {}

class ElevatedInitial extends HotelSecreenStates {}

class DateRangePickerState extends HotelSecreenStates {}

class SelectFilterState extends HotelSecreenStates {}

class IncrementAState extends HotelSecreenStates {}

class IncrementBState extends HotelSecreenStates {}

class DecrementAState extends HotelSecreenStates {}

class DecrementBState extends HotelSecreenStates {}

class DecrementCState extends HotelSecreenStates {}

class DecrementDState extends HotelSecreenStates {}

class IncrementCState extends HotelSecreenStates {}

class IncrementDState extends HotelSecreenStates {}

class DisplayChildrenState extends HotelSecreenStates {}

class ShowButtomsheetAState extends HotelSecreenStates {}

class ShowButtomsheetBState extends HotelSecreenStates {}

class IsToggleAState extends HotelSecreenStates {}

class IsToggleBState extends HotelSecreenStates {}

class IsCardVisibilityState extends HotelSecreenStates {}

class IsCardNotVisibilityState extends HotelSecreenStates {}

class IsButtonVisibilityState extends HotelSecreenStates {}

class ImageSelectedState extends HotelSecreenStates {
  final int index;

  ImageSelectedState(this.index);
}

class SelectedPaymentState extends HotelSecreenStates {}

class SelectedSortState extends HotelSecreenStates {}

class FilterPriceState extends HotelSecreenStates {}

class countRoomState extends HotelSecreenStates {}

class selectCurrentState extends HotelSecreenStates {}

class UpdateReservationState extends HotelSecreenStates {}
