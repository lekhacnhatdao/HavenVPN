import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/widget/impl/Gradient.dart';
import 'package:openvpn/presentations/widget/impl/custompretimum.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/strings.dart';

@RoutePage()
class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        backgroundColor: const Color(0xff6928d2),
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const AppTitleText(
            text: Strings.benefitsOfThePremium,
            color: Colors.white,
          ),
        ),
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Assets.images.huychuong.image(height: 150),
                  _buildSubscriptionItem(state.subscriptions, state),
                   const SizedBox(
                          height: 30,
                        ),
                  
                  Container(
                    margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10) +
                        const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.only(top: 0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: const Column(
                      children: [
                         
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Highlights of the premium subscription ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                          CustomPretimum(
                          text: Strings.removeAds,
                          
                         ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomPretimum(
                          text: Strings.superFastServer,
                          
                         ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomPretimum(
                          text: Strings.unlockAllPremium,
                          
                         ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomPretimum(
                          text: Strings.customerSupport,
                         
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      
                       
                        
                        
                        SizedBox(height: 20),
                     
                       
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Your access will be automatically charged to your preferred payment method on file unless explicitly canceled at least 24 hours before the current period's expiration. To manage your ongoing subscription or make adjustments, please visit your Account Settings after purchase.",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          
        ),
       bottomNavigationBar: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
         
         return    Container(
          padding: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.width/3.3,
           child: state.subscriptions.isEmpty
                              ? Container(
                              
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 16) +
                                          const EdgeInsets.only(bottom: 24),
                                  child: const Column(
                                    children: [
                                      AppTitleText(
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        text:
                                            'We are currently experiencing technical difficulties. Our service will be back up and running soon. Please try again later.',
                                      )
                                    ],
                                  ),
                                )
                              : AppButtons(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                                  text: Strings.getPremiumNow,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.brown,
                                  onPressed: () async {
                                    await context.read<AppCubit>().subscribe();
                                  },
                                ),
         );
       },),
      ),
    );
  }

  Widget _buildSubscriptionItem(
      List<ProductDetails> subscriptions, AppState state) {
    // if (subscriptions.isEmpty) {
    //   // If subscriptions list is empty, provide default values for display
    //   subscriptions = [
    //     ProductDetails(
    //       id: 'default_id_1',
    //       title: 'No ads for a year',
    //       description: 'Default Description 1',
    //       price: '100.000đ',
    //       rawPrice: 100.00,
    //       currencyCode: 'VND',
    //     ),
    //   ];
    // }

    return Container(
    
      child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
        children: subscriptions.take(3).map((e) {
          return GestureDetector(
            onTap: () {
              context.read<AppCubit>().setSubscription(e);
            },
            child: Container(
          
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                  // border: GradientBoxBorder(
                  //   gradient: LinearGradient(
                  //     colors: state.selectedSubscription?.id == e.id
                  //         ? AppColors.listgradient
                  //         : [Colors.transparent, Colors.transparent],
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //   ),
                  // ),
                  border: Border.all(
                      width: 3,
                      color: state.selectedSubscription?.id == e.id
                          ? Colors.white
                          : Colors.transparent)),
            padding: const EdgeInsets.only( left: 70, right: 70),
              child: Column(
                children: [
                  Assets.images.crown.image(height: 20),
                  const SizedBox(
                    height: 5,
                  ),
                  state.selectedSubscription?.id == e.id
                      ? Text('${e.title.split('(').firstOrNull ?? ''}',
                          style:
                              const TextStyle(color: Colors.brown, fontSize: 15))
                      : Align(
                          child: Text(
                            e.title.split('(').firstOrNull ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                  const SizedBox(height: 10),
                  state.selectedSubscription?.id == e.id
                      ? Text('${e.price}',
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 25,
                          ))
                      : Text(
                          ' ${e.price}',
                          style: const TextStyle(
                            fontSize: 25,
                            color: AppColors.primary,
                          ),
                        ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
