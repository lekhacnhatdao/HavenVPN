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
import 'package:openvpn/presentations/widget/impl/backround.dart';
import 'package:openvpn/presentations/widget/impl/custombar.dart';
import 'package:openvpn/resources/assets.gen.dart';
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
        return  SafeArea(
            bottom: false,
            child: Custombackground(
              widget: Scaffold(
             
                appBar: AppBar(
                  actions: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>const HistoryPage()));
                      },
                      child: const Icon(Icons.history_toggle_off_rounded, color: Color(0xff6928d2)),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingPage()));
                    } ,child: const Icon(Icons.settings_outlined, color: Color(0xff6928d2),),),
                    const SizedBox(width: 10,),
                  ],
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title:  Row(
                    children: [
                       Assets.icons.logo.svg(height: 40),
                       const SizedBox(width: 3,),
                      Text('${ Config.appName.split('H').last}'  ,
                        style: const TextStyle(color: Color(0xff6928d2)),
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
                body: 
                          const VpnPage(),

                      
                    
              ),
            ));
      },
    );
  }
}
