// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/models/responses/create_order_response_model.dart';
import 'package:travelly/presentation/explore/dialogs/success_payment_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final CreateOrderResponseModel data;
  const PaymentPage({
    super.key,
    required this.data,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _controller;
  bool isLoading = false;
  Future<void> _handlePaymentSuccess() async {
    showDialog(
        context: context, builder: (context) => const SuccessPaymentDialog());
  }

  Future<void> _handlePaymentFailure() async {
    context.showDialogError(
      'Pembayaran Gagal',
      'Ops. Terjadi kesalahan, mohon ulangi sesaat lagi ya, Sob.',
    );

    if (mounted) {
      context.popToRoot();
    }
  }

  @override
  void initState() {
    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params);
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() => isLoading = true);
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
            debugPrint('Page finished loading: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('request: ${request.url}');
            if (request.url.contains('status_code=200') &&
                request.url.contains('transaction_status=settlement')) {
              _handlePaymentSuccess();
              return NavigationDecision.prevent;
            } else {
              _handlePaymentFailure();
              return NavigationDecision.prevent;
            }
            // if (request.url.contains('flutter/success')) {
            //   log("URL MIDTRANS: ${request.url}");

            //   return NavigationDecision.prevent;
            // } else if (request.url.contains('flutter/failure')) {
            //   _handlePaymentFailure();
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            debugPrint('url change: ${change.url}');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.data.data!.paymentUrl!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // return Scaffold(
  //   //     backgroundColor: AppColors.lightBackground,
  //   //     appBar: AppBar(
  //   //       leading: IconButton(
  //   //         onPressed: () {
  //   //           context.pop();
  //   //         },
  //   //         icon: const Icon(
  //   //           Icons.arrow_back,
  //   //           color: AppColors.white,
  //   //         ),
  //   //       ),
  //   //       backgroundColor: AppColors.primary,
  //   //       title: const Text(
  //   //         "Pembayaran",
  //   //         style: TextStyle(
  //   //           color: AppColors.white,
  //   //           fontSize: 16.0,
  //   //           fontWeight: FontWeight.w600,
  //   //         ),
  //   //       ),
  //   //       centerTitle: true,
  //   //       actions: const [],
  //   //     ),
  //   //     bottomNavigationBar: Container(
  //   //         height: 200,
  //   //         padding: const EdgeInsets.symmetric(
  //   //           vertical: 22,
  //   //           horizontal: 16,
  //   //         ),
  //   //         width: context.deviceWidth,
  //   //         decoration: const BoxDecoration(
  //   //           color: AppColors.white,
  //   //         ),
  //   //         child: Column(
  //   //           children: [
  //   //             Button.filled(
  //   //               textColor: AppColors.white,
  //   //               fontSize: 14.0,
  //   //               onPressed: () {},
  //   //               label: 'Batalkan',
  //   //               color: AppColors.red,
  //   //             ),
  //   //             const SpaceHeight(12),
  //   //             Button.filled(
  //   //               textColor: AppColors.white,
  //   //               fontSize: 14.0,
  //   //               onPressed: () {
  //   //                 context.pushReplacement(const HomePage());
  //   //               },
  //   //               label: 'Home',
  //   //               color: AppColors.primary,
  //   //             ),
  //   //           ],
  //   //         )),
  //   //     body: ListView(
  //   //       children: [

  //   //         Container(
  //   //           width: context.deviceWidth,
  //   //           padding: const EdgeInsets.all(16.0),
  //   //           decoration: const BoxDecoration(
  //   //             color: AppColors.white,
  //   //           ),
  //   //           child: const Column(
  //   //             crossAxisAlignment: CrossAxisAlignment.start,
  //   //             children: [
  //   //               Text(
  //   //                 "Pesanan",
  //   //                 style: TextStyle(
  //   //                   fontSize: 14.0,
  //   //                   fontWeight: FontWeight.w600,
  //   //                   color: AppColors.textBlack2,
  //   //                 ),
  //   //               ),
  //   //               SpaceHeight(
  //   //                 8,
  //   //               ),
  //   //               Text(
  //   //                 "[WEEKEND & HIGH SEASON] Tiket Jatim Park 1 + Museum Tubuh",
  //   //                 style: TextStyle(
  //   //                   fontSize: 14.0,
  //   //                   fontWeight: FontWeight.w600,
  //   //                   color: AppColors.textBlack2,
  //   //                 ),
  //   //               ),
  //   //               SpaceHeight(
  //   //                 8,
  //   //               ),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text(
  //   //                     "Rp. 113.000",
  //   //                     style: TextStyle(
  //   //                       fontSize: 12.0,
  //   //                       color: AppColors.textBlack2,
  //   //                     ),
  //   //                   ),
  //   //                   Text(
  //   //                     "1x",
  //   //                     style: TextStyle(
  //   //                       fontSize: 12.0,
  //   //                       fontWeight: FontWeight.w600,
  //   //                       color: AppColors.textBlack2,
  //   //                     ),
  //   //                   ),
  //   //                 ],
  //   //               ),
  //   //               SpaceHeight(8),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text(
  //   //                     "Total",
  //   //                     style: TextStyle(
  //   //                       fontSize: 12.0,
  //   //                       fontWeight: FontWeight.w600,
  //   //                       color: AppColors.textBlack2,
  //   //                     ),
  //   //                   ),
  //   //                   Text(
  //   //                     "Rp 113.000",
  //   //                     style: TextStyle(
  //   //                       fontSize: 12.0,
  //   //                       fontWeight: FontWeight.w600,
  //   //                       color: AppColors.textBlack2,
  //   //                     ),
  //   //                   ),
  //   //                 ],
  //   //               ),
  //   //             ],
  //   //           ),
  //   //         ),
  //   //         Image.asset(
  //   //           Assets.images.paymentWebview.path,
  //   //           width: context.deviceWidth,
  //   //           fit: BoxFit.cover,
  //   //         ),
  //   //       ],
  //   //     ));
  // }
}
