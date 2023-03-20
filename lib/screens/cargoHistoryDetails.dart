import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:transporter/components/componets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/services/dbservices.dart';
import 'package:transporter/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../data/data.dart';
import '../models/models.dart';

class CargoHistoryDetails extends StatefulWidget {
  final dynamic cargoHistoryDetails;
  final UserModel userModel;
  // final CollectionModel collection;

  const CargoHistoryDetails(
      {Key key,
      this.cargoHistoryDetails,
      // this.collection,
      @required this.userModel})
      : super(key: key);

  @override
  _CargoHistoryDetailsState createState() => _CargoHistoryDetailsState();
}

class _CargoHistoryDetailsState extends State<CargoHistoryDetails> {
  final formKey = GlobalKey<FormState>();
  CargoModel cargo;
  bool isLoading = false;
  bool isCollected = false;

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  addlist(list) {
    var t = 0;
    for (var i = 0, _len = list.length; i < _len; i++) {
      t += int.parse(list[i].amount.split('.')[0]);
    }
    return t;
  }

  String formatTimestamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }

  void showCargoownerDetails(AppState appstate, UserModel cargoowner) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 300.0,
          color: const Color(0xFF737373),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Ionicons.person_circle_outline,
                          color: fontcolor2, size: 50),
                      title: Text(
                        cargoowner.names,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        cargoowner.phoneno,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(
                                cargoowner.phoneno);
                          },
                          icon: const Icon(Icons.call)),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Ionicons.person_circle_outline,
                          color: fontcolor2, size: 50),
                      title: Text(
                        cargoowner.names,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        cargoowner.altphoneno,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(
                                cargoowner.altphoneno);
                          },
                          icon: const Icon(Icons.call)),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              )),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Dbservice.getallcargoid(widget.cargoHistoryDetails.toString())
        .then((value) => setState(() {
              cargo = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return cargo == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: maincolor,
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              title: Text(
                "Cargo ${cargo.id}",
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: fontsize1,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cargo Details",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              fontSize: fontsize1, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SmallCargoText(
                    title: "Cargo Type",
                    text: cargo.cargotype,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Cargo Name",
                    text: cargo.cargoname,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Package Type",
                    text: cargo.packagetype,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Gross Weight",
                    text: '${cargo.gweight} Tonnes',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Description",
                    text: cargo.adinfo,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Address Details",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              fontSize: fontsize1, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SmallCargoText(
                    title: "Freight Origin Country",
                    text: cargo.focountry,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Freight Origin City",
                    text: cargo.focity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Date of Pick Up",
                    text: DateFormat.yMMMd()
                            .format(DateTime.parse(cargo.dopickup)) ??
                        'hakna',
                    // text: cargo.dopickup.toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Freight Destination Country",
                    text: '${cargo.fdcountry}',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                      title: "Freight Destination City", text: cargo.fdcity),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Payment Details",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              fontSize: fontsize1, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SmallCargoText(
                    title: "Currency",
                    text: cargo.currency,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallCargoText(
                    title: "Rate",
                    text: cargo.rate,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () {
                        Dbservice.getcargoownerwithid(cargo.owner)
                            .then((value) {
                          showCargoownerDetails(appstate, value);
                        });
                      },
                      child: Container(
                        height: 45.00,
                        // width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: maincolor,
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                        child: Center(
                          child: Text(
                            "SEE DETAILS",
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                  color: backgroundcolor,
                                  fontSize: fontsize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
