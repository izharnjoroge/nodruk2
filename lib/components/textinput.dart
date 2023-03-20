import 'package:transporter/data/data.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/theme/theme.dart';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TextInputComponent extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final TextEditingController titleController;
  final TextInputType keyboardType;
  const TextInputComponent(
      {Key key,
      @required this.title,
      this.width,
      @required this.titleController,
      @required this.keyboardType,
      @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  fontSize: fontsize1,
                  color: fontcolor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.00),
            border: Border.all(
              width: 1.00,
              color: const Color(0xff707070),
            ),
          ),
          // width: MediaQuery.of(context).size.width * 9,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextFormField(
              controller: titleController,
              keyboardType: keyboardType,
              obscureText: false,
              validator: (value) {
                value = value.trim();
                if (value.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                  color: maincolor,
                )),
                // enabledBorder: UnderlineInputBorder.
              ),
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                color: maincolor,
              )),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class DateInputComponent extends StatefulWidget {
  final String title;
  final double height;
  final double width;

  const DateInputComponent({Key key, this.title, this.width, this.height})
      : super(key: key);

  @override
  State<DateInputComponent> createState() => _DateInputComponentState();
}

class _DateInputComponentState extends State<DateInputComponent> {
  String date = "";
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context, AppState appState) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        appState.selecteddate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  fontSize: fontsize1,
                  color: fontcolor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context, appstate);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.00),
              color: Colors.transparent,
              border: Border.all(
                width: 1.00,
                color: const Color(0xff707070),
              ),
            ),
            // width: MediaQuery.of(context).size.width * 9,
            height: widget.height,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      fontSize: fontsize1,
                      color: fontcolor2,
                    ),
                  ),
                )),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class PhoneNumberInputComponent extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final TextEditingController titleController;
  final TextInputType keyboardType;
  const PhoneNumberInputComponent(
      {Key key,
      @required this.title,
      this.width,
      @required this.titleController,
      @required this.keyboardType,
      @required this.height})
      : super(key: key);

  @override
  State<PhoneNumberInputComponent> createState() =>
      _PhoneNumberInputComponentState();
}

class _PhoneNumberInputComponentState extends State<PhoneNumberInputComponent> {
  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  fontSize: fontsize1,
                  color: fontcolor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.00),
                border: Border.all(
                  width: 1.00,
                  color: const Color(0xff707070),
                ),
              ),
              width: MediaQuery.of(context).size.width * .2,
              height: widget.height,
              child: CountryListPick(
                initialSelection: '+254',
                pickerBuilder: (context, CountryCode countryCode) {
                  return Row(
                    children: [
                      Image.asset(
                        countryCode.flagUri,
                        package: 'country_list_pick',
                        height: 15,
                        width: 17,
                      ),
                      Text(countryCode.dialCode),
                    ],
                  );
                },
                onChanged: (CountryCode code) {
                  if (widget.title == 'Phone Number') {
                    setState(() {
                      appstate.phonenocode = code.dialCode;
                    });
                  } else if (widget.title == 'Alternative Phone Number') {
                    setState(() {
                      appstate.altphonenocode = code.dialCode;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.00),
                border: Border.all(
                  width: 1.00,
                  color: const Color(0xff707070),
                ),
              ),
              width: MediaQuery.of(context).size.width * .72,
              height: widget.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  controller: widget.titleController,
                  keyboardType: widget.keyboardType,
                  obscureText: false,
                  validator: (value) {
                    value = value.trim();
                    if (value.isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                      color: maincolor,
                    )),
                    // enabledBorder: UnderlineInputBorder.
                  ),
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                    color: maincolor,
                  )),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
