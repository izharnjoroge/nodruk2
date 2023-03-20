// import 'package:transporter/components/componets.dart';
// import 'package:transporter/data/data.dart';
// import 'package:transporter/models/models.dart';
// import 'package:transporter/services/services.dart';
// import 'package:transporter/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../models/state.dart';

// class MobileMoney extends StatefulWidget {
//   final List<CountryModel> countries;
//   final UserModel userModel;

//   const MobileMoney({Key key, this.countries, @required this.userModel})
//       : super(key: key);

//   @override
//   _MobileMoneyState createState() => _MobileMoneyState();
// }

// class _MobileMoneyState extends State<MobileMoney> {
//   TextEditingController amountController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   bool isLoading = false;
//   bool loggededin = false;
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   void showInSnackBar(String txt) {
//     final snackBar = SnackBar(
//       content: Text(txt.toString()),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   Future<void> submit(BuildContext context, AppState appState) async {
//     final formField = formKey.currentState;

//     if (formField.validate()) {
//       formField.save();
//       setState(() {
//         isLoading = true;
//       });
//       return depositsref.add({
//         'phoneNumber': phoneController.text,
//         'agentNumber':null,
//         'cargoid':null,
        
//         'name':widget.userModel.names,
//         'amount': amountController.text,
//         'transactioncode': appState.userid,
//         'verified': false,
//         'date': DateTime.now(),
//         'account': widget.userModel.indno,
//         'method': 'mpesa'
//       }).then((value) {
//         showInSnackBar("Toped Up");
//         // appState.setUpwallet(appState.userid);
//         MyNavigator.goToHomePage(context, appState.userid);
//       }).catchError((error) => showInSnackBar("Failed to Add : $error"));
//     } else {
//       setState(() {
//         isLoading = false;
//       });

//       showInSnackBar('Ooooh no! Bad Input!');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appstate = Provider.of<AppState>(context);
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: maincolor,
//         title: Text(
//           "Mobile Money",
//           style: GoogleFonts.nunitoSans(
//             textStyle: const TextStyle(
//                 color: Colors.white,
//                 fontSize: fontsize1,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextInputComponent(
//                         title: "Phone Number",
//                         titleController: phoneController,
//                         height: 50,
//                         keyboardType: TextInputType.phone,
//                       ),
//                       TextInputComponent(
//                         title: "Amount",
//                         titleController: amountController,
//                         height: 50,
//                         keyboardType: TextInputType.number,
//                       ),
//                       const SizedBox(height: 30),
//                       loggededin
//                           ? const SizedBox.shrink()
//                           : GestureDetector(
//                               onTap: () {
//                                 submit(context, appstate);
//                               },
//                               child: Container(
//                                 height: 45.00,
//                                 // width: MediaQuery.of(context).size.width * .9,
//                                 decoration: BoxDecoration(
//                                   color: maincolor,
//                                   borderRadius: BorderRadius.circular(5.00),
//                                 ),
//                                 child: Center(
//                                   child: isLoading
//                                       ? const CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                         )
//                                       : Text(
//                                           "Load Wallet",
//                                           style: GoogleFonts.nunitoSans(
//                                             textStyle: TextStyle(
//                                                 color: backgroundcolor,
//                                                 fontSize: fontsize,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
