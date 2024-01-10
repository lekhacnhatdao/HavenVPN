import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/page/main/server_page/server_page.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';
import 'package:openvpn/presentations/widget/impl/Customprenium.dart';
import 'package:openvpn/presentations/widget/impl/app_thapgiac_text.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';

class VpnPage extends StatefulWidget {
  const VpnPage({
    super.key,
  });

  @override
  State<VpnPage> createState() => _VpnPageState();
}

class _VpnPageState extends State<VpnPage> {
  late Timer? _timer = null;
  bool _dialogShown = false;
  Timer? _connectingTimer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().startBilling();
      _maintenancePopup();
    });
    setState(() {});

  }

Future<void> _maintenancePopup() async {
  await Future.delayed(const Duration(seconds: 7));
  if (!this.mounted) {
    return;
  }
   if ( context.read<AppCubit>().state.currentServer?.flag.isEmpty ?? true &&!_dialogShown) {
    Future.microtask(() {
      _showMaintenanceDialog();
    });
  }
  _timer = Timer.periodic(const Duration(seconds: 60), (Timer timer) {
    context.read<AppCubit>().fetchServerList();
    if (context.read<AppCubit>().state.servers.isEmpty && !_dialogShown) {
      Future.microtask(() {
        _showMaintenanceDialog();
      });
    }
  });
}

  void _showMaintenanceDialog() {
    if (!this.mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _dialogShown = true;
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Network Error'),
            ],
          ),
          content: const Text(
              textAlign: TextAlign.center,
              'We are maintaining the system to upgrade the server. Please try again later'),
          actions: <Widget>[
            AppButtons(
                textColor: AppColors.primary,
                text: "Close",
                backgroundColor: AppColors.colorRed,
                onPressed: () {
                  Navigator.pop(context);
                  _dialogShown = false;
                }),
          ],
        );
      },
    );
  }

  void _showDisconnectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _dialogShown = true;
        return AlertDialog(
          title: const Text('Oops! Sorry (-_-)'),
          content: const Text(
              'This server is currently down, please disconnect and choose other server'),
          actions: <Widget>[
            AppButtons(
                textColor: AppColors.primary,
                text: "Disconnect",
                backgroundColor: AppColors.colorRed,
                onPressed: () {
                  _handleConnectButtonPressed();
                  // Navigator.pop(context);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  _dialogShown = false;
                }),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double halfScreenHeight = screenHeight / 2.5;

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 10),
            //   height: halfScreenHeight,
            //   decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.all(Radius.circular(10)),
            //     color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
            //   ),
            //   child: Column(
            //     children: [
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       const Text(
            //         'VPN connection',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       const SizedBox(height: 20),
            //       Expanded(
            //           child: Padding(
            //         padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
            //         child: GridView.builder(
            //           gridDelegate:
            //               const SliverGridDelegateWithMaxCrossAxisExtent(
            //                   maxCrossAxisExtent: 30,
            //                   mainAxisSpacing: 1,
            //                   childAspectRatio: 1,
            //                   crossAxisSpacing: 1),
            //           itemBuilder: (context, index) =>
            //               Center(child: BuildList(state.duration[index])),
            //           itemCount: state.duration.length,
            //         ),
            //       )),
            //       state.titleStatus == 'Not connected'
            //           ? const Text(
            //               'Your IP exposed to danger!',
            //               style: TextStyle(color: Color(0xffD62828)),
            //             )
            //           : state.isConnecting
            //               ? const Text(
            //                   'Your IP exposed to danger!',
            //                   style: TextStyle(color: Color(0xffD62828)),
            //                 )
            //               : const Text(
            //                   'Your IP is hidden, you are now very secure!',
            //                   style: TextStyle(color: Color(0xff119822)),
            //                 ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       const Dash(
            //           dashThickness: 2,
            //           dashLength: 10,
            //           dashGap: 6,
            //           length: 320,
            //           direction: Axis.horizontal,
            //           dashColor: Color(0xff2F2F2F)),
            //       const SizedBox(height: 10),
            //       Row(
            //         children: [
            //           const SizedBox(width: 8),
            //           const SizedBox(
            //             width: 8,
            //           ),
            //           Expanded(
            //             child: ClipRRect(
            //               borderRadius:
            //                   const BorderRadius.all(Radius.circular(16)),
            //               child: Column(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 40),
            //                     child: AppLabelText(
            //                       icon: Appicon.upload,
            //                       text: Strings.download,
            //                       coloricon: const Color(0xff08A045),
            //                       size: 10,
            //                       color: AppColors.textSecondary,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 8),
            //                   AppTitleText(
            //                       text: state.byteOut,
            //                       size: 28,
            //                       color: Colors.white)
            //                 ],
            //               ),
            //             ),
            //           ),
            //           const Dash(
            //               dashThickness: 2,
            //               dashLength: 10,
            //               length: 70,
            //               dashGap: 6,
            //               direction: Axis.vertical,
            //               dashColor: Color(0xff2F2F2F)),
            //           const SizedBox(width: 8),
            //           Expanded(
            //             child: ClipRRect(
            //               borderRadius:
            //                   const BorderRadius.all(Radius.circular(16)),
            //               child: Container(
            //                 child: Column(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 40),
            //                       child: AppLabelText(
            //                         icon: Appicon.download,
            //                         coloricon: const Color(0xffF6AA1C),
            //                         text: Strings.upload,
            //                         size: 10,
            //                         color: AppColors.textSecondary,
            //                       ),
            //                     ),
            //                     const SizedBox(height: 8),
            //                     AppTitleText(
            //                       text: state.byteIn,
            //                       size: 28,
            //                       color: Colors.white,
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 8),
            //         ],
            //       ),
            //       const Spacer(),
            //       const Spacer(),
            //       const SizedBox(height: 32),
            //     ],
            //   ),
            // ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
                  color: state.titleStatus == 'Connected'
                      ? const Color(0xff0ae2a5)
                      : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1, color: const Color(0xff0ae2a5))),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const ServerPage();
                    }));
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 60),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        child: Image.asset(
                          state.currentServer?.flag ?? Assets.images.logo.path,
                          height: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        state.currentServer?.country ?? 'Fastest Server',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            LoadingButtons(
              isDisconnect: state.titleStatus == 'Not connected',
              isLoading: state.isConnecting,
              icon: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.bolt_outlined,
                  size: 50,
                ),
              ),
              text: 'connecting',
              onPressed: state.isConnecting
                  ? null
                  : () async {
                      await context.read<AppCubit>().toggle();
                      if (state.isConnecting) {
                        _connectingTimer ??=
                            Timer(const Duration(seconds: 15), () {
                          _showDisconnectDialog();
                        });
                      } else {
                        _connectingTimer?.cancel();
                        _connectingTimer = null;
                      }
                    },
              changeUI: state.titleStatus == 'Not connected',
            ),
            const SizedBox(
              height: 20,
            ),

            Column(
              children: [
                Text(
                  'status: ${state.titleStatus == 'Not connected' ? 'Tap on the button to connect with server' : state.titleStatus}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                state.titleStatus == 'Not connected'
                    ? const SizedBox()
                    : Text(
                        'Time: ${state.duration}',
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/ 6,
            ),
            const Custompretimum(),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget BuildList(String d) {
    bool flag = false;
    if (d == ':') {
      flag = true;
    }
    return Row(
      children: [
        CustomPaint(painter: MyPainter()),
        const SizedBox(),
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: flag ? Colors.transparent : Colors.black,
          ),
          child: Text(
            d,
            style: const TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _navigateToSelectLocation() {
    AutoRouter.of(context).push(const ServerRoute());
  }

  void _handleConnectButtonPressed() {
    context.read<AppCubit>().toggle();
  }
}
