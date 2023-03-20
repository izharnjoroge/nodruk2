import 'package:transporter/data/data.dart';
import 'package:transporter/services/dbservices.dart';
import 'package:transporter/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../models/state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  String formatTimestamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
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
        title: Text(
          "Notifications",
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                color: Colors.white,
                fontSize: fontsize1,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refreshChangeListener.refreshed = true;
        },
        child: PaginateFirestore(
          // header: const SliverToBoxAdapter(child: Text('HEADER')),
          shrinkWrap: true,
          itemBuilder: (index, context, documentSnapshot) {
            NotificationModel notif =
                NotificationModel.fromDoc(documentSnapshot);

            return notif.to != appstate.userid
                ? const SizedBox.shrink()
                : ListTile(
                    title: Text(
                      notif.title,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black45,
                            fontSize: fontsize3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Text(
                      notif.content,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: fontsize3,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    trailing: Text(
                      formatTimestamp(notif.time),
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: fontsize3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
          },

          query: notificationref.orderBy('time'),
          isLive: true,
          itemBuilderType: PaginateBuilderType.listView,
        ),
      ),
    );
  }
}
