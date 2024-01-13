import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openvpn/presentations/widget/impl/CstomanimationButton.dart';
import 'package:openvpn/resources/assets.gen.dart';
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
                    shape: BoxShape.circle,
                    // ignore: lines_longer_than_80_chars
                    gradient: LinearGradient(
                      colors: isLoading
                          ? [
                             Colors.black, 
                            Colors.black 
                            ]
                          : changeUI
                              ? [
                                Colors.black, 
                            Colors.black
                                ]
                              : [
                                Colors.pink,const Color(0xff6928d2),
                                ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    )),
              ),
            ),
            Positioned(
             
              child: Align(
                child: Container(
                  decoration:  const BoxDecoration(
                    shape: BoxShape.circle,
                    color:  Colors.transparent,
                  ),
                  padding: const EdgeInsets.all(23),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => const LinearGradient(
                      
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: 
                         [Colors.white, Colors.white],
                    ).createShader(bounds),
                    child:
                           Align(child: isLoading? Container(
                  height: 100,
                      decoration: const BoxDecoration(
                    
                        image: DecorationImage(image: AssetImage('assets/images/giphy.gif'),
                        
                        ),
                        shape: BoxShape.circle
                      ),
                    ): icon) 
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
