import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openvpn/presentations/page/billing/premium_page.dart';
import 'package:openvpn/resources/assets.gen.dart';

class Custompretimum extends StatefulWidget {
  const Custompretimum({super.key});

  @override
  State<Custompretimum> createState() => _CustompretimumState();
}

class _CustompretimumState extends State<Custompretimum> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PremiumPage()));
      },
      child: Container(
        height: 100,
        
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10 ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xff6928d2),
              ),
              child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const   Spacer(),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   
                      Text(
                        'Go Prenium',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ],
                  ),
             SizedBox(width: MediaQuery.of(context).size.width/10,),
              
                  TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width/28,
              right: MediaQuery.of(context).size.width/1.3
               ,
              child:       Container(
                padding: const EdgeInsets.all(5),
                
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                
                ),
                child: Container(
                          padding: const EdgeInsets.all(37),
                         
                        decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/crown.png', ), fit: BoxFit.contain ),
                          shape: BoxShape.circle,
                          color: Colors.red
                        ),
                         ),
              ),)
          ],
        ),
      ),
      
    );
  }
}
