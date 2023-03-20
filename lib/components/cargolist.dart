import 'package:provider/provider.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/collectionModel.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/screens/cargoHistoryDetails.dart';
import 'package:transporter/services/dbservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class CagoList extends StatefulWidget {
  final String status;

  final UserModel userModel;
  const CagoList({Key key, this.status, @required this.userModel})
      : super(key: key);

  @override
  _CagoListState createState() => _CagoListState();
}

class _CagoListState extends State<CagoList> {
  static PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return RefreshIndicator(
      onRefresh: () async {
        refreshChangeListener.refreshed = true;
      },
      child: PaginateFirestore(
        // header: const SliverToBoxAdapter(child: Text('HEADER')),
        shrinkWrap: true,
        itemBuilder: (index, context, documentSnapshot) {
          CollectionModel collection =
              CollectionModel.fromDoc(documentSnapshot);

          return collection.transporterid != appstate.userModel.id
              ? const SizedBox.shrink()
              : ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CargoHistoryDetails(
                        cargoHistoryDetails: collection.cargoid,
                        userModel: widget.userModel,
                      );
                    }));
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  title: Row(
                    children: [
                      Text(
                        "${collection.focountry}, ${collection.focity}",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: fontsize2,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${collection.fdcountry}, ${collection.fdcity}",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: fontsize2,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
        },

        query: cargocollectiondataref.orderBy('date'),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
