import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/page/main/history_page.dart';
import 'package:openvpn/presentations/page/main/inforserver.dart';
import 'package:openvpn/presentations/page/main/settingpage.dart';
import 'package:openvpn/presentations/page/main/speedtest.dart';
import 'package:openvpn/presentations/page/main/vpn_page.dart';
import 'package:openvpn/presentations/widget/impl/custombar.dart';
import 'package:openvpn/utils/config.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: state.isLoading
                      ? [
                          Colors.white,
                          Colors.grey,
                        ]
                      : state.titleStatus == 'Connected'
                          ? [Colors.white, const Color(0xff5cffd1)]
                          : [Colors.white, Colors.grey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SafeArea(
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title:  Row(
                    children: [
                      const Image(
                        image: AssetImage('assets/images/5.png'),
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      Text('${ Config.appName.split('T').last}'  ,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),

                  // BlocBuilder<AppCubit, AppState>(
                  //   builder: (context, state) {
                  //     return Container(
                  //       decoration: const BoxDecoration(
                  //         boxShadow: <BoxShadow>[
                  //           BoxShadow(
                  //             color: Colors.white12,
                  //             blurRadius: 10,
                  //           ),
                  //         ],
                  //         borderRadius: BorderRadius.all(Radius.circular(100)),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       child: CachedNetworkImage(
                  //         imageUrl: state.currentServer?.flag ?? 'assets/images/Frame.png',
                  //         height: 32,
                  //       ),
                  //     );
                  //   },
                  // )
                ),
                body: Column(
                  children: [
                    Expanded(
                      child:
                          TabBarView(controller: controller, children: const [
                        VpnPage(),
                        InforServer(),
                        HistoryPage(),
                        Speedtestpage(),
                        SettingPage(),
                      ]),
                    ),
                    CustomBottomBar(
                      controller: controller,
                      listIcon: const [
                        Icons.bolt_rounded,
                        Icons.info,
                        Icons.history_outlined,
                        Icons.radar,
                        Icons.settings,
                      ],
                      onSelect: (index) {
                        return controller.animateTo(index);
                      },
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
