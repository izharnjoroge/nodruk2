import 'package:transporter/data/data.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectionController extends StatefulWidget {
  final String title;
  final List listdata;
  dynamic listItem;

  SelectionController({
    Key key,
    @required this.title,
    @required this.listItem,
    @required this.listdata,
  }) : super(key: key);

  @override
  _SelectionControllerState createState() => _SelectionControllerState();
}

class _SelectionControllerState extends State<SelectionController> {
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
                  fontSize: fontsize2,
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
            borderRadius: BorderRadius.circular(5.00),
            color: Colors.transparent,
            border: Border.all(
              width: 1.00,
              color: const Color(0xff707070),
            ),
          ),
          width: MediaQuery.of(context).size.width * 9,
          height: 50,
          child: widget.listItem == null
              ? const SizedBox.shrink()
              : DropdownButtonHideUnderline(
                  child: DropdownButton(
                    // Not necessary for Option 1
                    value: widget.title == 'Freight Origin Country'
                        ? appstate.focountry
                        : widget.title == 'Freight Destination Country'
                            ? appstate.fdcountry
                            : widget.listItem,
                    onChanged: (newValue) {
                      if (widget.title == 'Country of Origin') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.country = newValue;
                        });
                      } else if (widget.title == 'Gender') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.sgender = newValue;
                        });
                      } else if (widget.title == 'Identifier') {
                        setState(() {
                          widget.listItem = newValue;
                          // appstate.sidentifier = newValue;
                          appstate.updateind(newValue);
                        });
                      } else if (widget.title == 'Cargo Type') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.cargoType = newValue;
                        });
                      } else if (widget.title == 'Package Type') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.packaging = newValue;
                        });
                      } else if (widget.title == 'Country of Issue') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.icountry = newValue;
                        });
                      } else if (widget.title == 'Freight Origin Country') {
                        setState(() {
                          // widget.listItem = newValue;
                          appstate.focountry = newValue;
                          appstate.updatedocountry(newValue);
                        });
                      } else if (widget.title ==
                          'Freight Destination Country') {
                        setState(() {
                          // widget.listItem = newValue;
                          appstate.fdcountry = newValue;
                          appstate.updateddcountry(newValue);
                        });
                      } else if (widget.title == 'Currency') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.currency = newValue;
                        });
                      }
                    },
                    items: widget.listdata.map((t) {
                      return DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${t.name}"),
                        ),
                        value: t,
                      );
                    }).toList(),
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
