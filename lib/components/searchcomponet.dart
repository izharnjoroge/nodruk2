import 'package:provider/provider.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/services/dbservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transporter/data/data.dart';

import '../models/state.dart';
import '../screens/screens.dart';

class DataSearch extends SearchDelegate {
  // Stream share;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = "")
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final appstate = Provider.of<AppState>(context, listen: false);
    return query.isEmpty
        ? const Center(child: Text('Type your search above'))
        : StreamBuilder(
            stream: cargoref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return const Text('Something went wrong');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1,
                ));
              }

              var len = snapshot.data.docs.length;
              if (len == 0) {
                return Column(
                  children: const [
                    SizedBox(height: 100),
                    Center(
                      child: Text("Oooops...",
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                    )
                  ],
                );
              }

              List<CargoModel> cargo = snapshot.data.docs
                  .map((doc) => CargoModel(
                      id: doc.id,
                      cargotype: doc["cargotype"],
                      packagetype: doc["packagetype"],
                      requestcost: doc["requestcost"],
                      status: doc["status"],
                      owner: doc["owner"],
                      gweight: doc["gweight"],
                      cargoname: doc["cargoname"],
                      focountry: doc["focountry"],
                      focity: doc["focity"],
                      fdcountry: doc["fdcountry"],
                      fdcity: doc["fdcity"],
                      dopickup: doc["dopickup"],
                      currency: doc["currency"],
                      rate: doc["rate"],
                      adinfo: doc['adinfo']))
                  .toList();
              cargo = cargo
                  .where((s) =>
                      s.focountry.toLowerCase().contains(query.toLowerCase()) ||
                      s.focity.toLowerCase().contains(query.toLowerCase()) ||
                      s.fdcity.toLowerCase().contains(query.toLowerCase()) ||
                      s.fdcountry.toLowerCase().contains(query.toLowerCase()))
                  .toList();

              return ListView.builder(
                itemCount: cargo.length,
                shrinkWrap: true,
                primary: false,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int i) {
                  return cargo[i].status != 'available'
                      ? const SizedBox.shrink()
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: .50,
                              color: const Color.fromARGB(255, 177, 175, 175),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .08,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CargoDetails(
                                  userModel: appstate.userModel,
                                  cargoDetails: cargo[i],
                                );
                              }));
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${cargo[i].focountry}, ${cargo[i].focity}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: fontsize2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${cargo[i].fdcountry}, ${cargo[i].fdcity}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: fontsize2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.arrow_forward_ios_outlined),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                },
              );
            });
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final appstate = Provider.of<AppState>(context, listen: false);
    return query.isEmpty
        ? const Center(child: Text('Type your search above'))
        : StreamBuilder(
            stream: cargoref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return const Text('Something went wrong');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1,
                ));
              }

              var len = snapshot.data.docs.length;
              if (len == 0) {
                return Column(
                  children: const [
                    SizedBox(height: 100),
                    Center(
                      child: Text("Oooops...",
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                    )
                  ],
                );
              }

              List<CargoModel> cargo = snapshot.data.docs
                  .map((doc) => CargoModel(
                      id: doc.id,
                      cargotype: doc["cargotype"],
                      packagetype: doc["packagetype"],
                      requestcost: doc["requestcost"],
                      status: doc["status"],
                      owner: doc["owner"],
                      gweight: doc["gweight"],
                      cargoname: doc["cargoname"],
                      focountry: doc["focountry"],
                      focity: doc["focity"],
                      fdcountry: doc["fdcountry"],
                      fdcity: doc["fdcity"],
                      dopickup: doc["dopickup"],
                      currency: doc["currency"],
                      rate: doc["rate"],
                      adinfo: doc['adinfo']))
                  .toList();
              cargo = cargo
                  .where((s) =>
                      s.focountry.toLowerCase().contains(query.toLowerCase()) ||
                      s.focity.toLowerCase().contains(query.toLowerCase()) ||
                      s.fdcity.toLowerCase().contains(query.toLowerCase()) ||
                      s.fdcountry.toLowerCase().contains(query.toLowerCase()))
                  .toList();

              return ListView.builder(
                itemCount: cargo.length,
                shrinkWrap: true,
                primary: false,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int i) {
                  return cargo[i].status != 'available'
                      ? const SizedBox.shrink()
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: .50,
                              color: const Color.fromARGB(255, 177, 175, 175),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .08,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CargoDetails(
                                  userModel: appstate.userModel,
                                  cargoDetails: cargo[i],
                                );
                              }));
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${cargo[i].focountry}, ${cargo[i].focity}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: fontsize2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${cargo[i].fdcountry}, ${cargo[i].fdcity}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: fontsize2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.arrow_forward_ios_outlined),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                },
              );
            });
  }
}
