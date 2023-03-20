import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:transporter/components/searchcomponet.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/services/dbservices.dart';
import '../data/data.dart';
import '../models/state.dart';
import '../theme/theme.dart';
import 'screens.dart';

class FindCargo extends StatefulWidget {
  final UserModel userModel;

  const FindCargo({Key key, @required this.userModel}) : super(key: key);

  @override
  _FindCargoState createState() => _FindCargoState();
}

class _FindCargoState extends State<FindCargo> {
  List<CargoModel> cargoList = [];
  List<CargoModel> newcargoList = [];
  CountryModel destination;
  Packaging packaging;
  CargoType cargotype;
  CountryModel origin;
  @override
  void initState() {
    super.initState();
    getcargo();

    final appstate = Provider.of<AppState>(context, listen: false);
    appstate.getIToken();
  }

  void getcargo() {
    Dbservice.getallcargo().then((value) {
      setState(() {
        cargoList = value.where((c) => c.status == 'available').toList();
        newcargoList = value.where((c) => c.status == 'available').toList();
      });
    });
  }

  List<String> searchoptions = [];
  void filtercargo(String field) {
    searchoptions.add(field);

    if (field == 'destination') {
      setState(() {
        if (newcargoList.isEmpty) {
          newcargoList = cargoList
              .where((c) => c.fdcountry.toString() == destination.name)
              .toList();
        } else {
          newcargoList = newcargoList
              .where((c) => c.fdcountry.toString() == destination.name)
              .toList();
        }
      });
    } else if (field == 'origin') {
      setState(() {
        if (newcargoList.isEmpty) {
          newcargoList = cargoList
              .where((c) => c.focountry.toString() == origin.name)
              .toList();
        } else {
          newcargoList = newcargoList
              .where((c) => c.focountry.toString() == origin.name)
              .toList();
        }
      });
    } else if (field == 'package') {
      setState(() {
        if (newcargoList.isEmpty) {
          newcargoList = cargoList
              .where((c) => c.packagetype.toString() == packaging.name)
              .toList();
        } else {
          newcargoList = newcargoList
              .where((c) => c.packagetype.toString() == packaging.name)
              .toList();
        }
      });
    } else if (field == 'cargotype') {
      setState(() {
        if (newcargoList.isEmpty) {
          newcargoList = cargoList
              .where((c) => c.cargotype.toString() == cargotype.name)
              .toList();
        } else {
          newcargoList = newcargoList
              .where((c) => c.cargotype.toString() == cargotype.name)
              .toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Find Cargo",
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                color: Colors.white,
                fontSize: fontsize1,
                fontWeight: FontWeight.w500),
          ),
        ),

        // bottom: upperTab,
      ),
      body: cargoList.isEmpty
          ? Center(
              child: Text(
                "Ooops no cargo available",
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: fontsize1,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      children: [
                        Container(
                          color: backgroundcolor,
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * .16,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch());
                                    },
                                    child: Container(
                                      color: backgroundcolor,
                                      width: MediaQuery.of(context).size.width *
                                          .75,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .08,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .05,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(5.00),
                                            border: Border.all(
                                              width: 1.00,
                                              color: const Color(0xff707070),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    Icons.search_outlined),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Search Cargo eg :Nairobi",
                                                  style: GoogleFonts.nunitoSans(
                                                    textStyle: const TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: fontsize2,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    height: MediaQuery.of(context).size.height *
                                        .08,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: maincolor2,
                                            borderRadius:
                                                BorderRadius.circular(5.00),
                                            border: Border.all(
                                              width: 1.00,
                                              color: const Color(0xff707070),
                                            ),
                                          ),
                                          child: Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    newcargoList = cargoList;
                                                    destination = null;
                                                    origin = null;
                                                    packaging = null;
                                                    cargotype = null;
                                                  });
                                                },
                                                icon: Icon(
                                                  Ionicons.trash_bin_outline,
                                                  color: maincolor,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: maincolor2,
                                          borderRadius:
                                              BorderRadius.circular(5.00),
                                        ),
                                        height: 40,
                                        width: 180,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Not necessary for Option 1
                                          value: origin,
                                          hint: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Origin"),
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              origin = newValue;
                                            });
                                            filtercargo('origin');
                                          },
                                          items: appstate.countries.map((t) {
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(t.name),
                                              ),
                                              value: t,
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: maincolor2,
                                          borderRadius:
                                              BorderRadius.circular(5.00),
                                        ),
                                        height: 40,
                                        width: 160,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Not necessary for Option 1
                                          value: destination,
                                          hint: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Destination"),
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              destination = newValue;
                                            });
                                            filtercargo('destination');
                                          },
                                          items: appstate.countries.map((t) {
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(t.name),
                                              ),
                                              value: t,
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: maincolor2,
                                          borderRadius:
                                              BorderRadius.circular(5.00),
                                        ),
                                        height: 40,
                                        width: 160,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Not necessary for Option 1
                                          value: packaging,
                                          hint: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Package"),
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              packaging = newValue;
                                            });
                                            filtercargo('package');
                                          },
                                          items: appstate.packagings.map((t) {
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(t.name),
                                              ),
                                              value: t,
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: maincolor2,
                                          borderRadius:
                                              BorderRadius.circular(5.00),
                                        ),
                                        height: 40,
                                        width: 160,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Not necessary for Option 1
                                          value: cargotype,
                                          hint: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Cargo Type"),
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              cargotype = newValue;
                                            });
                                            filtercargo('cargotype');
                                          },
                                          items: appstate.cargoTypes.map((t) {
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(t.name),
                                              ),
                                              value: t,
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Row(children: [
                                    Text(
                                      "Total Available Cargo:",
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: fontsize1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        "${newcargoList.length}",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                              color: Colors.black45,
                                              fontSize: fontsize1,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ]),
                                ),
                              ),
                              Container(
                                color: maincolor2,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .065,
                                child: Row(children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Origin",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(
                                          color: Colors.black45,
                                          fontSize: fontsize1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Destination",
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: fontsize1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return CargoDetails(
                                    cargoDetails: newcargoList[index],
                                    userModel: widget.userModel,
                                  );
                                }));
                              },
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                              title: Row(
                                children: [
                                  Text(
                                    "${newcargoList[index].focountry}, ${newcargoList[index].focity}",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: fontsize2,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${newcargoList[index].fdcountry}, ${newcargoList[index].fdcity}",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: fontsize2,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (__, index) => const Divider(),
                        itemCount: newcargoList.length),
                  ),
                ],
              ),
            ),
    );
  }
}
