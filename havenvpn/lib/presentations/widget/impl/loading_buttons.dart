import 'package:flutter/material.dart';
import 'package:openvpn/presentations/widget/impl/CstomanimationButton.dart';
import 'package:openvpn/resources/colors.dart';

class LoadingButtons extends StatelessWidget {
  const LoadingButtons({
    super.key,
    required this.isLoading,
    required this.icon,
    required this.text,
    this.backgroundColor = AppColors.accent,
    this.height = 52,
    this.onPressed,
    this.margin,
    required this.changeUI, required this.isDisconnect,
  });

  final bool isLoading;
  final bool changeUI;
  final bool isDisconnect;
  final Widget icon;
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return 
       GestureDetector(
        onTap: onPressed,
        child: Stack(
          children: [
            Align(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:isLoading?Colors.grey : isDisconnect?   Colors.grey: Color(0xff18daa3),
                      blurRadius: 4,
        spreadRadius: 5
                    )
                  ],
                    shape: BoxShape.circle,
                    // ignore: lines_longer_than_80_chars
                    gradient: LinearGradient(
                      colors: isLoading
                          ? [
                            const Color.fromARGB(255, 207, 207, 207), 
                            const Color.fromARGB(255, 175, 175, 175) 
                            ]
                          : changeUI
                              ? [
                                const Color.fromARGB(255, 207, 207, 207), 
                            const Color.fromARGB(255, 175, 175, 175)
                                ]
                              : [
                                  Colors.white,Color(0xff5cffd1)
                                ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    )),
              ),
            ),
            Positioned(
             
              child: Align(
                child: Container(
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color:  Colors.transparent,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => LinearGradient(
                      
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isLoading
                          ? [Colors.white,
                                  Colors.white,]
                          : changeUI
                              ? [Colors.white,
                                  Colors.white,
                                  
                                ]
                              : [Color.fromARGB(255, 5, 236, 171), Color(0xff18daa3)],
                    ).createShader(bounds),
                    child: isLoading
                        ? CustomAnimation()
                        : isDisconnect?  icon :  CustomAnimation()
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
