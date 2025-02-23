// import 'package:flutter/material.dart';
// import 'package:travelly/core/assets/assets.gen.dart';
// import 'package:travelly/core/components/spaces.dart';
// import 'package:travelly/core/constants/colors.dart';
// import 'package:travelly/core/extensions/build_context_ext.dart';
// import 'package:travelly/core/utils/loading_indicator.dart';
// import 'package:travelly/presentation/explore/models/destination_model.dart';
// import 'package:travelly/presentation/explore/models/ticket_model.dart';
// import 'package:travelly/presentation/explore/widgets/card_destination.dart';

// // class AllWidget extends StatelessWidget {
// //   const AllWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final List<DestinationModel> destinations = [
// //       DestinationModel(
// //         name: "Ijen Trek Adventure",
// //         image: Assets.images.khamkeoHBFuMwNNV0Unsplash1.path,
// //         price: "120000",
// //         priceDiscount: "140000",
// //         location: "Banyuwangi",
// //         review: "8.8/10",
// //         ticktes: [
// //           TicketModel(
// //             title: "High Season - Tiket Masuk",
// //             category: "Dewasa",
// //             price: "120000",
// //             priceDiscount: "140000",
// //           ),
// //           TicketModel(
// //             title: "High Season - Tiket Masuk",
// //             category: "Anak",
// //             price: "80000",
// //             priceDiscount: "100000",
// //           ),
// //           TicketModel(
// //             title: "High Season - Tiket Masuk",
// //             category: "Pelajar/Mahasiswa",
// //             price: "100000",
// //             priceDiscount: "120000",
// //           ),
// //         ],
// //       ),
// //       DestinationModel(
// //         name: "Bromo Sunrise Tour",
// //         image: Assets.images.bromo.path,
// //         price: "200000",
// //         priceDiscount: "250000",
// //         location: "Probolinggo",
// //         review: "8.8/10",
// //         ticktes: [
// //           TicketModel(
// //             title: "Tiket VIP",
// //             category: "Dewasa",
// //             price: "200000",
// //             priceDiscount: "250000",
// //           ),
// //           TicketModel(
// //             title: "Tiket VIP",
// //             category: "Anak",
// //             price: "150000",
// //             priceDiscount: "200000",
// //           ),
// //           TicketModel(
// //             title: "Tiket VIP",
// //             category: "Pelajar/Mahasiswa",
// //             price: "180000",
// //             priceDiscount: "220000",
// //           ),
// //         ],
// //       ),
// //       DestinationModel(
// //         name: "Borobudur Temple Pass",
// //         image: Assets.images.borobudur.path,
// //         price: "40000",
// //         priceDiscount: "70000",
// //         location: "Magelang",
// //         review: "8.8/10",
// //         ticktes: [
// //           TicketModel(
// //             title: "Tiket Masuk Reguler",
// //             category: "Dewasa",
// //             price: "40000",
// //             priceDiscount: "70000",
// //           ),
// //           TicketModel(
// //             title: "Tiket Masuk Reguler",
// //             category: "Anak",
// //             price: "25000",
// //             priceDiscount: "50000",
// //           ),
// //           TicketModel(
// //             title: "Tiket Masuk Reguler",
// //             category: "Pelajar/Mahasiswa",
// //             price: "30000",
// //             priceDiscount: "60000",
// //           ),
// //         ],
// //       ),
// //     ];

// //     final List<DestinationModel> voucherDestinations = [
// //       DestinationModel(
// //         name: "Water Splash Day Pass",
// //         image: Assets.images.waterSplash.path,
// //         price: "150000",
// //         priceDiscount: "",
// //         location: "Bandung",
// //         review: "8.8/10",
// //         ticktes: [
// //           TicketModel(
// //             title: "Full Day Access",
// //             category: "Dewasa",
// //             price: "150000",
// //             priceDiscount: "200000",
// //           ),
// //           TicketModel(
// //             title: "Full Day Access",
// //             category: "Anak",
// //             price: "100000",
// //             priceDiscount: "150000",
// //           ),
// //           TicketModel(
// //             title: "Full Day Access",
// //             category: "Pelajar/Mahasiswa",
// //             price: "120000",
// //             priceDiscount: "160000",
// //           ),
// //         ],
// //       ),
// //       DestinationModel(
// //         name: "Adventure Fun Pass",
// //         image: Assets.images.adventure.path,
// //         price: "120000",
// //         priceDiscount: "180000",
// //         location: "Sleman",
// //         review: "8.8/10",
// //         ticktes: [
// //           TicketModel(
// //             title: "Daily Adventure Pass",
// //             category: "Dewasa",
// //             price: "120000",
// //             priceDiscount: "180000",
// //           ),
// //           TicketModel(
// //             title: "Daily Adventure Pass",
// //             category: "Anak",
// //             price: "90000",
// //             priceDiscount: "120000",
// //           ),
// //           TicketModel(
// //             title: "Daily Adventure Pass",
// //             category: "Pelajar/Mahasiswa",
// //             price: "100000",
// //             priceDiscount: "150000",
// //           ),
// //         ],
// //       ),
// //       DestinationModel(
// //         name: "Jungle Explore Ticket",
// //         image: Assets.images.jungleExploler.path,
// //         price: "50000",
// //         priceDiscount: "70000",
// //         location: "Malang",
// //         review: "8.8/10",
// //         ticktes: [
// //           TicketModel(
// //             title: "Explorer Pass",
// //             category: "Dewasa",
// //             price: "50000",
// //             priceDiscount: "70000",
// //           ),
// //           TicketModel(
// //             title: "Explorer Pass",
// //             category: "Anak",
// //             price: "35000",
// //             priceDiscount: "50000",
// //           ),
// //           TicketModel(
// //             title: "Explorer Pass",
// //             category: "Pelajar/Mahasiswa",
// //             price: "40000",
// //             priceDiscount: "60000",
// //           ),
// //         ],
// //       ),
// //     ];

// //     return Scaffold(
// //       body: ListView(
// //         children: [
// //           const Padding(
// //             padding: EdgeInsets.all(16.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   "Aktivitas Populer",
// //                   style: TextStyle(
// //                       fontSize: 16.0,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textBlack),
// //                 ),
// //                 Icon(
// //                   Icons.chevron_right_outlined,
// //                   color: Color(
// //                     0xff292D32,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //           Container(
// //             padding: const EdgeInsets.all(16.0),
// //             height: 260,
// //             child: ListView.separated(
// //               itemCount: destinations.length,
// //               scrollDirection: Axis.horizontal,
// //               separatorBuilder: (BuildContext context, int index) {
// //                 return const SpaceWidth(16);
// //               },
// //               itemBuilder: (BuildContext context, int index) {
// //                 return LoadingIndicator();
// //                 // return CardDestination(
// //                 //   event: destinations[index],
// //                 // );
// //               },
// //             ),
// //           ),
// //           const SpaceHeight(10),
// //           Stack(
// //             children: [
// //               Container(
// //                 height: 160,
// //                 width: context.deviceWidth,
// //                 decoration: const BoxDecoration(
// //                   gradient: LinearGradient(
// //                     begin: Alignment.topCenter,
// //                     end: Alignment.bottomCenter,
// //                     colors: [
// //                       AppColors.primary,
// //                       AppColors.white,
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               const Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Text(
// //                   "Voucher bermain di Ayo Piknik",
// //                   style: TextStyle(
// //                     fontSize: 16.0,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.textBlack,
// //                   ),
// //                 ),
// //               ),
// //               Container(
// //                 margin: const EdgeInsets.only(top: 40),
// //                 height: 260,
// //                 padding: const EdgeInsets.all(16.0),
// //                 width: context.deviceWidth,
// //                 child: ListView.separated(
// //                   itemCount: voucherDestinations.length,
// //                   scrollDirection: Axis.horizontal,
// //                   separatorBuilder: (BuildContext context, int index) {
// //                     return const SpaceWidth(16);
// //                   },
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return CardDestination(
// //                       destination: voucherDestinations[index],
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SpaceHeight(10),
// //           Stack(
// //             children: [
// //               Container(
// //                 height: 160,
// //                 width: context.deviceWidth,
// //                 decoration: const BoxDecoration(
// //                   gradient: LinearGradient(
// //                     begin: Alignment.topCenter,
// //                     end: Alignment.bottomCenter,
// //                     colors: [
// //                       AppColors.white,
// //                       AppColors.primary,
// //                       AppColors.white,
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               const Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Text(
// //                   "Rekomendasi dari Ayo Piknik",
// //                   style: TextStyle(
// //                     fontSize: 16.0,
// //                     fontWeight: FontWeight.w600,
// //                     color: Color(
// //                       0xff4B5563,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Container(
// //                 margin: const EdgeInsets.only(top: 40),
// //                 height: 260,
// //                 padding: const EdgeInsets.all(16.0),
// //                 width: context.deviceWidth,
// //                 child: ListView.separated(
// //                   itemCount: 4,
// //                   scrollDirection: Axis.horizontal,
// //                   separatorBuilder: (BuildContext context, int index) {
// //                     return const SpaceWidth(16);
// //                   },
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return CardDestination(
// //                       destination: voucherDestinations[index],
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
