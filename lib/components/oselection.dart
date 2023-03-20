import 'package:transporter/data/data.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OselectionController extends StatefulWidget {
  final String title;
  final List listdata;
  dynamic listItem;

  OselectionController({
    Key key,
    @required this.title,
    @required this.listItem,
    @required this.listdata,
  }) : super(key: key);

  @override
  _OselectionControllerState createState() => _OselectionControllerState();
}

class _OselectionControllerState extends State<OselectionController> {
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
                    value: widget.listItem,
                    onChanged: (newValue) {
                      if (widget.title == 'Freight Origin City') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.socity = newValue;
                        });
                      } else if (widget.title == 'Freight Destination City') {
                        setState(() {
                          widget.listItem = newValue;
                          appstate.sdcity = newValue;
                        });
                      }
                    },
                    items: widget.listdata.map((t) {
                      return DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            t,
                            style: TextStyle(color: fontcolor),
                          ),
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
