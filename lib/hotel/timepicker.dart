import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTimeRange?> showDateRangePicker({
  required BuildContext context,
  DateTimeRange? initialDateRange,
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? currentDate,
  DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  String? helpText,
  String? cancelText,
  String? confirmText,
  String? saveText,
  String? errorFormatText,
  String? errorInvalidText,
  String? errorInvalidRangeText,
  String? fieldStartHintText,
  String? fieldEndHintText,
  String? fieldStartLabelText,
  String? fieldEndLabelText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? textDirection,
  TransitionBuilder? builder,
  Offset? anchorPoint,
  TextInputType keyboardType = TextInputType.datetime,
}) async {
  DateTimeRange?userSelectedDate= await showDateRangePicker(context: context, firstDate: DateTime(2023), lastDate: DateTime(2030));
  assert(
  initialDateRange == null || !initialDateRange.start.isAfter(initialDateRange.end),
  "initialDateRange's start date must not be after it's end date.",
  );
  initialDateRange = initialDateRange == null ? null : DateUtils.datesOnly(initialDateRange);
  firstDate = DateUtils.dateOnly(firstDate);
  lastDate = DateUtils.dateOnly(lastDate);
  assert(
  !lastDate.isBefore(firstDate),
  'lastDate $lastDate must be on or after firstDate $firstDate.',
  );
  assert(
  initialDateRange == null || !initialDateRange.start.isBefore(firstDate),
  "initialDateRange's start date must be on or after firstDate $firstDate.",
  );
  assert(
  initialDateRange == null || !initialDateRange.end.isBefore(firstDate),
  "initialDateRange's end date must be on or after firstDate $firstDate.",
  );
  assert(
  initialDateRange == null || !initialDateRange.start.isAfter(lastDate),
  "initialDateRange's start date must be on or before lastDate $lastDate.",
  );
  assert(
  initialDateRange == null || !initialDateRange.end.isAfter(lastDate),
  "initialDateRange's end date must be on or before lastDate $lastDate.",
  );
  currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now());
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = DateRangePickerDialog(
    initialDateRange: initialDateRange,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: currentDate,
    initialEntryMode: initialEntryMode,
    helpText: helpText,
    cancelText: cancelText,
    confirmText: confirmText,
    saveText: saveText,
    errorFormatText: errorFormatText,
    errorInvalidText: errorInvalidText,
    errorInvalidRangeText: errorInvalidRangeText,
    fieldStartHintText: fieldStartHintText,
    fieldEndHintText: fieldEndHintText,
    fieldStartLabelText: fieldStartLabelText,
    fieldEndLabelText: fieldEndLabelText,
  );



  if (textDirection != null) {
    dialog = Directionality(
      textDirection: textDirection,
      child: dialog,
    );
  }

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
    void _selectDateRange(DateTimeRange? newSelectedDate) {
      if (newSelectedDate != null) {

        firstDate = newSelectedDate.start;
        lastDate= newSelectedDate.end;

      }

    }



    return showDialog<DateTimeRange>(
      context: context,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      useSafeArea: false,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
    );

  }

}