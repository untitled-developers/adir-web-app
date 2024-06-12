import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget datePicker(
    {required BuildContext context,
    required String label,
    required String? chosenDate,
    required Function callCalendarBack,
    Function? rangeCallBack,
    bool? valid,
    CalendarDatePicker2Mode? calendarViewMode,
    DateTime? lastDate,
    calendarType}) {
  return GestureDetector(
    onTap: () => showCalendarDialog(context, callCalendarBack, calendarType,
        rangeCallBack: rangeCallBack,
        chosenDate: chosenDate,
        calendarViewMode: calendarViewMode,
        lastDate: lastDate),
    child: Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
            color:
                valid != null && valid == false ? Colors.red : Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          chosenDate == null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(label,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(167, 167, 167, 1))),
                  ),
                )
              : Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).primaryColor),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text(chosenDate!)),
                    ],
                  ),
                ),
          Icon(Icons.calendar_month)
        ],
      ),
    ),
  );
}

List<DateTime?> _singleDatePickerValueWithDefaultValue = [
  DateTime.now(),
];

showCalendarDialog(
    BuildContext context, Function callCalendarBack, calendarType,
    {String? selectedDateRange,
    Function? rangeCallBack,
    String? chosenDate,
    DateTime? lastDate,
    CalendarDatePicker2Mode? calendarViewMode}) async {
  return showGeneralDialog(
      barrierColor: const Color.fromRGBO(20, 20, 20, 0.2),
      context: context,
      useRootNavigator: false,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.15,
              vertical: 12),
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: (calendarType == CalendarDatePicker2Type.range)
                    ? _buildCalendarWithActionButtons(
                        context,
                        CalendarDatePicker2Type.range,
                        callCalendarBack,
                        lastDate: lastDate,
                        rangeCallBack: rangeCallBack,
                        calendarViewMode: calendarViewMode,
                        chosenDate == null
                            ? [
                                DateTime.now()
                                    .subtract(const Duration(days: 5)),
                                DateTime.now(),
                              ]
                            : [
                                DateFormat('MMM dd yyyy', 'en_US')
                                    .parse(chosenDate.split(' - ')[0]),
                                DateFormat('MMM dd yyyy', 'en_US')
                                    .parse(chosenDate.split(' - ')[1])
                              ],
                        selectedDateRange: selectedDateRange)
                    : _buildCalendarWithActionButtons(
                        context,
                        CalendarDatePicker2Type.single,
                        callCalendarBack,
                        _singleDatePickerValueWithDefaultValue,
                        lastDate: lastDate,
                        calendarViewMode: calendarViewMode)),
          ),
        );
      });
}

Widget _buildCalendarWithActionButtons(BuildContext context, calendarType,
    Function callCalendarBack, List<DateTime?> dateList,
    {String? selectedDateRange,
    Function? rangeCallBack,
    DateTime? lastDate,
    CalendarDatePicker2Mode? calendarViewMode}) {
  final config = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: calendarType,
    disableMonthPicker: calendarViewMode != null,
    disableModePicker: true,
    calendarViewMode: calendarViewMode,
    gapBetweenCalendarAndButtons: 10,
    selectedDayTextStyle: const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
    selectedDayHighlightColor: Theme.of(context).primaryColor,
    lastDate: lastDate,
    lastMonthIcon:
        Icon(Icons.chevron_left, color: Theme.of(context).primaryColor),
    nextMonthIcon:
        Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
    controlsTextStyle: TextStyle(
        fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
    okButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(219, 211, 229, 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Apply',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        )),
    cancelButton: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 35),
        child: Text('Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            )),
      ),
    ),
  );
  return StatefulBuilder(builder: (
    BuildContext context,
    setDialogState,
  ) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker2WithActionButtons(
              config: config,
              onOkTapped: () {
                setDialogState(() {
                  if (calendarType == CalendarDatePicker2Type.range) {
                    if (rangeCallBack != null) rangeCallBack();
                  }
                });
                callCalendarBack(
                  _getValueText(
                    config.calendarType,
                    dateList,
                  ),
                );
                Navigator.of(context, rootNavigator: false).pop();
              },
              onCancelTapped: () =>
                  Navigator.of(context, rootNavigator: false).pop(),
              value: dateList,
              onValueChanged: (values) {
                setDialogState(() {
                  dateList = values;
                });
              }),
        ],
      ),
    );
  });
}

String _getValueText(
  CalendarDatePicker2Type datePickerType,
  List<DateTime?> values,
) {
  var valueText = DateFormat('MMM dd yyyy', 'en_US')
      .format(values.isNotEmpty ? values[0]! : DateTime.now());
  if (datePickerType == CalendarDatePicker2Type.range) {
    if (values.isNotEmpty) {
      final startDate = DateFormat('MMM dd yyyy', 'en_US').format(values[0]!);
      final endDate = values.length > 1
          ? DateFormat('MMM dd yyyy', 'en_US').format(values[1]!)
          : startDate;
      valueText = '$startDate - $endDate';
    } else {
      return 'null';
    }
  }
  if (datePickerType == CalendarDatePicker2Type.single) {
    if (values.isNotEmpty) {
      final selectedDate = DateFormat('yyyy-MM-dd', 'en_US')
          .format(values.isNotEmpty ? values[0]! : DateTime.now());
      valueText = selectedDate;
    } else {
      return 'null';
    }
  }
  return valueText;
}
