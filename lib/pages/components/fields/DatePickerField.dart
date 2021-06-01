import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {

  final void Function(DateTime) onDateSelected;

  final controller;


  DatePickerField({
    this.controller,
    this.onDateSelected
  });

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {

  final _dateTimeFieldController = TextEditingController();

  DateTime _selectedDateTime = DateTime.now();


  set selectedDateTime(DateTime value) {
    _selectedDateTime = value;

    

    _dateTimeFieldController.text = _toFormatedDate(value);
  }

  @override
  void initState() {
    super.initState();

    if(widget.controller != null) {
      widget.controller._state = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: ()  => _showDatePicker(context),
      decoration: InputDecoration(
        hintText: "Sua data de nascimento",
      ),
      controller: _dateTimeFieldController,
    );
  }
  
  void _showDatePicker(BuildContext context) async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );

    if(dateTime != null){
      setState(() {
        selectedDateTime = dateTime;
        widget.onDateSelected(dateTime);

        _dateTimeFieldController.text = _toFormatedDate(dateTime);
      });
    }
  }

  String _toFormatedDate(DateTime dateTime) {
    String result = dateTime.day <= 9 ?
      '0${dateTime.day}':
      '${dateTime.day}';

    result += dateTime.month <= 9 ?
      '/0${dateTime.month}':
      '/${dateTime.month}';

    result += '/${dateTime.year}';

    return result;
  }
}

class DatePickerFieldController {

  _DatePickerFieldState _state;

  set selectedDate(DateTime value) => _state.selectedDateTime = value;

  get selectedDate => _state._selectedDateTime;
}