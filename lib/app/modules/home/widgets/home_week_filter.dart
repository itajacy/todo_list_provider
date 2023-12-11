import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'DIA DA SEMANA',
          style: context.titleStyle,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 106,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            height: 500,
            width: 70,
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: TextStyle(fontSize: 8),
            dayTextStyle: TextStyle(fontSize: 13),
            dateTextStyle: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}